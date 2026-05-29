package dev.abstratium.certification.service;

import dev.langchain4j.service.MemoryId;
import dev.langchain4j.service.SystemMessage;
import dev.langchain4j.service.TokenStream;
import dev.langchain4j.service.UserMessage;
import dev.langchain4j.service.V;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
@SystemMessage(ChatConstants.SYSTEM_PROMPT)
public interface Assistant {
    TokenStream chat(@MemoryId String sessionId, @UserMessage String message, @V("context") String context);
}
