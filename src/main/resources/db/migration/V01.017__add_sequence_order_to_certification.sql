-- Add sequence_order column to T_certification for explicit display ordering
ALTER TABLE T_certification ADD COLUMN sequence_order INT NOT NULL DEFAULT 0;

-- Linux Home Server first, Hardening second
UPDATE T_certification SET sequence_order = 0 WHERE id = 'linux-home-server';
UPDATE T_certification SET sequence_order = 1 WHERE id = 'hardening-linux-server';
