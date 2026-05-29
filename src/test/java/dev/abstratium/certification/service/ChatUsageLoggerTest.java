package dev.abstratium.certification.service;

import io.quarkus.test.junit.QuarkusTest;
import jakarta.inject.Inject;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

@QuarkusTest
public class ChatUsageLoggerTest {

    @Inject
    ChatUsageLogger usageLogger;

    @Test
    void testUsageLogging() {
        String sessionId = "test-session-123";
        String certificationId = "linux-cert";
        String pageId = "intro-page";
        
        // This should log the usage without throwing any exceptions
        assertDoesNotThrow(() -> {
            usageLogger.logChatUsage(
                certificationId, 
                pageId, 
                sessionId, 
                50, // input tokens
                30, // output tokens
                100, // cache creation tokens
                80   // cache read tokens
            );
        });
    }

    @Test
    void testErrorLogging() {
        String userMessage = "What is Linux?";
        String errorMessage = "API connection failed";
        String sessionId = "test-session-123";
        String certificationId = "linux-cert";
        String pageId = "intro-page";
        
        // This should log the error without throwing any exceptions
        assertDoesNotThrow(() -> {
            usageLogger.logChatError(
                certificationId, 
                pageId, 
                sessionId, 
                userMessage, 
                errorMessage
            );
        });
    }

}
