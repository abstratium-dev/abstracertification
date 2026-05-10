package dev.abstratium.certification.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;

import org.jboss.logging.Logger;

import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class ChatUsageLogger {

    private static final Logger LOG = Logger.getLogger(ChatUsageLogger.class);

    // Claude Haiku 4.5 pricing (as of 2026-05-10)
    private static final BigDecimal INPUT_TOKEN_PRICE_PER_1K = new BigDecimal("0.0010");
    private static final BigDecimal OUTPUT_TOKEN_PRICE_PER_1K = new BigDecimal("0.0050");

    public void logChatUsage(String certificationId, String pageId, String sessionId, 
                           int inputTokens, int outputTokens) {
        
        // Calculate costs
        BigDecimal inputCost = calculateCost(inputTokens, INPUT_TOKEN_PRICE_PER_1K);
        BigDecimal outputCost = calculateCost(outputTokens, OUTPUT_TOKEN_PRICE_PER_1K);
        BigDecimal totalCost = inputCost.add(outputCost);

        // Log comprehensive usage information
        LOG.debug("=== CHAT USAGE LOG ===");
        LOG.debugf("Timestamp: %s", LocalDateTime.now());
        LOG.debugf("Session ID: %s", sessionId);
        LOG.debugf("Certification ID: %s", certificationId);
        LOG.debugf("Page ID: %s", pageId);
        LOG.debugf("Input Tokens: %d", inputTokens);
        LOG.debugf("Output Tokens: %d", outputTokens);
        LOG.debugf("Total Tokens: %d", inputTokens + outputTokens);
        LOG.debugf("Input Cost: $%.6f", inputCost);
        LOG.debugf("Output Cost: $%.6f", outputCost);
        LOG.debugf("Total Cost: $%.6f", totalCost);
        LOG.debug("====================");
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
