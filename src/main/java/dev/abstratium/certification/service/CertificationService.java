package dev.abstratium.certification.service;

import java.util.List;

import dev.abstratium.certification.entity.AnswerOption;
import dev.abstratium.certification.entity.Certification;
import dev.abstratium.certification.entity.CertificationStep;
import dev.abstratium.certification.entity.ChoiceVariant;
import dev.abstratium.certification.entity.InfoItem;
import dev.abstratium.certification.entity.Instruction;
import dev.abstratium.certification.entity.PageEntry;
import dev.abstratium.certification.entity.Question;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;

@ApplicationScoped
public class CertificationService {

    @Inject
    EntityManager em;

    @Transactional
    public List<Certification> findAll() {
        return em.createQuery("SELECT c FROM Certification c ORDER BY c.title", Certification.class)
                .getResultList();
    }

    @Transactional
    public Certification findById(String id) {
        return em.find(Certification.class, id);
    }

    @Transactional
    public Certification findByIdWithDetails(String id) {
        // Load certification
        Certification cert = em.find(Certification.class, id);
        if (cert == null) {
            return null;
        }

        // Initialize page entries, their direct step references, and variants
        for (PageEntry entry : cert.getPageEntries()) {
            if (entry.getDirectStep() != null) {
                entry.getDirectStep().getId(); // force proxy initialization
            }
            entry.getVariants().size();
            for (ChoiceVariant variant : entry.getVariants()) {
                if (variant.getStep() != null) {
                    variant.getStep().getId(); // force proxy initialization
                }
            }
        }

        // Initialize all step collections
        for (CertificationStep step : cert.getSteps()) {
            step.getInfoItems().size();
            step.getInstructions().size();
            for (Question q : step.getQuestions()) {
                q.getAnswerOptions().size();
            }
        }

        return cert;
    }

    @Transactional
    public Certification create(Certification certification) {
        em.persist(certification);
        return certification;
    }

    @Transactional
    public Certification replace(String existingId, Certification newCertification) {
        Certification existing = em.find(Certification.class, existingId);
        if (existing != null) {
            em.remove(existing);
            em.flush();
        }
        em.persist(newCertification);
        return newCertification;
    }

    @Transactional
    public void delete(String id) {
        Certification certification = em.find(Certification.class, id);
        if (certification != null) {
            em.remove(certification);
        }
    }

    @Transactional
    public Certification copy(String sourceId, String newId) {
        Certification source = findByIdWithDetails(sourceId);
        if (source == null) {
            throw new IllegalArgumentException("Source certification not found: " + sourceId);
        }

        Certification copy = new Certification();
        copy.setId(newId);
        copy.setTitle(source.getTitle() + " (Copy)");
        copy.setDescription(source.getDescription());

        for (CertificationStep sourceStep : source.getSteps()) {
            CertificationStep stepCopy = copyStep(sourceStep, copy);
            copy.getSteps().add(stepCopy);
        }

        for (PageEntry sourceEntry : source.getPageEntries()) {
            PageEntry entryCopy = copyPageEntry(sourceEntry, copy, copy.getSteps());
            copy.getPageEntries().add(entryCopy);
        }

        em.persist(copy);
        return copy;
    }

    private CertificationStep copyStep(CertificationStep source, Certification targetCertification) {
        CertificationStep copy = new CertificationStep();
        copy.setCertification(targetCertification);
        copy.setStepKey(source.getStepKey());
        copy.setTitle(source.getTitle());
        copy.setWhy(source.getWhy());
        copy.setInfoExpanded(source.getInfoExpanded());

        for (InfoItem sourceItem : source.getInfoItems()) {
            InfoItem itemCopy = new InfoItem();
            itemCopy.setStep(copy);
            itemCopy.setTerm(sourceItem.getTerm());
            itemCopy.setDescription(sourceItem.getDescription());
            itemCopy.setSequenceOrder(sourceItem.getSequenceOrder());
            copy.getInfoItems().add(itemCopy);
        }

        for (Instruction sourceInstr : source.getInstructions()) {
            Instruction instrCopy = new Instruction();
            instrCopy.setStep(copy);
            instrCopy.setText(sourceInstr.getText());
            instrCopy.setCommand(sourceInstr.getCommand());
            instrCopy.setNote(sourceInstr.getNote());
            instrCopy.setMermaidDiagram(sourceInstr.getMermaidDiagram());
            instrCopy.setSequenceOrder(sourceInstr.getSequenceOrder());
            copy.getInstructions().add(instrCopy);
        }

        for (Question sourceQuestion : source.getQuestions()) {
            Question questionCopy = new Question();
            questionCopy.setStep(copy);
            questionCopy.setQuestionKey(sourceQuestion.getQuestionKey());
            questionCopy.setText(sourceQuestion.getText());
            questionCopy.setSequenceOrder(sourceQuestion.getSequenceOrder());

            for (AnswerOption sourceOption : sourceQuestion.getAnswerOptions()) {
                AnswerOption optionCopy = new AnswerOption();
                optionCopy.setQuestion(questionCopy);
                optionCopy.setText(sourceOption.getText());
                optionCopy.setIsCorrect(sourceOption.getIsCorrect());
                optionCopy.setSequenceOrder(sourceOption.getSequenceOrder());
                questionCopy.getAnswerOptions().add(optionCopy);
            }

            copy.getQuestions().add(questionCopy);
        }

        return copy;
    }

    private PageEntry copyPageEntry(PageEntry source, Certification targetCertification, List<CertificationStep> targetSteps) {
        PageEntry copy = new PageEntry();
        copy.setCertification(targetCertification);
        copy.setEntryType(source.getEntryType());
        copy.setSequenceOrder(source.getSequenceOrder());
        copy.setChoiceLabel(source.getChoiceLabel());
        copy.setChoiceDescription(source.getChoiceDescription());
        copy.setMinRequired(source.getMinRequired());
        copy.setMaxRequired(source.getMaxRequired());

        if (source.getDirectStep() != null) {
            CertificationStep matchingStep = targetSteps.stream()
                    .filter(s -> s.getStepKey().equals(source.getDirectStep().getStepKey()))
                    .findFirst()
                    .orElse(null);
            copy.setDirectStep(matchingStep);
        }

        for (ChoiceVariant sourceVariant : source.getVariants()) {
            ChoiceVariant variantCopy = new ChoiceVariant();
            variantCopy.setPageEntry(copy);
            variantCopy.setLabel(sourceVariant.getLabel());
            variantCopy.setDescription(sourceVariant.getDescription());
            variantCopy.setSequenceOrder(sourceVariant.getSequenceOrder());

            CertificationStep matchingStep = targetSteps.stream()
                    .filter(s -> s.getStepKey().equals(sourceVariant.getStep().getStepKey()))
                    .findFirst()
                    .orElse(null);
            variantCopy.setStep(matchingStep);

            copy.getVariants().add(variantCopy);
        }

        return copy;
    }
}
