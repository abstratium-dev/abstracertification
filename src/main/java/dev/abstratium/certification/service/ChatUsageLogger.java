package dev.abstratium.certification.service;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.jboss.logging.Logger;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;

@ApplicationScoped
public class ChatUsageLogger {

    private static final Logger LOG = Logger.getLogger(ChatUsageLogger.class);

    // Claude Haiku 4.5 pricing (as of 2024)
    // These are approximate prices - update based on actual Anthropic pricing
    private static final BigDecimal INPUT_TOKEN_PRICE_PER_1K = new BigDecimal("0.00025"); // $0.00025 per 1K input tokens
    private static final BigDecimal OUTPUT_TOKEN_PRICE_PER_1K = new BigDecimal("0.00125"); // $0.00125 per 1K output tokens

    @Inject
    ChatTokenCounter tokenCounter;

    public void logChatUsage(String certificationId, String pageId, String sessionId, 
                           String userMessage, String aiResponse, 
                           int inputTokens, int outputTokens) {
        
        // Calculate costs
        BigDecimal inputCost = calculateCost(inputTokens, INPUT_TOKEN_PRICE_PER_1K);
        BigDecimal outputCost = calculateCost(outputTokens, OUTPUT_TOKEN_PRICE_PER_1K);
        BigDecimal totalCost = inputCost.add(outputCost);

        // Log comprehensive usage information
        LOG.info("=== CHAT USAGE LOG ===");
        LOG.infof("Timestamp: %s", LocalDateTime.now());
        LOG.infof("Session ID: %s", sessionId);
        LOG.infof("Certification ID: %s", certificationId);
        LOG.infof("Page ID: %s", pageId);
        LOG.infof("Input Tokens: %d", inputTokens);
        LOG.infof("Output Tokens: %d", outputTokens);
        LOG.infof("Total Tokens: %d", inputTokens + outputTokens);
        LOG.infof("Input Cost: $%.6f", inputCost);
        LOG.infof("Output Cost: $%.6f", outputCost);
        LOG.infof("Total Cost: $%.6f", totalCost);
        LOG.infof("User Message Length: %d characters", userMessage.length());
        LOG.infof("AI Response Length: %d characters", aiResponse.length());
        LOG.info("====================");

        // Also log in JSON format for easier parsing by monitoring tools
        LOG.infof("CHAT_USAGE_JSON: {\"timestamp\":\"%s\",\"sessionId\":\"%s\",\"certificationId\":\"%s\",\"pageId\":\"%s\",\"inputTokens\":%d,\"outputTokens\":%d,\"totalTokens\":%d,\"inputCost\":%.6f,\"outputCost\":%.6f,\"totalCost\":%.6f,\"userMessageLength\":%d,\"aiResponseLength\":%d}", 
                 LocalDateTime.now(), sessionId, certificationId, pageId, 
                 inputTokens, outputTokens, inputTokens + outputTokens,
                 inputCost, outputCost, totalCost,
                 userMessage.length(), aiResponse.length());
    }

    private BigDecimal calculateCost(int tokens, BigDecimal pricePer1K) {
        return BigDecimal.valueOf(tokens)
                .multiply(pricePer1K)
                .divide(BigDecimal.valueOf(1000), 6, RoundingMode.HALF_UP);
    }

    public void logChatError(String certificationId, String pageId, String sessionId, 
                           String userMessage, String errorMessage) {
        LOG.error("=== CHAT ERROR LOG ===");
        LOG.errorf("Timestamp: %s", LocalDateTime.now());
        LOG.errorf("Session ID: %s", sessionId);
        LOG.errorf("Certification ID: %s", certificationId);
        LOG.errorf("Page ID: %s", pageId);
        LOG.errorf("Error Message: %s", errorMessage);
        LOG.errorf("User Message Length: %d characters", userMessage.length());
        LOG.error("====================");
    }
}
