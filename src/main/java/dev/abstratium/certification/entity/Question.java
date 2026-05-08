package dev.abstratium.certification.entity;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

/**
 * A comprehension-check question within a {@link CertificationStep}.
 * Each question has display text and a list of {@link AnswerOption} choices.
 * The user must select the correct option to complete the step.
 *
 * <p>The {@code questionKey} is a short, human-readable identifier used for
 * deduplication and cross-referencing. Questions are ordered by {@code sequenceOrder}.</p>
 */
@Entity
@Table(name = "T_question")
public class Question {

    @Id
    @Column(length = 36)
    private String id;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "step_id", nullable = false, foreignKey = @jakarta.persistence.ForeignKey(name = "FK_question_step"))
    private CertificationStep step;

    @Column(name = "question_key", nullable = false, length = 50)
    private String questionKey;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String text;

    @Column(name = "sequence_order", nullable = false)
    private Integer sequenceOrder;

    @OneToMany(mappedBy = "question", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<AnswerOption> answerOptions = new ArrayList<>();

    @PrePersist
    public void prePersist() {
        if (id == null) {
            id = UUID.randomUUID().toString();
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public CertificationStep getStep() {
        return step;
    }

    public void setStep(CertificationStep step) {
        this.step = step;
    }

    public String getQuestionKey() {
        return questionKey;
    }

    public void setQuestionKey(String questionKey) {
        this.questionKey = questionKey;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Integer getSequenceOrder() {
        return sequenceOrder;
    }

    public void setSequenceOrder(Integer sequenceOrder) {
        this.sequenceOrder = sequenceOrder;
    }

    public List<AnswerOption> getAnswerOptions() {
        return answerOptions;
    }

    public void setAnswerOptions(List<AnswerOption> answerOptions) {
        this.answerOptions = answerOptions;
    }
}
