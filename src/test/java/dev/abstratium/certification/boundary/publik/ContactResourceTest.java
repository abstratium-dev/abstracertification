package dev.abstratium.certification.boundary.publik;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.jupiter.api.Assertions.*;

import java.util.Map;

import dev.abstratium.certification.service.ContactService;
import dev.abstratium.core.RateLimitState;
import io.quarkus.mailer.MockMailbox;
import io.quarkus.test.junit.QuarkusTest;
import jakarta.inject.Inject;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

@QuarkusTest
class ContactResourceTest {

    @Inject
    MockMailbox mailbox;

    @Inject
    ContactService contactService;

    @Inject
    RateLimitState rateLimitState;

    @BeforeEach
    void setUp() {
        mailbox.clear();
        rateLimitState.clear();
    }

    @Test
    void testSubmitContactSuccess() {
        given()
            .contentType("application/json")
            .body(Map.of(
                "name", "Jane Doe",
                "country", "Netherlands",
                "email", "jane@example.com",
                "query", "I have a question about your certifications."
            ))
            .when()
            .post("/public/contact")
            .then()
            .statusCode(201)
            .body("id", notNullValue());
    }

    @Test
    void testSubmitContactSendsEmail() {
        given()
            .contentType("application/json")
            .body(Map.of(
                "name", "John Smith",
                "country", "Sweden",
                "email", "john@example.com",
                "query", "Enterprise pricing query."
            ))
            .when()
            .post("/public/contact")
            .then()
            .statusCode(201);

        var sent = mailbox.getMailsSentTo("test@example.com");
        assertEquals(1, sent.size(), "One notification email should be sent");
        assertTrue(sent.get(0).getSubject().contains("John Smith"));
        assertTrue(sent.get(0).getText().contains("john@example.com"));
    }

    @Test
    void testSubmitContactWithContext() {
        given()
            .contentType("application/json")
            .body(Map.of(
                "name", "Sarah Connor",
                "country", "USA",
                "email", "sarah@example.com",
                "query", "Interested in enterprise plan.",
                "context", "pricing"
            ))
            .when()
            .post("/public/contact")
            .then()
            .statusCode(201)
            .body("id", notNullValue());

        var sent = mailbox.getMailsSentTo("test@example.com");
        assertEquals(1, sent.size());
        assertTrue(sent.get(0).getText().contains("pricing"), "Email body should contain the context value");
    }

    @Test
    void testSubmitContactCapturesForwardedIp() {
        String id = given()
            .contentType("application/json")
            .header("X-Forwarded-For", "203.0.113.42, 10.0.0.1")
            .body(Map.of(
                "name", "IP Test User",
                "country", "Norway",
                "email", "iptest@example.com",
                "query", "Testing IP capture."
            ))
            .when()
            .post("/public/contact")
            .then()
            .statusCode(201)
            .extract().path("id");

        var contact = contactService.findById(id);
        assertEquals("203.0.113.42", contact.getIpAddress(), "Should capture first IP from X-Forwarded-For");
    }

    @Test
    void testSubmitContactWithoutAuth() {
        // Public endpoint - no auth required
        given()
            .contentType("application/json")
            .body(Map.of(
                "name", "Public User",
                "country", "Austria",
                "email", "public@example.com",
                "query", "No auth needed."
            ))
            .when()
            .post("/public/contact")
            .then()
            .statusCode(201);
    }

    @Test
    void testSubmitContactMissingName() {
        given()
            .contentType("application/json")
            .body(Map.of(
                "country", "Germany",
                "email", "test@example.com",
                "query", "Missing name field."
            ))
            .when()
            .post("/public/contact")
            .then()
            .statusCode(400);
    }

    @Test
    void testSubmitContactMissingEmail() {
        given()
            .contentType("application/json")
            .body(Map.of(
                "name", "Test User",
                "country", "Germany",
                "query", "Missing email field."
            ))
            .when()
            .post("/public/contact")
            .then()
            .statusCode(400);
    }

    @Test
    void testSubmitContactInvalidEmail() {
        given()
            .contentType("application/json")
            .body(Map.of(
                "name", "Test User",
                "country", "Germany",
                "email", "not-an-email",
                "query", "Invalid email address."
            ))
            .when()
            .post("/public/contact")
            .then()
            .statusCode(400);
    }

    @Test
    void testSubmitContactMissingCountry() {
        given()
            .contentType("application/json")
            .body(Map.of(
                "name", "Test User",
                "email", "test@example.com",
                "query", "Missing country field."
            ))
            .when()
            .post("/public/contact")
            .then()
            .statusCode(400);
    }

    @Test
    void testSubmitContactMissingQuery() {
        given()
            .contentType("application/json")
            .body(Map.of(
                "name", "Test User",
                "country", "Germany",
                "email", "test@example.com"
            ))
            .when()
            .post("/public/contact")
            .then()
            .statusCode(400);
    }

    @Test
    void testSubmitContactEmptyBody() {
        given()
            .contentType("application/json")
            .body("{}")
            .when()
            .post("/public/contact")
            .then()
            .statusCode(400);
    }
}
