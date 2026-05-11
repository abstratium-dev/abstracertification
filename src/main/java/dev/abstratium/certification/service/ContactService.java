package dev.abstratium.certification.service;

import dev.abstratium.certification.entity.Contact;
import io.quarkus.mailer.Mail;
import io.quarkus.mailer.Mailer;
import io.quarkus.runtime.LaunchMode;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.jboss.logging.Logger;

@ApplicationScoped
public class ContactService {

    private static final Logger LOG = Logger.getLogger(ContactService.class);

    @Inject
    EntityManager em;

    @Inject
    Mailer mailer;

    @ConfigProperty(name = "contact.mail.to")
    String contactMailTo;

    @Inject
    LaunchMode mode;

    @Transactional
    public Contact submit(Contact contact) {
        em.persist(contact);
        sendNotificationEmail(contact);
        return contact;
    }

    @Transactional
    public Contact findById(String id) {
        return em.find(Contact.class, id);
    }

    private void sendNotificationEmail(Contact contact) {
        try {
            String subject = "[" + mode.getDefaultProfile() + "] Abstratium Certification - New Contact Form Submission from " + contact.getName();
            String body = "ID:        " + contact.getId() + "\n"
                    + "Submitted: " + contact.getCreatedAt() + "\n"
                    + "IP:        " + (contact.getIpAddress() != null ? contact.getIpAddress() : "unknown") + "\n"
                    + "Context:   " + (contact.getContext() != null ? contact.getContext() : "direct") + "\n"
                    + "\n"
                    + "Name:      " + contact.getName() + "\n"
                    + "Country:   " + contact.getCountry() + "\n"
                    + "Email:     " + contact.getEmail() + "\n"
                    + "\n"
                    + "Query:\n"
                    + contact.getQuery();

            mailer.send(Mail.withText(contactMailTo, subject, body));
            LOG.infof("Contact notification email sent to %s for submission from %s", contactMailTo, contact.getEmail());
        } catch (Exception e) {
            LOG.errorf(e, "Failed to send contact notification email for submission from %s", contact.getEmail());
        }
    }
}
