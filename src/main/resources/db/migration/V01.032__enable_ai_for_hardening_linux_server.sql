-- Enable AI assistance for the "Hardening a Linux Server" certification
-- This update script sets ai_enabled = true specifically for the Hardening a Linux Server certification

UPDATE T_certification 
SET ai_enabled = TRUE 
WHERE title = 'Hardening a Linux Server';
