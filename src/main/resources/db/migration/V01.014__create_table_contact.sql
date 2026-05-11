-- T_contact: Contact form submissions
CREATE TABLE T_contact (
    id VARCHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    query TEXT NOT NULL,
    context VARCHAR(100),
    ip_address VARCHAR(45),
    created_at TIMESTAMP NOT NULL,
    CONSTRAINT PK_contact PRIMARY KEY (id)
);

CREATE INDEX I_contact_email ON T_contact(email);
CREATE INDEX I_contact_created_at ON T_contact(created_at);
