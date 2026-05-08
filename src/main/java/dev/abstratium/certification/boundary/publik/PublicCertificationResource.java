package dev.abstratium.certification.boundary.publik;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import dev.abstratium.certification.entity.AnswerOption;
import dev.abstratium.certification.entity.Certification;
import dev.abstratium.certification.entity.CertificationStep;
import dev.abstratium.certification.entity.Question;
import dev.abstratium.certification.service.CertificationService;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Path("/public/certifications")
@Tag(name = "Public Certifications", description = "Public certification read endpoints")
public class PublicCertificationResource {

    @Inject
    CertificationService certificationService;

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
}
