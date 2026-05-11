-- Add coming_soon flag to T_certification
-- Certifications marked as coming_soon=TRUE are displayed in the list
-- but cannot be started by users (they only have an introduction page).
ALTER TABLE T_certification ADD COLUMN coming_soon BOOLEAN NOT NULL DEFAULT FALSE;
