-- T_certification_step: Individual learning steps within certifications
CREATE TABLE T_certification_step (
    id VARCHAR(36) NOT NULL,
    certification_id VARCHAR(36) NOT NULL,
    step_key VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    why TEXT,
    info_expanded BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_certification_step PRIMARY KEY (id),
    CONSTRAINT FK_step_certification FOREIGN KEY (certification_id) REFERENCES T_certification(id) ON DELETE CASCADE,
    CONSTRAINT I_step_cert_key UNIQUE (certification_id, step_key)
);

CREATE INDEX I_step_updated ON T_certification_step(updated_at);
