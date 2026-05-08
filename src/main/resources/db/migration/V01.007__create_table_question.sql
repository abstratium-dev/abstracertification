-- T_question: Assessment questions for verifying understanding
CREATE TABLE T_question (
    id VARCHAR(36) NOT NULL,
    step_id VARCHAR(36) NOT NULL,
    question_key VARCHAR(50) NOT NULL,
    text TEXT NOT NULL,
    sequence_order INT NOT NULL,
    CONSTRAINT PK_question PRIMARY KEY (id),
    CONSTRAINT FK_question_step FOREIGN KEY (step_id) REFERENCES T_certification_step(id),
    CONSTRAINT I_question_step_key UNIQUE (step_id, question_key)
);

CREATE INDEX I_question_step_seq ON T_question(step_id, sequence_order);
