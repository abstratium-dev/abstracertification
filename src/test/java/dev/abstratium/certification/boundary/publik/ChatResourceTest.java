package dev.abstratium.certification.boundary.publik;

import io.quarkus.test.junit.QuarkusTest;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.equalTo;

@QuarkusTest
public class ChatResourceTest {

    private ChatRequest validChatRequest;
    private ChatRequest invalidChatRequest;

    @BeforeEach
    void setUp() {
        // Setup valid chat request
        validChatRequest = new ChatRequest();
        validChatRequest.setMessage("Can you help me understand this concept?");
        validChatRequest.setCertificationId("test-certification");
        validChatRequest.setPageId("test-page");
        validChatRequest.setSessionId("test-session-123");

        // Setup invalid chat request (missing message)
        invalidChatRequest = new ChatRequest();
        invalidChatRequest.setMessage("");
        invalidChatRequest.setCertificationId("test-certification");
        invalidChatRequest.setPageId("test-page");
        invalidChatRequest.setSessionId("test-session-123");
    }

    @Test
    void testChat_EmptyMessage_ReturnsBadRequest() {
        given()
            .contentType("application/json")
            .body(invalidChatRequest)
            .when()
            .post("/public/certifications/test-certification/chat")
            .then()
            .statusCode(400)
            .body("error", equalTo("Message is required"));
    }

    @Test
    void testChat_MissingSessionId_ReturnsBadRequest() {
        ChatRequest requestWithoutSession = new ChatRequest();
        requestWithoutSession.setMessage("Test message");
        requestWithoutSession.setCertificationId("test-certification");
        requestWithoutSession.setPageId("test-page");
        // sessionId is null

        given()
            .contentType("application/json")
            .body(requestWithoutSession)
            .when()
            .post("/public/certifications/test-certification/chat")
            .then()
            .statusCode(400)
            .body("error", equalTo("Session ID is required"));
    }

    @Test
    void testChat_MissingPageId_ReturnsBadRequest() {
        ChatRequest requestWithoutPage = new ChatRequest();
        requestWithoutPage.setMessage("Test message");
        requestWithoutPage.setCertificationId("test-certification");
        requestWithoutPage.setSessionId("test-session");
        // pageId is null

        given()
            .contentType("application/json")
            .body(requestWithoutPage)
            .when()
            .post("/public/certifications/test-certification/chat")
            .then()
            .statusCode(400)
            .body("error", equalTo("Page ID is required"));
    }

    @Test
    void testChat_NonExistentCertification_ReturnsNotFound() {
        given()
            .contentType("application/json")
            .body(validChatRequest)
            .when()
            .post("/public/certifications/non-existent-certification/chat")
            .then()
            .statusCode(404)
            .body("error", equalTo("Certification not found"));
    }


    @Test
    void testChat_ValidRequest_NonExistentCertification_ReturnsNotFound() {
        ChatRequest request = new ChatRequest();
        request.setMessage("Test message");
        request.setCertificationId("test-certification");
        request.setPageId("test-page");
        request.setSessionId("test-session");

        given()
            .contentType("application/json")
            .body(request)
            .when()
            .post("/public/certifications/test-certification/chat")
            .then()
            .statusCode(404); // Expected to return 404 since test certification doesn't exist
    }
}
