-- Change default for info_expanded to TRUE so Key Concepts section is open by default
-- Using H2-compatible syntax (ALTER COLUMN)
ALTER TABLE T_certification_step ALTER COLUMN info_expanded SET DEFAULT TRUE;

-- Update existing steps to have Key Concepts open by default
UPDATE T_certification_step SET info_expanded = TRUE;
