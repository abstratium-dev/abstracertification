package dev.abstratium.certification.entity;

import java.time.LocalDateTime;
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
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;

/**
 * Represents a single step within a {@link Certification}.
 * Each step contains learning content: an explanation of "why" this step matters,
 * a list of {@link InfoItem} key concepts, a sequence of {@link Instruction} tasks,
 * and {@link Question} comprehension checks.
 *
 * <p>Steps are referenced by {@link PageEntry} (for direct steps) or by
 * {@link ChoiceVariant} (for steps activated by user choice). The {@code stepKey}
 * is a human-readable identifier used for cross-referencing within a certification.</p>
 */
@Entity
@Table(name = "T_certification_step")
public class CertificationStep {

    @Id
    @Column(length = 36)
    private String id;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "certification_id", nullable = false, foreignKey = @jakarta.persistence.ForeignKey(name = "FK_step_certification"))
    private Certification certification;

    @Column(name = "step_key", nullable = false, length = 50)
    private String stepKey;

    @Column(nullable = false, length = 255)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String why;

    @Column(name = "info_expanded", nullable = false)
    private Boolean infoExpanded = false;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "step", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<InfoItem> infoItems = new ArrayList<>();

    @OneToMany(mappedBy = "step", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Instruction> instructions = new ArrayList<>();

    @OneToMany(mappedBy = "step", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Question> questions = new ArrayList<>();

    @PrePersist
    public void prePersist() {
        if (id == null) {
            id = UUID.randomUUID().toString();
        }
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    public void preUpdate() {
        updatedAt = LocalDateTime.now();
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

    public String getStepKey() {
        return stepKey;
    }

    public void setStepKey(String stepKey) {
        this.stepKey = stepKey;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getWhy() {
        return why;
    }

    public void setWhy(String why) {
        this.why = why;
    }

    public Boolean getInfoExpanded() {
        return infoExpanded;
    }

    public void setInfoExpanded(Boolean infoExpanded) {
        this.infoExpanded = infoExpanded;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public List<InfoItem> getInfoItems() {
        return infoItems;
    }

    public void setInfoItems(List<InfoItem> infoItems) {
        this.infoItems = infoItems;
    }

    public List<Instruction> getInstructions() {
        return instructions;
    }

    public void setInstructions(List<Instruction> instructions) {
        this.instructions = instructions;
    }

    public List<Question> getQuestions() {
        return questions;
    }

    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }
}
