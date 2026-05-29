package dev.abstratium.certification.boundary.publik;

import com.fasterxml.jackson.annotation.JsonProperty;

import io.quarkus.runtime.annotations.RegisterForReflection;

@RegisterForReflection
public class ChatRequest {
    
    @JsonProperty(required = true)
    private String message;
    
    @JsonProperty(required = true)
    private String certificationId;
    
    @JsonProperty(required = true)
    private String pageId;
    
    @JsonProperty(required = true)
    private String sessionId;
    
    public ChatRequest() {
    }
    
    public ChatRequest(String message, String certificationId, String pageId, String sessionId) {
        this.message = message;
        this.certificationId = certificationId;
        this.pageId = pageId;
        this.sessionId = sessionId;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    
    public String getCertificationId() {
        return certificationId;
    }
    
    public void setCertificationId(String certificationId) {
        this.certificationId = certificationId;
    }
    
    public String getPageId() {
        return pageId;
    }
    
    public void setPageId(String pageId) {
        this.pageId = pageId;
    }
    
    public String getSessionId() {
        return sessionId;
    }
    
    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }
    
}
