-- T_certification: Root table for certification definitions
CREATE TABLE T_certification (
    id VARCHAR(36) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_certification PRIMARY KEY (id),
    CONSTRAINT I_certification_title UNIQUE (title)
);

CREATE INDEX I_certification_updated ON T_certification(updated_at);
