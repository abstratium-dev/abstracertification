package dev.abstratium.certification.service;

import java.util.List;

import dev.abstratium.certification.entity.Certification;
import dev.abstratium.certification.entity.Feedback;
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
public class FeedbackService {

    private static final Logger LOG = Logger.getLogger(FeedbackService.class);

    @Inject
    EntityManager em;

    @Inject
    Mailer mailer;

    @ConfigProperty(name = "contact.mail.to")
    String contactMailTo;

    @Inject
    LaunchMode mode;

    @Transactional
    public Feedback create(Feedback feedback) {
        em.persist(feedback);
        return feedback;
    }

    @Transactional
    public Feedback findById(String id) {
        return em.find(Feedback.class, id);
    }

    @Transactional
    public List<Feedback> findAll() {
        return em.createQuery("SELECT f FROM Feedback f ORDER BY f.createdAt DESC", Feedback.class)
                .getResultList();
    }

    @Transactional
    public List<Feedback> findByCertification(String certificationId) {
        return em.createQuery(
                "SELECT f FROM Feedback f WHERE f.certification.id = :certId ORDER BY f.createdAt DESC",
                Feedback.class)
                .setParameter("certId", certificationId)
                .getResultList();
    }

    @Transactional
    public List<Feedback> findByTarget(String targetId, Feedback.FeedbackType type) {
        return em.createQuery(
                "SELECT f FROM Feedback f WHERE f.targetId = :targetId AND f.feedbackType = :type ORDER BY f.createdAt DESC",
                Feedback.class)
                .setParameter("targetId", targetId)
                .setParameter("type", type)
                .getResultList();
    }

    @Transactional
    public void delete(String id) {
        Feedback feedback = em.find(Feedback.class, id);
        if (feedback != null) {
            em.remove(feedback);
        }
    }

    @Transactional
    public Feedback createFeedback(String feedbackType, String targetId, String certificationId,
                                   String feedbackText, String ipAddress, String username) {
        Certification certification = em.find(Certification.class, certificationId);
        if (certification == null) {
            throw new IllegalArgumentException("Certification not found: " + certificationId);
        }

        Feedback feedback = new Feedback();
        feedback.setFeedbackType(Feedback.FeedbackType.valueOf(feedbackType.toUpperCase()));
        feedback.setTargetId(targetId);
        feedback.setCertification(certification);
        feedback.setFeedbackText(feedbackText);
        feedback.setIpAddress(ipAddress);
        feedback.setUsername(username);

        Feedback saved = create(feedback);
        sendNotificationEmail(saved);
        return saved;
    }

    private void sendNotificationEmail(Feedback feedback) {
        try {
            String certTitle = feedback.getCertification() != null ? feedback.getCertification().getTitle() : "unknown";
            String subject = "[" + mode.getDefaultProfile() + "] Abstratium Certification - New Feedback Submission (" + feedback.getFeedbackType() + ")";
            String body = "ID:          " + feedback.getId() + "\n"
                    + "Submitted:   " + feedback.getCreatedAt() + "\n"
                    + "IP:          " + (feedback.getIpAddress() != null ? feedback.getIpAddress() : "unknown") + "\n"
                    + "User:        " + (feedback.getUsername() != null ? feedback.getUsername() : "anonymous") + "\n"
                    + "\n"
                    + "Type:        " + feedback.getFeedbackType() + "\n"
                    + "Target ID:   " + feedback.getTargetId() + "\n"
                    + "Cert:        " + certTitle + "\n"
                    + "\n"
                    + "Feedback:\n"
                    + feedback.getFeedbackText();

            mailer.send(Mail.withText(contactMailTo, subject, body));
            LOG.infof("Feedback notification email sent to %s for submission on target %s", contactMailTo, feedback.getTargetId());
        } catch (Exception e) {
            LOG.errorf(e, "Failed to send feedback notification email for target %s", feedback.getTargetId());
        }
    }
}
