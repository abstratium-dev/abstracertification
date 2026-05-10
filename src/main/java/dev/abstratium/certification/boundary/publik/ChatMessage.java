package dev.abstratium.certification.boundary.publik;

import com.fasterxml.jackson.annotation.JsonProperty;

public class ChatMessage {
    
    @JsonProperty(required = true)
    private String role;
    
    @JsonProperty(required = true)
    private String content;
    
    public ChatMessage() {
    }
    
    public ChatMessage(String role, String content) {
        this.role = role;
        this.content = content;
    }
    
    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
}
