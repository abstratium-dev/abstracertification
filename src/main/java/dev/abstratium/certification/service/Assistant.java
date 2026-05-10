package dev.abstratium.certification.service;

import dev.langchain4j.service.SystemMessage;
import dev.langchain4j.service.TokenStream;
import dev.langchain4j.service.UserMessage;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
@SystemMessage(ChatConstants.SYSTEM_PROMPT)
public interface Assistant {
    TokenStream chat(@UserMessage String message);
}
