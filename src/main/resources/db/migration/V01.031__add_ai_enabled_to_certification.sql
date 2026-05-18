-- Add ai_enabled column to T_certification table
-- This column controls whether AI assistance is available for a specific certification
-- Default value is false to maintain backward compatibility

ALTER TABLE T_certification ADD COLUMN ai_enabled BOOLEAN NOT NULL DEFAULT FALSE;
