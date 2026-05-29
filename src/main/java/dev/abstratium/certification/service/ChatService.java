package dev.abstratium.certification.service;

import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.jboss.logging.Logger;

import dev.abstratium.certification.entity.CertificationStep;
import dev.langchain4j.model.anthropic.AnthropicTokenUsage;
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

    public Multi<String> generateResponse(String userMessage, String certificationId, String pageId, String sessionId) {
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
            // Get certification context (placed in system message for prompt caching)
            String contextMessage = buildContextMessage(certificationId, pageId);
            
            // Generate streaming response using AI Service
            LOG.infof("Calling assistant.chat() for session: %s", sessionId);
            TokenStream aiResponseStream = assistant.chat(sessionId, userMessage, contextMessage);

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
                        int cacheCreationTokens = 0;
                        int cacheReadTokens = 0;
                        String tokenUsageClass = response.metadata().tokenUsage().getClass().getName();
                        LOG.debugf("TokenUsage class: %s", tokenUsageClass);
                        if (response.metadata().tokenUsage() instanceof AnthropicTokenUsage anthropicUsage) {
                            cacheCreationTokens = anthropicUsage.cacheCreationInputTokens() != null ? anthropicUsage.cacheCreationInputTokens() : 0;
                            cacheReadTokens = anthropicUsage.cacheReadInputTokens() != null ? anthropicUsage.cacheReadInputTokens() : 0;
                            LOG.debugf("AnthropicTokenUsage raw values - cacheCreationInputTokens: %s, cacheReadInputTokens: %s",
                                anthropicUsage.cacheCreationInputTokens(), anthropicUsage.cacheReadInputTokens());
                        } else {
                            LOG.debugf("TokenUsage is not AnthropicTokenUsage, cannot extract cache token counts");
                        }
                        
                        usageLogger.logChatUsage(
                            certificationId, 
                            pageId, 
                            sessionId, 
                            inputTokens, 
                            outputTokens,
                            cacheCreationTokens,
                            cacheReadTokens
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


    private String buildContextMessage(String certificationId, String pageId) {
        try {
            // Get certification and step information
            var certification = certificationService.findByIdWithDetails(certificationId);
            if (certification == null) {
                throw new RuntimeException("Certification not found");
            }

            StringBuilder context = new StringBuilder();
            
            // Certification header
            context.append("# Certification Context: ").append(certification.getTitle()).append("\n\n");
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

                // Questions section (show actual questions but not correct answers)
                if (currentStep.getQuestions() != null && !currentStep.getQuestions().isEmpty()) {
                    int questionCount = currentStep.getQuestions().size();
                    context.append("#### Assessment Questions THAT YOU MUST NOT ANSWER\n\n");
                    context.append("This step includes **").append(questionCount).append(" assessment question");
                    if (questionCount > 1) {
                        context.append("s");
                    }
                    context.append("** that the candidate must answer themselves. You can provide hints and explanations but don't give direct answers.\n\n");

                    int questionNum = 1;
                    for (var question : currentStep.getQuestions()) {
                        context.append("**Question ").append(questionNum).append(":** ").append(question.getText()).append("\n\n");

                        if (question.getAnswerOptions() != null && !question.getAnswerOptions().isEmpty()) {
                            context.append("Options:\n");
                            char optionLetter = 'A';
                            for (var option : question.getAnswerOptions()) {
                                context.append("  ").append(optionLetter).append(") ").append(option.getText()).append("\n");
                                optionLetter++;
                            }
                            context.append("\n");
                        }
                        questionNum++;
                    }
                }
            } else {
                throw new RuntimeException("Page/Step not found");
            }

            String contextString = context.toString();
            // Rough token estimate: ~4 chars per token for English text
            int estimatedTokens = contextString.length() / 4;
            LOG.debugf("Context message size: %d chars, ~%d estimated tokens (need 2048+ for Haiku caching)",
                contextString.length(), estimatedTokens);
            return contextString;
        } catch (Exception e) {
            return "# Error Loading Context\n\nAn error occurred while loading the certification context: " + e.getMessage();
        }
    }
}
