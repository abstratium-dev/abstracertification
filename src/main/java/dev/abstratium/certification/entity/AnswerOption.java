package dev.abstratium.certification.entity;

import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

/**
 * Represents a single answer option for a {@link Question}.
 * Each option has display text, a correctness flag, and a sequence order
 * that determines how options are presented to the user.
 */
@Entity
@Table(name = "T_answer_option")
public class AnswerOption {

    @Id
    @Column(length = 36)
    private String id;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id", nullable = false, foreignKey = @jakarta.persistence.ForeignKey(name = "FK_answer_option_question"))
    private Question question;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String text;

    @JsonIgnore
    @Column(name = "is_correct", nullable = false)
    private Boolean isCorrect = false;

    @Column(name = "sequence_order", nullable = false)
    private Integer sequenceOrder;

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

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Boolean getIsCorrect() {
        return isCorrect;
    }

    public void setIsCorrect(Boolean isCorrect) {
        this.isCorrect = isCorrect;
    }

    public Integer getSequenceOrder() {
        return sequenceOrder;
    }

    public void setSequenceOrder(Integer sequenceOrder) {
        this.sequenceOrder = sequenceOrder;
    }
}
