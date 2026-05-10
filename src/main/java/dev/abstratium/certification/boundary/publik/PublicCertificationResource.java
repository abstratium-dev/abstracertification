package dev.abstratium.certification.boundary.publik;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.eclipse.microprofile.openapi.annotations.tags.Tag;
import io.smallrye.mutiny.Multi;
import org.jboss.logging.Logger;

import dev.abstratium.certification.entity.AnswerOption;
import dev.abstratium.certification.entity.Certification;
import dev.abstratium.certification.entity.CertificationStep;
import dev.abstratium.certification.entity.Question;
import dev.abstratium.certification.service.CertificationService;
import dev.abstratium.certification.service.ChatService;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.StreamingOutput;

@Path("/public/certifications")
@Tag(name = "Public Certifications", description = "Public certification read endpoints")
public class PublicCertificationResource {

    private static final Logger LOG = Logger.getLogger(PublicCertificationResource.class);

    private static final ObjectMapper MAPPER = new ObjectMapper();

    @Inject
    CertificationService certificationService;

    @Inject
    ChatService chatService;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<CertificationSummary> getAll() {
        return certificationService.findAll().stream()
                .map(CertificationSummary::from)
                .toList();
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Certification getById(@PathParam("id") String id) {
        return certificationService.findByIdWithDetails(id);
    }

    /**
     * Checks submitted answers for a certification's questions.
     * Accepts a map of questionId -> selectedAnswerOptionId and returns
     * a map of questionId -> correct (boolean).
     */
    @POST
    @Path("/{id}/check-answers")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response checkAnswers(@PathParam("id") String id, CheckAnswersRequest request) {
        Certification cert = certificationService.findByIdWithDetails(id);
        if (cert == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }

        if (request == null || request.getAnswers() == null || request.getAnswers().isEmpty()) {
            return Response.status(Response.Status.BAD_REQUEST).build();
        }

        // Build a lookup: questionId -> correct answer option ID
        Map<String, String> correctAnswerByQuestion = new HashMap<>();
        for (CertificationStep step : cert.getSteps()) {
            for (Question question : step.getQuestions()) {
                for (AnswerOption option : question.getAnswerOptions()) {
                    if (Boolean.TRUE.equals(option.getIsCorrect())) {
                        correctAnswerByQuestion.put(question.getId(), option.getId());
                    }
                }
            }
        }

        // Check each submitted answer
        Map<String, Boolean> results = new HashMap<>();
        for (Map.Entry<String, String> entry : request.getAnswers().entrySet()) {
            String questionId = entry.getKey();
            String selectedOptionId = entry.getValue();
            String correctOptionId = correctAnswerByQuestion.get(questionId);
            results.put(questionId, correctOptionId != null && correctOptionId.equals(selectedOptionId));
        }

        return Response.ok(new CheckAnswersResponse(results)).build();
    }

    /**
     * Streaming chat endpoint for AI assistance using Claude API.
     * Accepts user messages with certification context and streams AI responses using SSE.
     */
    @POST
    @Path("/{id}/chat")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.SERVER_SENT_EVENTS)
    public Response chat(@PathParam("id") String id, ChatRequest request) {
        LOG.infof("Chat endpoint called for certification: %s, session: %s", id, request.getSessionId());
        
        // Validate request
        if (request == null || request.getMessage() == null || request.getMessage().trim().isEmpty()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .type(MediaType.APPLICATION_JSON)
                    .entity(Map.of("error", "Message is required"))
                    .build();
        }

        if (request.getSessionId() == null || request.getSessionId().trim().isEmpty()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .type(MediaType.APPLICATION_JSON)
                    .entity(Map.of("error", "Session ID is required"))
                    .build();
        }

        if (request.getPageId() == null || request.getPageId().trim().isEmpty()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .type(MediaType.APPLICATION_JSON)
                    .entity(Map.of("error", "Page ID is required"))
                    .build();
        }

        // Verify certification exists
        var certification = certificationService.findByIdWithDetails(id);
        if (certification == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .type(MediaType.APPLICATION_JSON)
                    .entity(Map.of("error", "Certification not found"))
                    .build();
        }

        try {
            // Generate streaming AI response
            Multi<String> responseStream = chatService.generateResponse(
                    request.getMessage(),
                    id,
                    request.getPageId(),
                    request.getHistory(),
                    request.getSessionId()
            );

            // Create manual SSE streaming output
            StreamingOutput sseStream = output -> {
                try {
                    // Use a CountDownLatch to wait for stream completion
                    java.util.concurrent.CountDownLatch latch = new java.util.concurrent.CountDownLatch(1);
                    java.util.concurrent.atomic.AtomicBoolean hasError = new java.util.concurrent.atomic.AtomicBoolean(false);
                    
                    responseStream.subscribe().with(
                        token -> {
                            try {
                                // JSON-encode the token so newlines survive SSE transport
                                String jsonToken = MAPPER.writeValueAsString(token);
                                output.write(("data: " + jsonToken + "\n\n").getBytes());
                                output.flush();
                            } catch (Exception e) {
                                LOG.errorf(e, "Error writing SSE token");
                                hasError.set(true);
                                latch.countDown();
                            }
                        },
                        error -> {
                            try {
                                output.write(("data: [ERROR] " + error.getMessage() + "\n\n").getBytes());
                                output.flush();
                            } catch (Exception ignored) {}
                            LOG.errorf(error, "SSE stream error");
                            hasError.set(true);
                            latch.countDown();
                        },
                        () -> {
                            LOG.infof("SSE stream completed for session: %s", request.getSessionId());
                            latch.countDown();
                        }
                    );
                    
                    // Wait for the stream to complete or timeout
                    if (!hasError.get()) {
                        latch.await(60, java.util.concurrent.TimeUnit.SECONDS);
                    }
                } catch (Exception e) {
                    LOG.errorf(e, "Error in SSE streaming");
                }
            };

            return Response.ok(sseStream)
                    .header("Content-Type", "text/event-stream")
                    .header("Cache-Control", "no-cache")
                    .header("Connection", "keep-alive")
                    .build();
        } catch (Exception e) {
            LOG.errorf(e, "Exception in chat endpoint for certification: %s, session: %s", id, request.getSessionId());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .type(MediaType.APPLICATION_JSON)
                    .entity(Map.of("error", "Failed to generate response"))
                    .build();
        }
    }
}
