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
 * Represents one selectable option within a CHOICE-type {@link PageEntry}.
 * Each variant has a label, description, and references a {@link CertificationStep}
 * that will be presented to the user when they select this variant.
 *
 * <p>The {@code stepId} property (derived from the associated step) is exposed
 * in JSON to allow the frontend to resolve the full step content from the
 * certification's steps list.</p>
 */
@Entity
@Table(name = "T_choice_variant")
public class ChoiceVariant {

    @Id
    @Column(length = 36)
    private String id;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "page_entry_id", nullable = false, foreignKey = @jakarta.persistence.ForeignKey(name = "FK_choice_variant_page_entry"))
    private PageEntry pageEntry;

    @Column(nullable = false, length = 255)
    private String label;

    @Column(columnDefinition = "TEXT")
    private String description;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "step_id", nullable = false, foreignKey = @jakarta.persistence.ForeignKey(name = "FK_choice_variant_step"))
    private CertificationStep step;

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

    public PageEntry getPageEntry() {
        return pageEntry;
    }

    public void setPageEntry(PageEntry pageEntry) {
        this.pageEntry = pageEntry;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public CertificationStep getStep() {
        return step;
    }

    public void setStep(CertificationStep step) {
        this.step = step;
    }

    public Integer getSequenceOrder() {
        return sequenceOrder;
    }

    public void setSequenceOrder(Integer sequenceOrder) {
        this.sequenceOrder = sequenceOrder;
    }

    public String getStepId() {
        return step != null ? step.getId() : null;
    }
}
