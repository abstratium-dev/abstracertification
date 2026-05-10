-- T_feedback: User feedback on instructions or pages
CREATE TABLE T_feedback (
    id VARCHAR(36) NOT NULL,
    feedback_type VARCHAR(20) NOT NULL,
    target_id VARCHAR(36) NOT NULL,
    certification_id VARCHAR(36) NOT NULL,
    feedback_text TEXT NOT NULL,
    ip_address VARCHAR(45),
    username VARCHAR(255),
    created_at TIMESTAMP NOT NULL,
    CONSTRAINT PK_feedback PRIMARY KEY (id),
    CONSTRAINT FK_feedback_certification FOREIGN KEY (certification_id) REFERENCES T_certification(id) ON DELETE CASCADE
);

CREATE INDEX I_feedback_certification ON T_feedback(certification_id);
CREATE INDEX I_feedback_target ON T_feedback(target_id, feedback_type);
CREATE INDEX I_feedback_created_at ON T_feedback(created_at);
