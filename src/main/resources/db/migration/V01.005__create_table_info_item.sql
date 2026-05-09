-- T_info_item: Key term definitions within steps
CREATE TABLE T_info_item (
    id VARCHAR(36) NOT NULL,
    step_id VARCHAR(36) NOT NULL,
    term VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    sequence_order INT NOT NULL,
    CONSTRAINT PK_info_item PRIMARY KEY (id),
    CONSTRAINT FK_info_item_step FOREIGN KEY (step_id) REFERENCES T_certification_step(id) ON DELETE CASCADE
);

CREATE INDEX I_info_item_step_seq ON T_info_item(step_id, sequence_order);
