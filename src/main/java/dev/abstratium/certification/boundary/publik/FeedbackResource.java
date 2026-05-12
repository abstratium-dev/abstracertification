package dev.abstratium.certification.boundary.publik;

import java.security.Principal;

import dev.abstratium.certification.entity.Feedback;
import dev.abstratium.certification.service.FeedbackService;
import dev.abstratium.core.IpAddressUtil;
import dev.abstratium.core.RateLimited;
import io.quarkus.runtime.annotations.RegisterForReflection;
import io.vertx.ext.web.RoutingContext;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.HttpHeaders;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.SecurityContext;

import org.eclipse.microprofile.openapi.annotations.tags.Tag;
import org.jboss.logging.Logger;

/**
 * Public endpoint for submitting feedback on instructions or pages.
 * Accessible without authentication, but will capture username if user is logged in.
 */
@Path("/public/feedback")
@Tag(name = "API", description = "Public API endpoints")
public class FeedbackResource {

    private static final Logger LOG = Logger.getLogger(FeedbackResource.class);

    @Inject
    FeedbackService feedbackService;

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @RateLimited(maxRequests = 5, windowSeconds = 600)
    public Response submitFeedback(FeedbackRequest request, @Context SecurityContext securityContext,
            @Context HttpHeaders headers, @Context RoutingContext rc) {
        if (request == null || request.feedbackText == null || request.feedbackText.trim().isEmpty()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(new ErrorResponse("Feedback text is required"))
                    .build();
        }

        if (request.feedbackType == null || request.targetId == null || request.certificationId == null) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(new ErrorResponse("feedbackType, targetId, and certificationId are required"))
                    .build();
        }

        // Validate feedback type
        try {
            Feedback.FeedbackType.valueOf(request.feedbackType.toUpperCase());
        } catch (IllegalArgumentException e) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(new ErrorResponse("Invalid feedbackType. Must be INSTRUCTION or PAGE"))
                    .build();
        }

        String username = null;
        if (securityContext.getUserPrincipal() != null) {
            Principal principal = securityContext.getUserPrincipal();
            username = principal.getName();
        }

        String ipAddress = IpAddressUtil.extractIpAddress(headers, rc);

        LOG.debugf("Received feedback: type=%s, target=%s, cert=%s, user=%s",
                request.feedbackType, request.targetId, request.certificationId, username);

        try {
            Feedback feedback = feedbackService.createFeedback(
                    request.feedbackType,
                    request.targetId,
                    request.certificationId,
                    request.feedbackText.trim(),
                    ipAddress,
                    username
            );

            LOG.infof("Feedback submitted: id=%s, type=%s, target=%s",
                    feedback.getId(), request.feedbackType, request.targetId);

            return Response.status(Response.Status.CREATED)
                    .entity(new SuccessResponse(feedback.getId()))
                    .build();
        } catch (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(new ErrorResponse(e.getMessage()))
                    .build();
        } catch (Exception e) {
            LOG.error("Failed to submit feedback", e);
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity(new ErrorResponse("Failed to submit feedback"))
                    .build();
        }
    }

    @RegisterForReflection
    public static class FeedbackRequest {
        public String feedbackType;
        public String targetId;
        public String certificationId;
        public String feedbackText;
    }

    @RegisterForReflection
    public static class SuccessResponse {
        public String id;
        public String message;

        public SuccessResponse(String id) {
            this.id = id;
            this.message = "Feedback submitted successfully";
        }
    }

    @RegisterForReflection
    public static class ErrorResponse {
        public String error;

        public ErrorResponse(String error) {
            this.error = error;
        }
    }
}
