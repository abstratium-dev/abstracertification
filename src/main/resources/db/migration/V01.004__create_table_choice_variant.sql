-- T_choice_variant: Selectable options within choice page entries
CREATE TABLE T_choice_variant (
    id VARCHAR(36) NOT NULL,
    page_entry_id VARCHAR(36) NOT NULL,
    label VARCHAR(255) NOT NULL,
    description TEXT,
    step_id VARCHAR(36) NOT NULL,
    sequence_order INT NOT NULL,
    CONSTRAINT PK_choice_variant PRIMARY KEY (id),
    CONSTRAINT FK_choice_variant_page_entry FOREIGN KEY (page_entry_id) REFERENCES T_page_entry(id) ON DELETE CASCADE,
    CONSTRAINT FK_choice_variant_step FOREIGN KEY (step_id) REFERENCES T_certification_step(id) ON DELETE CASCADE
);

CREATE INDEX I_choice_variant_page_seq ON T_choice_variant(page_entry_id, sequence_order);
