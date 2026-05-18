package dev.abstratium.certification.boundary.publik;

import dev.abstratium.certification.entity.Certification;
import io.quarkus.runtime.annotations.RegisterForReflection;

@RegisterForReflection
public record CertificationSummary(String id, String title, String description, boolean comingSoon, boolean aiEnabled) {

    public static CertificationSummary from(Certification certification) {
        return new CertificationSummary(
                certification.getId(),
                certification.getTitle(),
                certification.getDescription(),
                Boolean.TRUE.equals(certification.getComingSoon()),
                Boolean.TRUE.equals(certification.getAiEnabled())
        );
    }
}
