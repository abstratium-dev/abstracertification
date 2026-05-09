-- Continue: Page entries
-- Entry 1: Direct intro step (Welcome to Your Home Server Journey)
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('4df3650f-6849-4cd7-8eaa-611b06adf437', 'linux-home-server', 'DIRECT', 0, '9b67ca79-603b-4d2d-8bdb-af8bef07b388', NULL, NULL, NULL, NULL);

-- Entry 2: Choice for installing Linux
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('0c50d416-1d9d-4987-99ef-77ee562083df', 'linux-home-server', 'CHOICE', 1, NULL, 'Installing Linux', 'In order to install Linux, you first need to create a USB drive with the installation image. Choose how to create your bootable USB drive based on the operating system you are starting from.', 1, 1);

-- Choice variants for installing Linux
INSERT INTO T_choice_variant (id, page_entry_id, label, description, step_id, sequence_order)
VALUES ('3e3276e5-b91e-4a18-aff7-0244ff19a9af', '0c50d416-1d9d-4987-99ef-77ee562083df', 'Starting from Windows (Rufus)', 'Use Rufus on Windows to create the bootable USB drive.', 'dab542a6-77df-4032-b273-d9f7fa027993', 0);

INSERT INTO T_choice_variant (id, page_entry_id, label, description, step_id, sequence_order)
VALUES ('4c070ec3-0d53-4323-840a-6d38ab944738', '0c50d416-1d9d-4987-99ef-77ee562083df', 'Starting from Linux (dd)', 'Use the dd command on Linux to create the bootable USB drive.', 'f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 1);

-- Entry 3: Configuring the SSH Daemon (sshd)
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('3fd5503b-a4b4-46ab-bb8a-36490d7ebaf2', 'linux-home-server', 'DIRECT', 2, 'ec4bcbdd-dabc-4c76-a967-470c14e8adc4', NULL, NULL, NULL, NULL);

-- Entry 4: Choice for connecting to the server using SSH (NEW)
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('c7a8b9d0-e1f2-4a3b-5c6d-7e8f9a0b1c2d', 'linux-home-server', 'CHOICE', 3, NULL, 'Connecting to the Server Using SSH', 'Choose how to connect to your server based on the operating system you are using on your local machine.', 1, 1);

-- Choice variants for SSH connection
INSERT INTO T_choice_variant (id, page_entry_id, label, description, step_id, sequence_order)
VALUES ('d8e9f0a1-b2c3-4d4e-5f6a-7b8c9d0e1f2a', 'c7a8b9d0-e1f2-4a3b-5c6d-7e8f9a0b1c2d', 'Connecting from Windows', 'Use the built-in OpenSSH client on Windows to connect to your server and transfer files with SCP.', 'a1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e', 0);

INSERT INTO T_choice_variant (id, page_entry_id, label, description, step_id, sequence_order)
VALUES ('e9f0a1b2-c3d4-4e5f-6a7b-8c9d0e1f2a3b', 'c7a8b9d0-e1f2-4a3b-5c6d-7e8f9a0b1c2d', 'Connecting from Linux', 'Use the OpenSSH client on Linux to connect to your server and transfer files with SCP.', 'b2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', 1);

-- Entry 5: Installing and Configuring Nginx
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('878fefaa-6880-4761-8af6-2c121b37e53c', 'linux-home-server', 'DIRECT', 4, '4b4023e4-e123-42fe-8fb9-154cb11d2833', NULL, NULL, NULL, NULL);

-- Entry 6: Setting Up UFW (Uncomplicated Firewall)
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('e1e758e4-b0ab-4196-9c66-7aaddeb4ea98', 'linux-home-server', 'DIRECT', 5, '05782de5-0676-48bc-825e-a126969086bb', NULL, NULL, NULL, NULL);

-- Entry 7: Setting Up Port Forwarding on Your Router
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('4856ed6e-4100-46ca-afd4-0113215bd31c', 'linux-home-server', 'DIRECT', 6, 'ff7f23e8-1c03-467a-a1da-7abfa901bacf', NULL, NULL, NULL, NULL);

-- Entry 8: Setting Up Dynamic DNS with No-IP
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('6f67fca6-e2af-44ff-8128-cf1b4804c759', 'linux-home-server', 'DIRECT', 7, '6d688465-40a8-4de1-b60c-7794b07492a5', NULL, NULL, NULL, NULL);

-- Questions and answers for install-windows step
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('bddd3031-16a1-4b5b-a5c0-523bc91d8ecf', 'dab542a6-77df-4032-b273-d9f7fa027993', 'q-install-win-1', 'Why is Linux preferred over Windows for a home server?', 0);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('f32dabf5-688a-46d0-aabc-79e1dbc2528f', 'bddd3031-16a1-4b5b-a5c0-523bc91d8ecf', 'Linux has better gaming support', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('2a57d7a0-0c8c-44c3-84eb-5766e9c5217d', 'bddd3031-16a1-4b5b-a5c0-523bc91d8ecf', 'Linux is free, open-source, stable, and has excellent networking and server support', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('201467ec-fb99-4b9f-a147-fb0904d69620', 'bddd3031-16a1-4b5b-a5c0-523bc91d8ecf', 'Linux comes pre-installed on most hardware', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('53985448-cdd7-4262-b2a8-a3d7742df79b', 'bddd3031-16a1-4b5b-a5c0-523bc91d8ecf', 'Linux does not require any updates', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('3b1deed9-7b42-46e1-99a1-76b9e9899847', 'dab542a6-77df-4032-b273-d9f7fa027993', 'q-install-win-2', 'Why should you choose GPT partition scheme in Rufus for modern hardware?', 1);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a66453a1-29a5-44e6-9231-1a5478763f69', '3b1deed9-7b42-46e1-99a1-76b9e9899847', 'GPT is faster than MBR', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('8f6f565a-4cc9-493b-8230-92a7258c9f76', '3b1deed9-7b42-46e1-99a1-76b9e9899847', 'GPT is required for UEFI boot, which is the standard on modern hardware', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('517ae94e-796a-45dc-8387-a80b0ef63e68', '3b1deed9-7b42-46e1-99a1-76b9e9899847', 'GPT encrypts the USB drive', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('f4fa1beb-0e47-41d6-ac87-054190b22191', '3b1deed9-7b42-46e1-99a1-76b9e9899847', 'GPT allows you to install multiple operating systems on the USB', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('7c8d14ed-7820-440a-9774-71738044aa30', 'dab542a6-77df-4032-b273-d9f7fa027993', 'q-install-win-3', 'Why is LVM recommended for disk setup?', 2);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('e9d212ee-7ba3-4d3e-a794-5e3c2f83c926', '7c8d14ed-7820-440a-9774-71738044aa30', 'It makes the disk faster', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('7cf0ba54-3733-4f08-8e64-6e252cf9a091', '7c8d14ed-7820-440a-9774-71738044aa30', 'It provides flexibility to resize partitions and manage storage later', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('e1f89471-5056-4335-ac25-eba91a5fc203', '7c8d14ed-7820-440a-9774-71738044aa30', 'It encrypts the entire disk automatically', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('31ae02a5-01da-45af-bf74-7e70f1abf45f', '7c8d14ed-7820-440a-9774-71738044aa30', 'It is the only option that Ubuntu supports', FALSE, 3);

-- Questions and answers for install-linux step
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('44816a0c-be47-4003-9221-3c9ea047c1cf', 'f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 'q-install-linux-1', 'Why is Linux preferred over Windows for a home server?', 0);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('d775ed9d-ee6b-4fb2-99cc-0a5cd369379a', '44816a0c-be47-4003-9221-3c9ea047c1cf', 'Linux has better gaming support', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('e9c6b2d1-6e84-4d8f-b3c8-5fe5517a5056', '44816a0c-be47-4003-9221-3c9ea047c1cf', 'Linux is free, open-source, stable, and has excellent networking and server support', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('d71081c9-ddb4-487f-a5b3-705afa57d019', '44816a0c-be47-4003-9221-3c9ea047c1cf', 'Linux comes pre-installed on most hardware', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('de6e104d-7f23-45f3-9570-94da7fa95354', '44816a0c-be47-4003-9221-3c9ea047c1cf', 'Linux does not require any updates', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('d46909b1-5aac-4375-bfa4-5e6e9c121a54', 'f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 'q-install-linux-2', 'What does the ''dd'' command do when creating a bootable USB?', 1);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('2db0f8f2-be28-4a6b-8d94-5efc7cddd09e', 'd46909b1-5aac-4375-bfa4-5e6e9c121a54', 'It downloads the ISO file from the internet', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('6d57685c-ef8b-4a1b-ac45-21022f3ec61a', 'd46909b1-5aac-4375-bfa4-5e6e9c121a54', 'It formats the USB drive to NTFS', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('f4d1540a-9776-4f56-884b-2f235199c5ce', 'd46909b1-5aac-4375-bfa4-5e6e9c121a54', 'It copies the ISO image byte-by-byte to the USB device', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('e2b30a1e-5b53-4432-8783-a5c86f951bb5', 'd46909b1-5aac-4375-bfa4-5e6e9c121a54', 'It installs Linux directly onto the server', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('1ab60f57-8b91-4cc0-8c1d-c0b0f45d26b7', 'f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 'q-install-linux-3', 'Why is it critical to identify the correct device before running dd?', 2);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('f20057f8-58e1-4430-b2c7-9666cb8a726d', '1ab60f57-8b91-4cc0-8c1d-c0b0f45d26b7', 'dd will not work on the wrong device', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('9677409a-e2c0-4e8f-b5da-92b1cdf7c24f', '1ab60f57-8b91-4cc0-8c1d-c0b0f45d26b7', 'dd overwrites the target device completely — selecting the wrong one could destroy your system', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('caa4bb90-b1b0-4daf-9d44-cbec33f38376', '1ab60f57-8b91-4cc0-8c1d-c0b0f45d26b7', 'The wrong device will be too slow', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('6a059362-9abe-42ec-8af6-1dfea6aa000a', '1ab60f57-8b91-4cc0-8c1d-c0b0f45d26b7', 'dd requires a specific device name format', FALSE, 3);
