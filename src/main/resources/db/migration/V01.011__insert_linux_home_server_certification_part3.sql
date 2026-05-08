-- Continue: Page entries
-- Entry 1: Direct intro step
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('pe-1', 'linux-home-server', 'DIRECT', 0, 'step-intro', NULL, NULL, NULL, NULL);

-- Entry 2: Choice for installing Linux
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('pe-2', 'linux-home-server', 'CHOICE', 1, NULL, 'Installing Linux', 'Choose how to create your bootable USB drive based on the operating system you are starting from.', 1, 1);

-- Choice variants
INSERT INTO T_choice_variant (id, page_entry_id, label, description, step_id, sequence_order)
VALUES ('cv-1', 'pe-2', 'Starting from Windows (Rufus)', 'Use Rufus on Windows to create the bootable USB drive.', 'step-install-win', 0);

INSERT INTO T_choice_variant (id, page_entry_id, label, description, step_id, sequence_order)
VALUES ('cv-2', 'pe-2', 'Starting from Linux (dd)', 'Use the dd command on Linux to create the bootable USB drive.', 'step-install-linux', 1);

-- Entry 3-8: Direct steps
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('pe-3', 'linux-home-server', 'DIRECT', 2, 'step-nginx', NULL, NULL, NULL, NULL);

INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('pe-4', 'linux-home-server', 'DIRECT', 3, 'step-ufw', NULL, NULL, NULL, NULL);

INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('pe-5', 'linux-home-server', 'DIRECT', 4, 'step-sshd', NULL, NULL, NULL, NULL);

INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('pe-6', 'linux-home-server', 'DIRECT', 5, 'step-portfwd', NULL, NULL, NULL, NULL);

INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('pe-7', 'linux-home-server', 'DIRECT', 6, 'step-ddns', NULL, NULL, NULL, NULL);

-- Questions and answers for install-windows step
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-win-1', 'step-install-win', 'q-install-win-1', 'Why is Linux preferred over Windows for a home server?', 0);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-win-1-0', 'q-win-1', 'Linux has better gaming support', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-win-1-1', 'q-win-1', 'Linux is free, open-source, stable, and has excellent networking and server support', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-win-1-2', 'q-win-1', 'Linux comes pre-installed on most hardware', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-win-1-3', 'q-win-1', 'Linux does not require any updates', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-win-2', 'step-install-win', 'q-install-win-2', 'Why should you choose GPT partition scheme in Rufus for modern hardware?', 1);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-win-2-0', 'q-win-2', 'GPT is faster than MBR', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-win-2-1', 'q-win-2', 'GPT is required for UEFI boot, which is the standard on modern hardware', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-win-2-2', 'q-win-2', 'GPT encrypts the USB drive', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-win-2-3', 'q-win-2', 'GPT allows you to install multiple operating systems on the USB', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-win-3', 'step-install-win', 'q-install-win-3', 'Why is LVM recommended for disk setup?', 2);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-win-3-0', 'q-win-3', 'It makes the disk faster', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-win-3-1', 'q-win-3', 'It provides flexibility to resize partitions and manage storage later', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-win-3-2', 'q-win-3', 'It encrypts the entire disk automatically', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-win-3-3', 'q-win-3', 'It is the only option that Ubuntu supports', FALSE, 3);

-- Questions and answers for install-linux step
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-linux-1', 'step-install-linux', 'q-install-linux-1', 'Why is Linux preferred over Windows for a home server?', 0);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-linux-1-0', 'q-linux-1', 'Linux has better gaming support', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-linux-1-1', 'q-linux-1', 'Linux is free, open-source, stable, and has excellent networking and server support', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-linux-1-2', 'q-linux-1', 'Linux comes pre-installed on most hardware', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-linux-1-3', 'q-linux-1', 'Linux does not require any updates', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-linux-2', 'step-install-linux', 'q-install-linux-2', 'What does the ''dd'' command do when creating a bootable USB?', 1);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-linux-2-0', 'q-linux-2', 'It downloads the ISO file from the internet', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-linux-2-1', 'q-linux-2', 'It formats the USB drive to NTFS', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-linux-2-2', 'q-linux-2', 'It copies the ISO image byte-by-byte to the USB device', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-linux-2-3', 'q-linux-2', 'It installs Linux directly onto the server', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-linux-3', 'step-install-linux', 'q-install-linux-3', 'Why is it critical to identify the correct device before running dd?', 2);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-linux-3-0', 'q-linux-3', 'dd will not work on the wrong device', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-linux-3-1', 'q-linux-3', 'dd overwrites the target device completely — selecting the wrong one could destroy your system', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-linux-3-2', 'q-linux-3', 'The wrong device will be too slow', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-linux-3-3', 'q-linux-3', 'dd requires a specific device name format', FALSE, 3);
