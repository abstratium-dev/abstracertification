package dev.abstratium.certification.service;

import dev.abstratium.certification.boundary.publik.ChatMessage;
import dev.abstratium.certification.entity.CertificationStep;
import io.smallrye.mutiny.Multi;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.jboss.logging.Logger;

import java.util.List;

@ApplicationScoped
public class ChatService {

    private static final Logger LOG = Logger.getLogger(ChatService.class);

    @Inject
    CertificationService certificationService;

    @Inject
    Assistant assistant;

    @Inject
    ChatUsageLogger usageLogger;

    @Inject
    ChatTokenCounter tokenCounter;

    public Multi<String> generateResponse(String userMessage, String certificationId, String pageId, List<ChatMessage> history, String sessionId) {
        LOG.infof("Starting chat response generation for certification: %s, session: %s", certificationId, sessionId);
        
        try {
            // Get certification context
            String contextMessage = buildContextMessage(certificationId, pageId);
            
            // Build the full prompt with context and constraints
            String fullPrompt = buildFullPrompt(userMessage, contextMessage, history);

            // Generate streaming response using AI Service
            LOG.infof("Calling assistant.chat() for session: %s", sessionId);
            Multi<String> aiResponseStream = assistant.chat(fullPrompt);

            // Return the stream with minimal logging
            return aiResponseStream
                .onSubscription().invoke(() -> {
                    LOG.debugf("Stream subscribed for session: %s", sessionId);
                })
                .onCompletion().invoke(() -> {
                    LOG.infof("Chat stream completed for session: %s", sessionId);
                })
                .onFailure().invoke(error -> {
                    LOG.errorf(error, "Chat stream failed for session: %s", sessionId);
                });
        } catch (Exception e) {
            // Log errors for monitoring
            LOG.errorf(e, "Exception in generateResponse for session: %s", sessionId);
            usageLogger.logChatError(certificationId, pageId, sessionId, userMessage, e.getMessage());
            throw e; // Re-throw to maintain existing error handling
        }
    }

    
    
    
    private String buildFullPrompt(String userMessage, String contextMessage, List<ChatMessage> history) {
        StringBuilder prompt = new StringBuilder();

        // Add context
        prompt.append("Certification Context:\n").append(contextMessage).append("\n\n");

        // Add chat history if available
        if (history != null && !history.isEmpty()) {
            prompt.append("Chat History:\n");
            for (ChatMessage msg : history) {
                prompt.append(msg.getRole()).append(": ").append(msg.getContent()).append("\n");
            }
            prompt.append("\n");
        }

        // Add current user message
        prompt.append("Current Question:\n").append(userMessage);

        return prompt.toString();
    }

    private String buildContextMessage(String certificationId, String pageId) {
        try {
            // Get certification and step information
            var certification = certificationService.findByIdWithDetails(certificationId);
            if (certification == null) {
                return "Certification not found.";
            }

            StringBuilder context = new StringBuilder();
            context.append("Certification: ").append(certification.getTitle()).append("\n");
            context.append("Description: ").append(certification.getDescription()).append("\n\n");

            // Find the specific step/page
            CertificationStep currentStep = null;
            for (var step : certification.getSteps()) {
                if (step.getId().equals(pageId) || step.getStepKey().equals(pageId)) {
                    currentStep = step;
                    break;
                }
            }

            if (currentStep != null) {
                context.append("Current Step: ").append(currentStep.getTitle()).append("\n");
                if (currentStep.getWhy() != null && !currentStep.getWhy().trim().isEmpty()) {
                    context.append("Why this matters: ").append(currentStep.getWhy()).append("\n");
                }

                // Add instructions
                if (currentStep.getInstructions() != null && !currentStep.getInstructions().isEmpty()) {
                    context.append("\nInstructions:\n");
                    currentStep.getInstructions().stream()
                        .filter(inst -> inst.getText() != null && !inst.getText().trim().isEmpty())
                        .forEach(inst -> context.append("- ").append(inst.getText()).append("\n"));
                }

                // Add info items
                if (currentStep.getInfoItems() != null && !currentStep.getInfoItems().isEmpty()) {
                    context.append("\nKey Concepts:\n");
                    currentStep.getInfoItems().stream()
                        .filter(info -> info.getTerm() != null && info.getDescription() != null)
                        .forEach(info -> context.append("- ").append(info.getTerm()).append(": ").append(info.getDescription()).append("\n"));
                }

                // Note about questions (but don't show the questions or answers)
                if (currentStep.getQuestions() != null && !currentStep.getQuestions().isEmpty()) {
                    context.append("\nNote: This step includes assessment questions that you must answer yourself. " +
                                 "I can provide hints and explanations but won't give direct answers.");
                }
            } else {
                context.append("Page/Step not found in this certification.");
            }

            return context.toString();
        } catch (Exception e) {
            return "Error loading certification context: " + e.getMessage();
        }
    }
}
