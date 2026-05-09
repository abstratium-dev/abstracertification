-- T_instruction: Sequential instructions for completing steps
CREATE TABLE T_instruction (
    id VARCHAR(36) NOT NULL,
    step_id VARCHAR(36) NOT NULL,
    text TEXT NOT NULL,
    command TEXT,
    note TEXT,
    mermaid_diagram TEXT,
    sequence_order INT NOT NULL,
    CONSTRAINT PK_instruction PRIMARY KEY (id),
    CONSTRAINT FK_instruction_step FOREIGN KEY (step_id) REFERENCES T_certification_step(id) ON DELETE CASCADE
);

CREATE INDEX I_instruction_step_seq ON T_instruction(step_id, sequence_order);
