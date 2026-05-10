package dev.abstratium.certification.service;

import jakarta.enterprise.context.ApplicationScoped;
import org.jboss.logging.Logger;

@ApplicationScoped
public class ChatTokenCounter {

    private static final Logger LOG = Logger.getLogger(ChatTokenCounter.class);

    // Approximate tokenization for Claude models
    // Rough estimate: ~4 characters per token for English text
    private static final double CHARACTERS_PER_TOKEN = 4.0;

    public int estimateTokens(String text) {
        if (text == null || text.trim().isEmpty()) {
            return 0;
        }
        
        // Simple character-based estimation
        // This is a rough approximation - actual tokenization depends on the specific tokenizer
        int estimatedTokens = (int) Math.ceil(text.length() / CHARACTERS_PER_TOKEN);
        
        LOG.debugf("Estimated %d tokens for %d characters of text", estimatedTokens, text.length());
        
        return estimatedTokens;
    }

    public int estimateInputTokens(String userMessage, String context, String chatHistory) {
        StringBuilder fullInput = new StringBuilder();
        
        // Add context
        fullInput.append("Certification Context:\n").append(context).append("\n\n");
        
        // Add chat history if available
        if (chatHistory != null && !chatHistory.trim().isEmpty()) {
            fullInput.append("Chat History:\n").append(chatHistory).append("\n\n");
        }
        
        // Add current user message
        fullInput.append("Current Question:\n").append(userMessage);
        
        return estimateTokens(fullInput.toString());
    }

    public int estimateOutputTokens(String aiResponse) {
        return estimateTokens(aiResponse);
    }

    /**
     * More accurate token counting would require implementing the actual tokenizer
     * or using a library. For now, this provides a reasonable approximation.
     * 
     * @param text The text to count tokens for
     * @return Estimated token count
     */
    public int countTokensApproximately(String text) {
        // This is a more refined estimation considering:
        // - Short words typically 1 token
        // - Average words 1-2 tokens  
        // - Long words may be 2-3 tokens
        // - Punctuation and spaces affect tokenization
        
        if (text == null || text.trim().isEmpty()) {
            return 0;
        }

        // Split by whitespace to get words
        String[] words = text.split("\\s+");
        int tokenCount = 0;

        for (String word : words) {
            if (word.length() <= 4) {
                tokenCount += 1; // Short words: ~1 token
            } else if (word.length() <= 8) {
                tokenCount += 2; // Medium words: ~2 tokens
            } else {
                tokenCount += 3; // Long words: ~3 tokens
            }
        }

        // Add some tokens for punctuation and formatting
        tokenCount += text.chars().filter(ch -> ".,!?;:\"'()[]{}".indexOf(ch) >= 0).count() / 2;

        return Math.max(1, tokenCount);
    }
}
