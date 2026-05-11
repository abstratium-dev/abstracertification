package dev.abstratium.certification.boundary.publik;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.hamcrest.Matchers.hasKey;

import java.util.Map;

import org.junit.jupiter.api.Test;

import dev.abstratium.certification.Roles;
import io.quarkus.test.junit.QuarkusTest;
import io.quarkus.test.security.TestSecurity;

@QuarkusTest
class PublicCertificationResourceTest {

    @Test
    void testGetAllWithoutAuth() {
        // Public endpoint - no authentication required
        given()
            .when()
            .get("/public/certifications")
            .then()
            .statusCode(200)
            .body("[0].id", notNullValue())
            .body("[0].title", notNullValue());
    }

    @Test
    void testGetAllReturnsSummary() {
        // List endpoint returns summaries ordered by sequence_order
        given()
            .when()
            .get("/public/certifications")
            .then()
            .statusCode(200)
            .body("[0].id", is("linux-home-server"))
            .body("[0].title", is("Linux Home Server Setup"))
            .body("[0].description", notNullValue())
            .body("[0].comingSoon", is(false))
            .body("[1].id", is("hardening-linux-server"))
            .body("[1].title", is("Hardening a Linux Server"))
            .body("[1].comingSoon", is(true));
    }

    @Test
    void testGetByIdWithoutAuth() {
        // Public endpoint - no authentication required
        given()
            .when()
            .get("/public/certifications/linux-home-server")
            .then()
            .statusCode(200)
            .body("id", is("linux-home-server"))
            .body("title", is("Linux Home Server Setup"))
            .body("pageEntries", notNullValue());
    }

    @Test
    void testGetByIdNotFound() {
        // When not found, returns 204 No Content
        given()
            .when()
            .get("/public/certifications/non-existent")
            .then()
            .statusCode(204);
    }

    @Test
    @TestSecurity(user = "testuser", roles = {Roles.USER})
    void testGetAllWithAuth() {
        // Authenticated users can also access public endpoints
        given()
            .when()
            .get("/public/certifications")
            .then()
            .statusCode(200);
    }

    @Test
    @TestSecurity(user = "testuser", roles = {Roles.USER})
    void testGetByIdWithAuth() {
        // Authenticated users can also access public endpoints
        given()
            .when()
            .get("/public/certifications/linux-home-server")
            .then()
            .statusCode(200)
            .body("id", is("linux-home-server"))
            .body("title", is("Linux Home Server Setup"));
    }

    @Test
    void testGetByIdReturnsCertificationWithSteps() {
        given()
            .when()
            .get("/public/certifications/linux-home-server")
            .then()
            .statusCode(200)
            .body("id", is("linux-home-server"))
            .body("steps", notNullValue())
            .body("pageEntries", notNullValue());
    }

    @Test
    void testGetByIdPageEntriesIncludeDirectStepId() {
        given()
            .when()
            .get("/public/certifications/linux-home-server")
            .then()
            .statusCode(200)
            .body("pageEntries[0].directStepId", is("step-intro"))
            .body("pageEntries[0].entryType", is("DIRECT"));
    }

    @Test
    void testGetByIdChoiceVariantsIncludeStepId() {
        given()
            .when()
            .get("/public/certifications/linux-home-server")
            .then()
            .statusCode(200)
            .body("pageEntries[1].entryType", is("CHOICE"))
            .body("pageEntries[1].variants[0].stepId", notNullValue());
    }

    @Test
    void testGetByIdDoesNotExposeIsCorrect() {
        // Verify that answer options do NOT include the isCorrect field
        given()
            .when()
            .get("/public/certifications/linux-home-server")
            .then()
            .statusCode(200)
            .body("steps[0].questions[0].answerOptions[0]", not(hasKey("isCorrect")));
    }

    @Test
    void testCheckAnswersCorrect() {
        // Submit a correct answer for q-nginx-1 (correct answer is a-nginx-1-1)
        given()
            .contentType("application/json")
            .body(Map.of("answers", Map.of("q-nginx-1", "a-nginx-1-1")))
            .when()
            .post("/public/certifications/linux-home-server/check-answers")
            .then()
            .statusCode(200)
            .body("results.q-nginx-1", is(true));
    }

    @Test
    void testCheckAnswersIncorrect() {
        // Submit an incorrect answer for q-nginx-1 (wrong answer is a-nginx-1-0)
        given()
            .contentType("application/json")
            .body(Map.of("answers", Map.of("q-nginx-1", "a-nginx-1-0")))
            .when()
            .post("/public/certifications/linux-home-server/check-answers")
            .then()
            .statusCode(200)
            .body("results.q-nginx-1", is(false));
    }

    @Test
    void testCheckAnswersNotFound() {
        given()
            .contentType("application/json")
            .body(Map.of("answers", Map.of("q-1", "a-1")))
            .when()
            .post("/public/certifications/non-existent/check-answers")
            .then()
            .statusCode(404);
    }

    @Test
    void testCheckAnswersBadRequest() {
        // Empty answers map
        given()
            .contentType("application/json")
            .body(Map.of("answers", Map.of()))
            .when()
            .post("/public/certifications/linux-home-server/check-answers")
            .then()
            .statusCode(400);
    }

    @Test
    void testGetComingSoonCertification() {
        given()
            .when()
            .get("/public/certifications/hardening-linux-server")
            .then()
            .statusCode(200)
            .body("id", is("hardening-linux-server"))
            .body("title", is("Hardening a Linux Server"))
            .body("comingSoon", is(true))
            .body("pageEntries", notNullValue())
            .body("steps", notNullValue());
    }
}
