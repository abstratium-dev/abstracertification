package dev.abstratium.certification.service;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import dev.abstratium.certification.entity.AnswerOption;
import dev.abstratium.certification.entity.Certification;
import dev.abstratium.certification.entity.CertificationStep;
import dev.abstratium.certification.entity.InfoItem;
import dev.abstratium.certification.entity.Instruction;
import dev.abstratium.certification.entity.PageEntry;
import dev.abstratium.certification.entity.Question;
import io.quarkus.test.junit.QuarkusTest;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;

import org.junit.jupiter.api.Test;

@QuarkusTest
class CertificationServiceTest {

    @Inject
    CertificationService certificationService;

    @Test
    void testFindAllReturnsCertifications() {
        List<Certification> certifications = certificationService.findAll();
        assertNotNull(certifications);
        assertFalse(certifications.isEmpty(), "Should find at least the seeded linux-home-server certification");
    }

    @Test
    void testFindByIdWithDetailsLoadsFullTree() {
        Certification cert = certificationService.findByIdWithDetails("linux-home-server");
        assertNotNull(cert);
        assertEquals("Linux Home Server Setup", cert.getTitle());
        assertFalse(cert.getPageEntries().isEmpty(), "Should have page entries");
        assertFalse(cert.getSteps().isEmpty(), "Should have steps");
    }

    @Test
    void testCreateAndDeleteCertification() {
        Certification cert = new Certification();
        cert.setId("test-cert");
        cert.setTitle("Test Certification");
        cert.setDescription("Test description");

        Certification created = certificationService.create(cert);
        assertNotNull(created);
        assertEquals("test-cert", created.getId());

        Certification found = certificationService.findById("test-cert");
        assertNotNull(found);
        assertEquals("Test Certification", found.getTitle());

        certificationService.delete("test-cert");
        assertNull(certificationService.findById("test-cert"));
    }

    @Test
    @Transactional
    void testCreateWithNestedEntities() {
        Certification cert = new Certification();
        cert.setId("nested-test");
        cert.setTitle("Nested Test");

        CertificationStep step = new CertificationStep();
        step.setStepKey("step1");
        step.setTitle("Test Step");
        step.setWhy("Why this step");
        step.setCertification(cert);
        cert.getSteps().add(step);

        InfoItem info = new InfoItem();
        info.setTerm("Test Term");
        info.setDescription("Test description");
        info.setSequenceOrder(0);
        info.setStep(step);
        step.getInfoItems().add(info);

        Instruction instr = new Instruction();
        instr.setText("Test instruction");
        instr.setCommand("echo test");
        instr.setSequenceOrder(0);
        instr.setStep(step);
        step.getInstructions().add(instr);

        Question q = new Question();
        q.setQuestionKey("q1");
        q.setText("Test question?");
        q.setSequenceOrder(0);
        q.setStep(step);
        step.getQuestions().add(q);

        AnswerOption opt = new AnswerOption();
        opt.setText("Correct answer");
        opt.setIsCorrect(true);
        opt.setSequenceOrder(0);
        opt.setQuestion(q);
        q.getAnswerOptions().add(opt);

        PageEntry entry = new PageEntry();
        entry.setEntryType(PageEntry.EntryType.DIRECT);
        entry.setSequenceOrder(0);
        entry.setDirectStep(step);
        entry.setCertification(cert);
        cert.getPageEntries().add(entry);

        Certification created = certificationService.create(cert);
        assertNotNull(created);

        Certification loaded = certificationService.findByIdWithDetails("nested-test");
        assertNotNull(loaded);
        assertEquals(1, loaded.getSteps().size());
        assertEquals(1, loaded.getSteps().get(0).getInfoItems().size());
        assertEquals(1, loaded.getSteps().get(0).getInstructions().size());
        assertEquals(1, loaded.getSteps().get(0).getQuestions().size());
        assertEquals(1, loaded.getSteps().get(0).getQuestions().get(0).getAnswerOptions().size());

        certificationService.delete("nested-test");
    }

    @Test
    void testReplaceCertification() {
        // Create initial cert
        Certification cert = new Certification();
        cert.setId("replace-test");
        cert.setTitle("Original");
        certificationService.create(cert);

        // Create replacement
        Certification replacement = new Certification();
        replacement.setId("replace-test");
        replacement.setTitle("Replaced");

        CertificationStep step = new CertificationStep();
        step.setStepKey("new-step");
        step.setTitle("New Step");
        step.setCertification(replacement);
        replacement.getSteps().add(step);

        Certification result = certificationService.replace("replace-test", replacement);
        assertNotNull(result);
        assertEquals("Replaced", result.getTitle());
        assertEquals(1, result.getSteps().size());

        Certification found = certificationService.findByIdWithDetails("replace-test");
        assertEquals("Replaced", found.getTitle());

        certificationService.delete("replace-test");
    }

    @Test
    void testCopyCertification() {
        Certification copy = certificationService.copy("linux-home-server", "linux-home-server-copy");
        assertNotNull(copy);
        assertEquals("Linux Home Server Setup (Copy)", copy.getTitle());
        assertEquals("linux-home-server-copy", copy.getId());

        // Verify all nested entities were copied
        Certification loaded = certificationService.findByIdWithDetails("linux-home-server-copy");
        assertNotNull(loaded);
        assertFalse(loaded.getSteps().isEmpty());
        assertFalse(loaded.getPageEntries().isEmpty());

        certificationService.delete("linux-home-server-copy");
    }

    @Test
    void testCopyNonExistentThrowsException() {
        assertThrows(IllegalArgumentException.class, () -> {
            certificationService.copy("non-existent-id", "new-id");
        });
    }

    @Test
    void testFindComingSoonCertification() {
        Certification cert = certificationService.findByIdWithDetails("ssl-certbot-letsencrypt");
        assertNotNull(cert);
        assertEquals("SSL with Certbot from Let's Encrypt", cert.getTitle());
        assertTrue(cert.getComingSoon(), "SSL Certbot certification should be marked as coming soon");
        assertFalse(cert.getPageEntries().isEmpty(), "Should have at least an intro page entry");
        assertFalse(cert.getSteps().isEmpty(), "Should have at least an intro step");
    }

    @Test
    void testExistingCertificationNotComingSoon() {
        Certification cert = certificationService.findById("linux-home-server");
        assertNotNull(cert);
        assertFalse(cert.getComingSoon(), "Linux home server certification should not be coming soon");
    }
}
