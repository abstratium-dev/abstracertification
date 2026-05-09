-- T_page_entry: Navigation flow entries for certifications
CREATE TABLE T_page_entry (
    id VARCHAR(36) NOT NULL,
    certification_id VARCHAR(36) NOT NULL,
    entry_type VARCHAR(20) NOT NULL,
    sequence_order INT NOT NULL,
    direct_step_id VARCHAR(36),
    choice_label VARCHAR(255),
    choice_description TEXT,
    min_required INT,
    max_required INT,
    CONSTRAINT PK_page_entry PRIMARY KEY (id),
    CONSTRAINT FK_page_entry_certification FOREIGN KEY (certification_id) REFERENCES T_certification(id) ON DELETE CASCADE,
    CONSTRAINT FK_page_entry_step FOREIGN KEY (direct_step_id) REFERENCES T_certification_step(id) ON DELETE SET NULL,
    CONSTRAINT I_page_entry_cert_seq UNIQUE (certification_id, sequence_order),
    CONSTRAINT CHK_page_entry_type CHECK (entry_type IN ('DIRECT', 'CHOICE'))
);

CREATE INDEX I_page_entry_step ON T_page_entry(direct_step_id);
