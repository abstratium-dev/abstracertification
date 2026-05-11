package dev.abstratium.core;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.is;

import java.util.Map;

import io.quarkus.test.junit.QuarkusTest;
import jakarta.inject.Inject;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

@QuarkusTest
class RateLimitInterceptorTest {

    @Inject
    RateLimitState rateLimitState;

    @BeforeEach
    void clearRateLimitState() {
        rateLimitState.clear();
    }

    @Test
    void testContactEndpointAllowsRequestsWithinLimit() {
        for (int i = 0; i < 5; i++) {
            given()
                .contentType("application/json")
                .body(Map.of(
                    "name", "Rate Test " + i,
                    "country", "Germany",
                    "email", "rate" + i + "@example.com",
                    "query", "Testing rate limit " + i
                ))
                .when()
                .post("/public/contact")
                .then()
                .statusCode(201);
        }
    }

    @Test
    void testContactEndpointRejectsWhenRateLimitExceeded() {
        // Send 5 requests (the limit)
        for (int i = 0; i < 5; i++) {
            given()
                .contentType("application/json")
                .body(Map.of(
                    "name", "Rate Test " + i,
                    "country", "Germany",
                    "email", "ratelimit" + i + "@example.com",
                    "query", "Testing rate limit " + i
                ))
                .when()
                .post("/public/contact")
                .then()
                .statusCode(201);
        }

        // 6th request should be rejected
        given()
            .contentType("application/json")
            .body(Map.of(
                "name", "Rate Exceeded",
                "country", "Germany",
                "email", "exceeded@example.com",
                "query", "This should be rate limited"
            ))
            .when()
            .post("/public/contact")
            .then()
            .statusCode(429)
            .body("error", is("Too many requests. Please try again later."));
    }

    @Test
    void testFeedbackEndpointRejectsWhenRateLimitExceeded() {
        // Send 5 requests (the limit)
        for (int i = 0; i < 5; i++) {
            given()
                .contentType("application/json")
                .body(Map.of(
                    "feedbackType", "INSTRUCTION",
                    "targetId", "test-target-" + i,
                    "certificationId", "linux-home-server",
                    "feedbackText", "Feedback " + i
                ))
                .when()
                .post("/public/feedback")
                .then()
                .statusCode(201);
        }

        // 6th request should be rejected
        given()
            .contentType("application/json")
            .body(Map.of(
                "feedbackType", "INSTRUCTION",
                "targetId", "test-target-extra",
                "certificationId", "linux-home-server",
                "feedbackText", "This should be rate limited"
            ))
            .when()
            .post("/public/feedback")
            .then()
            .statusCode(429)
            .body("error", is("Too many requests. Please try again later."));
    }

    @Test
    void testDifferentIpsHaveSeparateLimits() {
        // Send 5 requests from IP "10.0.0.1"
        for (int i = 0; i < 5; i++) {
            given()
                .contentType("application/json")
                .header("X-Forwarded-For", "10.0.0.1")
                .body(Map.of(
                    "name", "User A " + i,
                    "country", "Germany",
                    "email", "usera" + i + "@example.com",
                    "query", "Query from A " + i
                ))
                .when()
                .post("/public/contact")
                .then()
                .statusCode(201);
        }

        // IP "10.0.0.1" is now rate limited
        given()
            .contentType("application/json")
            .header("X-Forwarded-For", "10.0.0.1")
            .body(Map.of(
                "name", "User A Extra",
                "country", "Germany",
                "email", "usera-extra@example.com",
                "query", "This should be limited"
            ))
            .when()
            .post("/public/contact")
            .then()
            .statusCode(429);

        // But a different IP "10.0.0.2" should still work
        given()
            .contentType("application/json")
            .header("X-Forwarded-For", "10.0.0.2")
            .body(Map.of(
                "name", "User B",
                "country", "Germany",
                "email", "userb@example.com",
                "query", "Query from B"
            ))
            .when()
            .post("/public/contact")
            .then()
            .statusCode(201);
    }

    @Test
    void testRateLimitResetsAfterClear() {
        // Fill up the rate limit
        for (int i = 0; i < 5; i++) {
            given()
                .contentType("application/json")
                .body(Map.of(
                    "name", "Reset Test " + i,
                    "country", "Germany",
                    "email", "reset" + i + "@example.com",
                    "query", "Testing reset " + i
                ))
                .when()
                .post("/public/contact")
                .then()
                .statusCode(201);
        }

        // Should be rate limited
        given()
            .contentType("application/json")
            .body(Map.of(
                "name", "Should Fail",
                "country", "Germany",
                "email", "shouldfail@example.com",
                "query", "This should fail"
            ))
            .when()
            .post("/public/contact")
            .then()
            .statusCode(429);

        // Clear the state
        rateLimitState.clear();

        // Should work again
        given()
            .contentType("application/json")
            .body(Map.of(
                "name", "Should Work",
                "country", "Germany",
                "email", "shouldwork@example.com",
                "query", "This should work"
            ))
            .when()
            .post("/public/contact")
            .then()
            .statusCode(201);
    }

    @Test
    void testContactAndFeedbackHaveSeparateLimits() {
        // Fill up the contact rate limit
        for (int i = 0; i < 5; i++) {
            given()
                .contentType("application/json")
                .header("X-Forwarded-For", "192.168.1.100")
                .body(Map.of(
                    "name", "Separate Test " + i,
                    "country", "Germany",
                    "email", "separate" + i + "@example.com",
                    "query", "Testing separate limits " + i
                ))
                .when()
                .post("/public/contact")
                .then()
                .statusCode(201);
        }

        // Contact should be rate limited for this IP
        given()
            .contentType("application/json")
            .header("X-Forwarded-For", "192.168.1.100")
            .body(Map.of(
                "name", "Contact Exceeded",
                "country", "Germany",
                "email", "exceeded@example.com",
                "query", "Should be limited"
            ))
            .when()
            .post("/public/contact")
            .then()
            .statusCode(429);

        // But feedback should still work for the same IP
        given()
            .contentType("application/json")
            .header("X-Forwarded-For", "192.168.1.100")
            .body(Map.of(
                "feedbackType", "INSTRUCTION",
                "targetId", "test-target",
                "certificationId", "linux-home-server",
                "feedbackText", "This should work despite contact being limited"
            ))
            .when()
            .post("/public/feedback")
            .then()
            .statusCode(201);
    }
}
