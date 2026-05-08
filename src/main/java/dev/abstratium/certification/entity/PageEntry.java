package dev.abstratium.certification.entity;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

/**
 * Defines one entry in the ordered page sequence of a {@link Certification}.
 * A page entry is either:
 * <ul>
 *   <li>{@code DIRECT} — references a single {@link CertificationStep} via {@code directStep}</li>
 *   <li>{@code CHOICE} — presents the user with multiple {@link ChoiceVariant} options,
 *       each pointing to a different step</li>
 * </ul>
 *
 * <p>The {@code sequenceOrder} determines presentation order.
 * The {@code directStepId} property is a derived JSON field that exposes the step ID
 * without serializing the full step object (which is {@code @JsonIgnore}d to prevent
 * circular references).</p>
 */
@Entity
@Table(name = "T_page_entry")
public class PageEntry {

    public enum EntryType {
        DIRECT, CHOICE
    }

    @Id
    @Column(length = 36)
    private String id;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "certification_id", nullable = false, foreignKey = @jakarta.persistence.ForeignKey(name = "FK_page_entry_certification"))
    private Certification certification;

    @Enumerated(EnumType.STRING)
    @Column(name = "entry_type", nullable = false, length = 20)
    private EntryType entryType;

    @Column(name = "sequence_order", nullable = false)
    private Integer sequenceOrder;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "direct_step_id", foreignKey = @jakarta.persistence.ForeignKey(name = "FK_page_entry_step"))
    private CertificationStep directStep;

    @Column(name = "choice_label", length = 255)
    private String choiceLabel;

    @Column(name = "choice_description", columnDefinition = "TEXT")
    private String choiceDescription;

    @Column(name = "min_required")
    private Integer minRequired;

    @Column(name = "max_required")
    private Integer maxRequired;

    @OneToMany(mappedBy = "pageEntry", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ChoiceVariant> variants = new ArrayList<>();

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

    public Certification getCertification() {
        return certification;
    }

    public void setCertification(Certification certification) {
        this.certification = certification;
    }

    public EntryType getEntryType() {
        return entryType;
    }

    public void setEntryType(EntryType entryType) {
        this.entryType = entryType;
    }

    public Integer getSequenceOrder() {
        return sequenceOrder;
    }

    public void setSequenceOrder(Integer sequenceOrder) {
        this.sequenceOrder = sequenceOrder;
    }

    public CertificationStep getDirectStep() {
        return directStep;
    }

    public void setDirectStep(CertificationStep directStep) {
        this.directStep = directStep;
    }

    public String getChoiceLabel() {
        return choiceLabel;
    }

    public void setChoiceLabel(String choiceLabel) {
        this.choiceLabel = choiceLabel;
    }

    public String getChoiceDescription() {
        return choiceDescription;
    }

    public void setChoiceDescription(String choiceDescription) {
        this.choiceDescription = choiceDescription;
    }

    public Integer getMinRequired() {
        return minRequired;
    }

    public void setMinRequired(Integer minRequired) {
        this.minRequired = minRequired;
    }

    public Integer getMaxRequired() {
        return maxRequired;
    }

    public void setMaxRequired(Integer maxRequired) {
        this.maxRequired = maxRequired;
    }

    public List<ChoiceVariant> getVariants() {
        return variants;
    }

    public void setVariants(List<ChoiceVariant> variants) {
        this.variants = variants;
    }

    public String getDirectStepId() {
        return directStep != null ? directStep.getId() : null;
    }
}
