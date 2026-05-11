package dev.abstratium.certification.service;

import static org.junit.jupiter.api.Assertions.*;

import dev.abstratium.certification.entity.Contact;
import io.quarkus.mailer.MockMailbox;
import io.quarkus.test.junit.QuarkusTest;
import jakarta.inject.Inject;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

@QuarkusTest
class ContactServiceTest {

    @Inject
    ContactService contactService;

    @Inject
    MockMailbox mailbox;

    @BeforeEach
    void clearMailbox() {
        mailbox.clear();
    }

    @Test
    void testSubmitPersistsContact() {
        Contact contact = new Contact();
        contact.setName("Alice Smith");
        contact.setCountry("Germany");
        contact.setEmail("alice@example.com");
        contact.setQuery("I would like to know more about enterprise plans.");
        contact.setIpAddress("10.0.0.1");

        Contact created = contactService.submit(contact);

        assertNotNull(created.getId(), "Should have generated UUID");
        assertNotNull(created.getCreatedAt(), "Should have creation timestamp");
        assertEquals("Alice Smith", created.getName());
        assertEquals("Germany", created.getCountry());
        assertEquals("alice@example.com", created.getEmail());
        assertEquals("I would like to know more about enterprise plans.", created.getQuery());
        assertEquals("10.0.0.1", created.getIpAddress());
    }

    @Test
    void testSubmitSendsEmail() {
        Contact contact = new Contact();
        contact.setName("Bob Jones");
        contact.setCountry("France");
        contact.setEmail("bob@example.com");
        contact.setQuery("How does pricing work?");

        contactService.submit(contact);

        var sent = mailbox.getMailsSentTo("test@example.com");
        assertEquals(1, sent.size(), "One email should have been sent");
        String subject = sent.get(0).getSubject();
        String body = sent.get(0).getText();
        assertTrue(subject.contains("Bob Jones"), "Subject should contain sender name");
        assertTrue(body.contains("bob@example.com"), "Body should contain sender email");
        assertTrue(body.contains("France"), "Body should contain country");
        assertTrue(body.contains("How does pricing work?"), "Body should contain query text");
        assertTrue(body.contains("ID:"), "Body should contain record ID");
        assertTrue(body.contains("Submitted:"), "Body should contain submission timestamp");
        assertTrue(body.contains("IP:"), "Body should contain IP address field");
        assertTrue(body.contains("Context:"), "Body should contain context field");
    }

    @Test
    void testFindById() {
        Contact contact = new Contact();
        contact.setName("Carol White");
        contact.setCountry("Spain");
        contact.setEmail("carol@example.com");
        contact.setQuery("Question about certificates.");

        Contact created = contactService.submit(contact);

        Contact found = contactService.findById(created.getId());
        assertNotNull(found);
        assertEquals(created.getId(), found.getId());
        assertEquals("Carol White", found.getName());
        assertEquals("carol@example.com", found.getEmail());
    }

    @Test
    void testSubmitWithContext() {
        Contact contact = new Contact();
        contact.setName("Eve Green");
        contact.setCountry("Denmark");
        contact.setEmail("eve@example.com");
        contact.setQuery("Interested in enterprise pricing.");
        contact.setContext("pricing");

        Contact created = contactService.submit(contact);

        assertNotNull(created.getId());
        assertEquals("pricing", created.getContext());

        var sent = mailbox.getMailsSentTo("test@example.com");
        assertTrue(sent.get(0).getText().contains("pricing"), "Email body should contain context value");
    }

    @Test
    void testFindByIdReturnsNullForNonExistent() {
        Contact found = contactService.findById("non-existent-uuid");
        assertNull(found);
    }

    @Test
    void testSubmitWithNullIpAddress() {
        Contact contact = new Contact();
        contact.setName("Dave Brown");
        contact.setCountry("UK");
        contact.setEmail("dave@example.com");
        contact.setQuery("General inquiry.");
        contact.setIpAddress(null);

        Contact created = contactService.submit(contact);

        assertNotNull(created.getId());
        assertNull(created.getIpAddress());
    }
}
