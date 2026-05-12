package dev.abstratium.certification.service;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import dev.abstratium.certification.entity.Certification;
import dev.abstratium.certification.entity.Feedback;
import io.quarkus.mailer.MockMailbox;
import io.quarkus.test.junit.QuarkusTest;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;

import org.junit.jupiter.api.BeforeEach;

import org.junit.jupiter.api.Test;

@QuarkusTest
class FeedbackServiceTest {

    @Inject
    FeedbackService feedbackService;

    @Inject
    CertificationService certificationService;

    @Inject
    MockMailbox mailbox;

    @BeforeEach
    void clearMailbox() {
        mailbox.clear();
    }

    @Test
    void testCreateFeedback() {
        Feedback feedback = new Feedback();
        feedback.setFeedbackType(Feedback.FeedbackType.INSTRUCTION);
        feedback.setTargetId("test-instruction-1");
        feedback.setFeedbackText("This instruction was helpful");
        feedback.setIpAddress("127.0.0.1");
        feedback.setUsername("testuser");

        // Need to set certification
        Certification cert = certificationService.findById("linux-home-server");
        assertNotNull(cert, "Test requires linux-home-server certification to exist");
        feedback.setCertification(cert);

        Feedback created = feedbackService.create(feedback);

        assertNotNull(created.getId(), "Feedback should have generated UUID");
        assertNotNull(created.getCreatedAt(), "Feedback should have creation timestamp");
        assertEquals(Feedback.FeedbackType.INSTRUCTION, created.getFeedbackType());
        assertEquals("test-instruction-1", created.getTargetId());
        assertEquals("This instruction was helpful", created.getFeedbackText());
        assertEquals("127.0.0.1", created.getIpAddress());
        assertEquals("testuser", created.getUsername());

        // Cleanup
        feedbackService.delete(created.getId());
    }

    @Test
    void testCreateFeedbackWithConvenienceMethod() {
        Feedback feedback = feedbackService.createFeedback(
                "PAGE",
                "test-page-1",
                "linux-home-server",
                "This page needs improvement",
                "192.168.1.1",
                "anonymous"
        );

        assertNotNull(feedback.getId());
        assertEquals(Feedback.FeedbackType.PAGE, feedback.getFeedbackType());
        assertEquals("test-page-1", feedback.getTargetId());
        assertEquals("This page needs improvement", feedback.getFeedbackText());

        // Cleanup
        feedbackService.delete(feedback.getId());
    }

    @Test
    void testFindById() {
        Feedback feedback = feedbackService.createFeedback(
                "INSTRUCTION",
                "test-instruction-2",
                "linux-home-server",
                "Great explanation",
                "10.0.0.1",
                null
        );

        Feedback found = feedbackService.findById(feedback.getId());

        assertNotNull(found);
        assertEquals(feedback.getId(), found.getId());
        assertEquals("Great explanation", found.getFeedbackText());

        // Cleanup
        feedbackService.delete(feedback.getId());
    }

    @Test
    void testFindByIdReturnsNullForNonExistent() {
        Feedback found = feedbackService.findById("non-existent-uuid");
        assertNull(found);
    }

    @Test
    @Transactional
    void testFindByCertification() {
        // Create multiple feedback entries
        Feedback f1 = feedbackService.createFeedback(
                "INSTRUCTION",
                "inst-1",
                "linux-home-server",
                "First feedback",
                "1.1.1.1",
                "user1"
        );

        Feedback f2 = feedbackService.createFeedback(
                "PAGE",
                "page-1",
                "linux-home-server",
                "Second feedback",
                "2.2.2.2",
                "user2"
        );

        List<Feedback> results = feedbackService.findByCertification("linux-home-server");

        assertTrue(results.size() >= 2, "Should find at least the 2 feedback entries we created");
        assertTrue(results.stream().anyMatch(f -> f.getId().equals(f1.getId())));
        assertTrue(results.stream().anyMatch(f -> f.getId().equals(f2.getId())));

        // Verify ordering (newest first)
        assertTrue(results.get(0).getCreatedAt().compareTo(results.get(results.size() - 1).getCreatedAt()) >= 0);

        // Cleanup
        feedbackService.delete(f1.getId());
        feedbackService.delete(f2.getId());
    }

