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
 * A single actionable instruction within a {@link CertificationStep}.
 * Instructions form the "What to do" section and guide the user through
 * concrete tasks. Each instruction has required {@code text} and optional
 * {@code command} (shell command to run), {@code note} (additional context),
 * and {@code mermaidDiagram} (rendered as a Mermaid chart in the UI).
 */
@Entity
@Table(name = "T_instruction")
public class Instruction {

    @Id
    @Column(length = 36)
    private String id;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "step_id", nullable = false, foreignKey = @jakarta.persistence.ForeignKey(name = "FK_instruction_step"))
    private CertificationStep step;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String text;

    @Column(columnDefinition = "TEXT")
    private String command;

    @Column(columnDefinition = "TEXT")
    private String note;

    @Column(name = "mermaid_diagram", columnDefinition = "TEXT")
    private String mermaidDiagram;

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

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getCommand() {
        return command;
    }

    public void setCommand(String command) {
        this.command = command;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getMermaidDiagram() {
        return mermaidDiagram;
    }

    public void setMermaidDiagram(String mermaidDiagram) {
        this.mermaidDiagram = mermaidDiagram;
    }

    public Integer getSequenceOrder() {
        return sequenceOrder;
    }

    public void setSequenceOrder(Integer sequenceOrder) {
        this.sequenceOrder = sequenceOrder;
    }
}
