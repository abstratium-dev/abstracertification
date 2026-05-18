package dev.abstratium.certification.boundary.api;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.*;

import org.junit.jupiter.api.Test;

import dev.abstratium.certification.Roles;
import dev.abstratium.certification.entity.Certification;
import io.quarkus.test.junit.QuarkusTest;
import io.quarkus.test.security.TestSecurity;

@QuarkusTest
class CertificationResourceTest {

    @Test
    @TestSecurity(user = "admin", roles = {Roles.MANAGE_CERTIFICATIONS})
    void testCreateCertification() {
        Certification cert = new Certification();
        cert.setId("test-api-cert");
        cert.setTitle("API Test Certification");
        cert.setDescription("Created via API test");

        given()
            .contentType("application/json")
            .body(cert)
            .when()
            .post("/api/certifications")
            .then()
            .statusCode(200)
            .body("id", is("test-api-cert"))
            .body("title", is("API Test Certification"));

        // Clean up
        given()
            .when()
            .delete("/api/certifications/test-api-cert")
            .then()
            .statusCode(204);
    }

    @Test
    @TestSecurity(user = "admin", roles = {Roles.MANAGE_CERTIFICATIONS})
    void testDeleteCertification() {
        // First create a cert to delete
        Certification cert = new Certification();
        cert.setId("delete-me");
        cert.setTitle("To Be Deleted");

        given()
            .contentType("application/json")
            .body(cert)
            .when()
            .post("/api/certifications")
            .then()
            .statusCode(200);

        // Delete it
        given()
            .when()
            .delete("/api/certifications/delete-me")
            .then()
            .statusCode(204);

        // Verify it's gone via the public endpoint - returns 204 No Content when not found
        given()
            .when()
            .get("/public/certifications/delete-me")
            .then()
            .statusCode(204);
    }

    @Test
    @TestSecurity(user = "admin", roles = {Roles.MANAGE_CERTIFICATIONS})
    void testReplaceCertification() {
        // Create initial cert
        Certification cert = new Certification();
        cert.setId("replace-api-test");
        cert.setTitle("Original API");

        given()
            .contentType("application/json")
            .body(cert)
            .when()
            .post("/api/certifications")
            .then()
            .statusCode(200);

        // Replace it
        Certification replacement = new Certification();
        replacement.setId("replace-api-test");
        replacement.setTitle("Replaced API");

        given()
            .contentType("application/json")
            .body(replacement)
            .when()
            .post("/api/certifications/replace-api-test/replace")
            .then()
            .statusCode(200)
            .body("title", is("Replaced API"));

        // Clean up
        given()
            .when()
            .delete("/api/certifications/replace-api-test")
            .then()
            .statusCode(204);
    }

    @Test
    @TestSecurity(user = "admin", roles = {Roles.MANAGE_CERTIFICATIONS})
    void testCopyCertification() {
        String requestBody = "{\"newId\": \"copied-cert\"}";

        given()
            .contentType("application/json")
            .body(requestBody)
            .when()
            .post("/api/certifications/linux-home-server/copy")
            .then()
            .statusCode(200)
            .body("id", is("copied-cert"))
            .body("title", containsString("(Copy)"));

        // Clean up
        given()
            .when()
            .delete("/api/certifications/copied-cert")
            .then()
            .statusCode(204);
    }

    @Test
    @TestSecurity(user = "testuser", roles = {Roles.USER})
    void testCreateRequiresManageRole() {
        Certification cert = new Certification();
        cert.setId("unauthorized");
        cert.setTitle("Should Fail");

        given()
            .contentType("application/json")
            .body(cert)
            .when()
            .post("/api/certifications")
            .then()
            .statusCode(403);
    }

    @Test
    @TestSecurity(user = "admin", roles = {Roles.MANAGE_CERTIFICATIONS})
    void testCopyNonExistentReturnsError() {
        String requestBody = "{\"newId\": \"will-fail\"}";

        given()
            .contentType("application/json")
            .body(requestBody)
            .when()
            .post("/api/certifications/non-existent/copy")
            .then()
            .statusCode(400); // Bad request due to IllegalArgumentException
    }
}
