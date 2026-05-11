package dev.abstratium.certification.entity;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;

/**
 * Root aggregate entity representing a certification module.
 * A certification is an ordered learning path composed of {@link PageEntry} items
 * that reference {@link CertificationStep} content. Steps contain instructions,
 * info items, and questions that guide the user through the certification.
 *
 * <p>The {@code steps} collection holds all steps belonging to this certification.
 * The {@code pageEntries} collection defines the presentation order and structure
 * (direct steps or choice points).</p>
 */
@Entity
@Table(name = "T_certification")
public class Certification {

    @Id
    @Column(length = 36)
    private String id;

    @Column(nullable = false, unique = true, length = 255)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @Column(name = "coming_soon", nullable = false)
    private Boolean comingSoon = false;

    @Column(name = "sequence_order", nullable = false)
    private Integer sequenceOrder = 0;

    @OneToMany(mappedBy = "certification", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<CertificationStep> steps = new ArrayList<>();

    @OneToMany(mappedBy = "certification", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<PageEntry> pageEntries = new ArrayList<>();

    @PrePersist
    public void prePersist() {
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public Boolean getComingSoon() {
        return comingSoon;
    }

    public void setComingSoon(Boolean comingSoon) {
        this.comingSoon = comingSoon;
    }

    public Integer getSequenceOrder() {
        return sequenceOrder;
    }

    public void setSequenceOrder(Integer sequenceOrder) {
        this.sequenceOrder = sequenceOrder;
    }

    public List<CertificationStep> getSteps() {
        return steps;
    }

    public void setSteps(List<CertificationStep> steps) {
        this.steps = steps;
    }

    public List<PageEntry> getPageEntries() {
        return pageEntries;
    }

    public void setPageEntries(List<PageEntry> pageEntries) {
        this.pageEntries = pageEntries;
    }
}
