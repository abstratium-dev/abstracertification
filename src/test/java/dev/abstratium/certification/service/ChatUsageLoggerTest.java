package dev.abstratium.certification.service;

import io.quarkus.test.junit.QuarkusTest;
import jakarta.inject.Inject;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

@QuarkusTest
public class ChatUsageLoggerTest {

    @Inject
    ChatUsageLogger usageLogger;

    @Inject
    ChatTokenCounter tokenCounter;

    @Test
    void testTokenCounter() {
        String testMessage = "This is a test message for token counting.";
        int tokens = tokenCounter.estimateTokens(testMessage);
        
        assertTrue(tokens > 0, "Token count should be greater than 0");
        System.out.println("Estimated tokens for test message: " + tokens);
    }

    @Test
    void testUsageLogging() {
        String userMessage = "What is Linux?";
        String aiResponse = "Linux is an open-source operating system kernel that serves as the foundation for various Unix-like operating systems.";
        String sessionId = "test-session-123";
        String certificationId = "linux-cert";
        String pageId = "intro-page";
        
        // This should log the usage without throwing any exceptions
        assertDoesNotThrow(() -> {
            usageLogger.logChatUsage(
                certificationId, 
                pageId, 
                sessionId, 
                userMessage, 
                aiResponse, 
                50, // input tokens
                30  // output tokens
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

    @Test
    void testChatHistoryTokenCounting() {
        String chatHistoryText = "user: What is a command?\n" +
                               "assistant: A command is an instruction to the computer.\n" +
                               "user: Give me an example.";
        
        int tokens = tokenCounter.estimateTokens(chatHistoryText);
        assertTrue(tokens > 0, "Chat history should have tokens");
        System.out.println("Estimated tokens for chat history: " + tokens);
    }
}
