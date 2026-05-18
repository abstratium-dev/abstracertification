-- Make "Hardening a Linux Server" certification available (coming_soon = FALSE)
UPDATE T_certification SET coming_soon = FALSE, updated_at = CURRENT_TIMESTAMP WHERE id = 'hardening-linux-server';