    @Test
    @Transactional
    void testFindByTarget() {
        String targetId = "target-" + System.currentTimeMillis();

        Feedback f1 = feedbackService.createFeedback(
                "INSTRUCTION",
                targetId,
                "linux-home-server",
                "Instruction feedback",
                "3.3.3.3",
                "user3"
        );

        Feedback f2 = feedbackService.createFeedback(
                "INSTRUCTION",
                targetId,
                "linux-home-server",
                "Another instruction feedback",
                "4.4.4.4",
                "user4"
        );

        // Create a PAGE feedback with same target (should not be returned)
        Feedback f3 = feedbackService.createFeedback(
                "PAGE",
                targetId,
                "linux-home-server",
                "Page feedback",
                "5.5.5.5",
                "user5"
        );

        List<Feedback> results = feedbackService.findByTarget(targetId, Feedback.FeedbackType.INSTRUCTION);

        assertEquals(2, results.size(), "Should find exactly 2 INSTRUCTION feedback entries");
        assertTrue(results.stream().allMatch(f -> f.getFeedbackType() == Feedback.FeedbackType.INSTRUCTION));
        assertTrue(results.stream().anyMatch(f -> f.getId().equals(f1.getId())));
        assertTrue(results.stream().anyMatch(f -> f.getId().equals(f2.getId())));
        assertFalse(results.stream().anyMatch(f -> f.getId().equals(f3.getId())));

        // Cleanup
        feedbackService.delete(f1.getId());
        feedbackService.delete(f2.getId());
        feedbackService.delete(f3.getId());
    }

    @Test
    void testCreateFeedbackForNonExistentCertification() {
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            feedbackService.createFeedback(
                    "INSTRUCTION",
                    "test-target",
                    "non-existent-cert-id",
                    "This should fail",
                    "127.0.0.1",
                    "testuser"
            );
        });

        assertTrue(exception.getMessage().contains("Certification not found"));
    }

    @Test
    void testDelete() {
        Feedback feedback = feedbackService.createFeedback(
                "PAGE",
                "test-delete-target",
                "linux-home-server",
                "To be deleted",
                "6.6.6.6",
                null
        );

        String id = feedback.getId();

        // Verify it exists
        assertNotNull(feedbackService.findById(id));

        // Delete it
        feedbackService.delete(id);

        // Verify it's gone
        assertNull(feedbackService.findById(id));
    }

    @Test
    void testDeleteNonExistentDoesNotThrow() {
        // Should not throw
        assertDoesNotThrow(() -> feedbackService.delete("non-existent-id"));
    }

    @Test
    void testCreateFeedbackSendsEmail() {
        Feedback feedback = feedbackService.createFeedback(
                "INSTRUCTION",
                "test-email-instruction",
                "linux-home-server",
                "This instruction needs more detail",
                "192.168.0.1",
                "emailtestuser"
        );

        var sent = mailbox.getMailsSentTo("test@example.com");
        assertEquals(1, sent.size(), "One notification email should have been sent");
        String subject = sent.get(0).getSubject();
        String body = sent.get(0).getText();
        assertTrue(subject.contains("INSTRUCTION"), "Subject should contain feedback type");
        assertTrue(body.contains(feedback.getId()), "Body should contain feedback ID");
        assertTrue(body.contains("test-email-instruction"), "Body should contain target ID");
        assertTrue(body.contains("This instruction needs more detail"), "Body should contain feedback text");
        assertTrue(body.contains("emailtestuser"), "Body should contain username");
        assertTrue(body.contains("192.168.0.1"), "Body should contain IP address");
        assertTrue(body.contains("Submitted:"), "Body should contain submission timestamp");

        // Cleanup
        feedbackService.delete(feedback.getId());
    }

    @Test
    void testFeedbackTypes() {
        // Verify INSTRUCTION type
        Feedback instructionFeedback = feedbackService.createFeedback(
                "INSTRUCTION",
                "inst-type-test",
                "linux-home-server",
                "Instruction test",
                "127.0.0.1",
                null
        );
        assertEquals(Feedback.FeedbackType.INSTRUCTION, instructionFeedback.getFeedbackType());

        // Verify PAGE type
        Feedback pageFeedback = feedbackService.createFeedback(
                "PAGE",
                "page-type-test",
                "linux-home-server",
                "Page test",
                "127.0.0.1",
                null
        );
        assertEquals(Feedback.FeedbackType.PAGE, pageFeedback.getFeedbackType());

        // Cleanup
        feedbackService.delete(instructionFeedback.getId());
        feedbackService.delete(pageFeedback.getId());
    }
}
