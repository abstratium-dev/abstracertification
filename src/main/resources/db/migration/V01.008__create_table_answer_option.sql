-- T_answer_option: Answer options for multiple-choice questions
CREATE TABLE T_answer_option (
    id VARCHAR(36) NOT NULL,
    question_id VARCHAR(36) NOT NULL,
    text TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL DEFAULT FALSE,
    sequence_order INT NOT NULL,
    CONSTRAINT PK_answer_option PRIMARY KEY (id),
    CONSTRAINT FK_answer_option_question FOREIGN KEY (question_id) REFERENCES T_question(id)
);

CREATE INDEX I_answer_option_question_seq ON T_answer_option(question_id, sequence_order);
