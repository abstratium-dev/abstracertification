package dev.abstratium.certification.service;

import java.util.List;

import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.jboss.logging.Logger;

import dev.abstratium.certification.boundary.publik.ChatMessage;
import dev.abstratium.certification.entity.CertificationStep;
import dev.langchain4j.service.TokenStream;
import io.smallrye.mutiny.Multi;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class ChatService {

    private static final Logger LOG = Logger.getLogger(ChatService.class);

    @Inject
    CertificationService certificationService;

    @Inject
    Assistant assistant;

    @Inject
    ChatUsageLogger usageLogger;

    @ConfigProperty(name = "provide.ai.help")
    boolean provideAiHelp;

    public Multi<String> generateResponse(String userMessage, String certificationId, String pageId, List<ChatMessage> history, String sessionId) {
        // Check global AI property first
        if (!provideAiHelp) {
            return Multi.createFrom().emitter(e -> {
                LOG.infof("AI help is disabled globally for session: %s", sessionId);
                e.emit("AI help is disabled for this certification. Please contact support if you need assistance.");
                e.complete();
            });
        }
        
        // Check certification-specific AI setting
        try {
            var certification = certificationService.findById(certificationId);
            if (certification == null || !certification.getAiEnabled()) {
                return Multi.createFrom().emitter(e -> {
                    LOG.infof("AI help is disabled for certification: %s, session: %s", certificationId, sessionId);
                    e.emit("AI help is disabled for this certification. Please contact support if you need assistance.");
                    e.complete();
                });
            }
        } catch (Exception e) {
            LOG.errorf(e, "Error checking certification AI setting for session: %s", sessionId);
            return Multi.createFrom().emitter(emitter -> {
                emitter.fail(new RuntimeException("Unable to verify certification AI settings"));
            });
        }
        
        LOG.infof("Starting chat response generation for certification: %s, session: %s", certificationId, sessionId);
        try {
            // Get certification context
            String contextMessage = buildContextMessage(certificationId, pageId);
            
            // Build the full prompt with context and constraints
            String fullPrompt = buildFullPrompt(userMessage, contextMessage, history);

            // Generate streaming response using AI Service
            LOG.infof("Calling assistant.chat() for session: %s", sessionId);
            TokenStream aiResponseStream = assistant.chat(fullPrompt);

            // Create Multi<String> emitter for streaming tokens
            return Multi.createFrom().emitter(emitter -> {
                aiResponseStream
                    .beforeToolExecution(beforeToolExecution -> {
                        LOG.debugf("Before tool execution for session %s, tool: %s", sessionId, beforeToolExecution.request().name());
                    })
                    .onIntermediateResponse(chatResponse -> {
                        String responseText = chatResponse.aiMessage().text();
                        LOG.debugf("Intermediate Response for session %s, message: %s", sessionId, responseText);
                        // Emit the response text to the Multi stream
                        emitter.emit(responseText);
                    })
                    .onPartialResponseWithContext((partial, context) -> {
                        LOG.debugf("Partial Response with context for session %s, message: %s, context: %s", sessionId, partial, context);
                        // Convert partial response to string and emit to the Multi stream
                        String partialString = partial.text();
                        emitter.emit(partialString);
                    })
                    .onPartialThinkingWithContext((partial, context) -> {
                        LOG.debugf("Partial Thinking Response with context for session %s, message: %s, context: %s", sessionId, partial, context);
                        // Convert thinking response to string and emit to the Multi stream
                        String thinkingString = partial.text();
                        emitter.emit(thinkingString);
                    })
                    .onRetrieved(contents -> {
                        if(contents != null && !contents.isEmpty()) {
                            LOG.debugf("Retrieved contents for session %s, contents: %s", sessionId, contents);
                        }
                    })
                    .onToolExecuted(toolExecuted -> {
                        LOG.debugf("Tool executed for session %s, tool: %s", sessionId, toolExecuted.request().name());
                    })
                    .onCompleteResponse(response -> {
                        emitter.complete();
                        LOG.infof("Chat stream completed for session: %s", sessionId);
                        
                        int inputTokens = response.metadata().tokenUsage().inputTokenCount();
                        int outputTokens = response.metadata().tokenUsage().outputTokenCount();
                        
                        usageLogger.logChatUsage(
                            certificationId, 
                            pageId, 
                            sessionId, 
                            inputTokens, 
                            outputTokens
                        );
                    })
                    .onError(error -> {
                        LOG.errorf(error, "Chat stream failed for session: %s", sessionId);
                        usageLogger.logChatError(certificationId, pageId, sessionId, userMessage, error.getMessage());
                        emitter.fail(error);
                    })
                    .start();
            });

                
        } catch (Exception e) {
            // Log errors for monitoring
            LOG.errorf(e, "Exception in generateResponse for session: %s", sessionId);
            usageLogger.logChatError(certificationId, pageId, sessionId, userMessage, e.getMessage());
            throw e; // Re-throw to maintain existing error handling
        }
    }

    private String formatHistory(List<ChatMessage> history) {
        if (history == null || history.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        sb.append("# Chat History\n\n");
        for (ChatMessage msg : history) {
            String role = msg.getRole();
            String content = msg.getContent();
            
            if ("user".equalsIgnoreCase(role)) {
                sb.append("**User:** ").append(content).append("\n\n");
            } else if ("assistant".equalsIgnoreCase(role)) {
                sb.append("**Assistant:** ").append(content).append("\n\n");
            } else {
                sb.append("**").append(role.substring(0, 1).toUpperCase()).append(role.substring(1)).append(":** ").append(content).append("\n\n");
            }
        }
        return sb.toString();
    }

    private String buildFullPrompt(String userMessage, String contextMessage, List<ChatMessage> history) {
        StringBuilder prompt = new StringBuilder();

        // Add current user message
        prompt.append("# Current Question from Candidate that must be answered now:\n\n").append(userMessage).append("\n\n");

        // Add context in markdown format
        prompt.append("----\n\n").append(contextMessage).append("\n\n");

        // Add chat history if available
        if (history != null && !history.isEmpty()) {
            prompt.append("----\n\n");
            prompt.append(formatHistory(history));
            prompt.append("\n\n");
        }

        return prompt.toString();
    }

    private String buildContextMessage(String certificationId, String pageId) {
        try {
            // Get certification and step information
            var certification = certificationService.findByIdWithDetails(certificationId);
            if (certification == null) {
                throw new RuntimeException("Certification not found");
            }

            StringBuilder context = new StringBuilder();
            
            // Certification header
            context.append("# Certification Context").append(certification.getTitle()).append("\n\n");
            context.append("## ").append(certification.getTitle()).append("\n\n");
            context.append(certification.getDescription()).append("\n\n");

            // Find the specific step/page
            CertificationStep currentStep = null;
            for (var step : certification.getSteps()) {
                if (step.getId().equals(pageId) || step.getStepKey().equals(pageId)) {
                    currentStep = step;
                    break;
                }
            }

            if (currentStep != null) {
                // Current step header
                context.append("### Current Step: ").append(currentStep.getTitle()).append("\n\n");
                
                // Why this matters section
                if (currentStep.getWhy() != null && !currentStep.getWhy().trim().isEmpty()) {
                    context.append("#### Why This Matters\n\n");
                    context.append(currentStep.getWhy()).append("\n\n");
                }

                // Instructions section
                if (currentStep.getInstructions() != null && !currentStep.getInstructions().isEmpty()) {
                    context.append("#### Instructions\n\n");
                    currentStep.getInstructions().stream()
                        .filter(inst -> inst.getText() != null && !inst.getText().trim().isEmpty())
                        .forEach(inst -> context.append("- ").append(inst.getText()).append("\n"));
                    context.append("\n");
                }

                // Key concepts section
                if (currentStep.getInfoItems() != null && !currentStep.getInfoItems().isEmpty()) {
                    context.append("#### Key Concepts\n\n");
                    currentStep.getInfoItems().stream()
                        .filter(info -> info.getTerm() != null && info.getDescription() != null)
                        .forEach(info -> context.append("- **").append(info.getTerm()).append(":** ").append(info.getDescription()).append("\n"));
                    context.append("\n");
                }

                // Questions section (only show count, not actual questions)
                if (currentStep.getQuestions() != null && !currentStep.getQuestions().isEmpty()) {
                    int questionCount = currentStep.getQuestions().size();
                    context.append("#### Assessment Questions THAT YOU MUST NOT ANSWER\n\n");
                    context.append("This step includes **").append(questionCount).append(" assessment question");
                    if (questionCount > 1) {
                        context.append("s");
                    }
                    context.append("** that the candidate must answer themselves. You can provide hints and explanations but don't give direct answers.\n\n");
                }
            } else {
                throw new RuntimeException("Page/Step not found");
            }

            return context.toString();
        } catch (Exception e) {
            return "# Error Loading Context\n\nAn error occurred while loading the certification context: " + e.getMessage();
        }
    }
}
