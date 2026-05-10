package dev.abstratium.certification.service;

import java.util.List;

import dev.abstratium.certification.entity.Certification;
import dev.abstratium.certification.entity.Feedback;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;

@ApplicationScoped
public class FeedbackService {

    @Inject
    EntityManager em;

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

        return create(feedback);
    }
}
