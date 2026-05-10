package dev.abstratium.certification.service;

import dev.langchain4j.service.SystemMessage;
import dev.langchain4j.service.UserMessage;
import jakarta.enterprise.context.ApplicationScoped;
import io.smallrye.mutiny.Multi;

@ApplicationScoped
@SystemMessage(ChatConstants.SYSTEM_PROMPT)
public interface Assistant {

    Multi<String> chat(@UserMessage String message);
}
