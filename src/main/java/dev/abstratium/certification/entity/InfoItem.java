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
 * A glossary-style key concept within a {@link CertificationStep}.
 * Displayed as a term/description pair in the "Key Concepts" section
 * of a wizard step. Items are ordered by {@code sequenceOrder}.
 */
@Entity
@Table(name = "T_info_item")
public class InfoItem {

    @Id
    @Column(length = 36)
    private String id;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "step_id", nullable = false, foreignKey = @jakarta.persistence.ForeignKey(name = "FK_info_item_step"))
    private CertificationStep step;

    @Column(nullable = false, length = 100)
    private String term;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String description;

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

    public CertificationStep getStep() {
        return step;
    }

    public void setStep(CertificationStep step) {
        this.step = step;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getSequenceOrder() {
        return sequenceOrder;
    }

    public void setSequenceOrder(Integer sequenceOrder) {
        this.sequenceOrder = sequenceOrder;
    }
}
