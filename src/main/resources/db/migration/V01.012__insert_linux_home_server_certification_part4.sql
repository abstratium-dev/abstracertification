-- Continue: Questions and answers for nginx step
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('a4de5a5b-3659-4646-b422-1e5e3ff60ba9', '4b4023e4-e123-42fe-8fb9-154cb11d2833', 'q-nginx-1', 'What is the primary role of Nginx on a home server?', 0);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('802eea62-db44-4a34-af38-ea3db37d8211', 'a4de5a5b-3659-4646-b422-1e5e3ff60ba9', 'It provides a firewall for your network', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('95176b9d-6aae-4fb4-b9f5-32d6f4121574', 'a4de5a5b-3659-4646-b422-1e5e3ff60ba9', 'It serves web pages and acts as a reverse proxy', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a6a2379c-596c-42e9-8cfc-a7c8fe95257c', 'a4de5a5b-3659-4646-b422-1e5e3ff60ba9', 'It manages user accounts on the system', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('25c36cd7-c61e-4dee-b760-4232bbb74a78', 'a4de5a5b-3659-4646-b422-1e5e3ff60ba9', 'It provides DNS resolution', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('4606c7ed-ebb3-4465-892c-3d4db52080b8', '4b4023e4-e123-42fe-8fb9-154cb11d2833', 'q-nginx-2', 'What does ''systemctl enable nginx'' do?', 1);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('c0b3c9e1-4bc3-437f-ade8-0000357e9995', '4606c7ed-ebb3-4465-892c-3d4db52080b8', 'It starts Nginx immediately', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('4948d1ff-4c1b-4cd4-b72c-2f4d138568c9', '4606c7ed-ebb3-4465-892c-3d4db52080b8', 'It installs Nginx from the repository', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('8f6660a5-1d10-46d9-adb7-dc79fdee5fe9', '4606c7ed-ebb3-4465-892c-3d4db52080b8', 'It configures Nginx to start automatically when the server boots', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('26fee222-78a4-4489-a9fd-fe7f23586aa7', '4606c7ed-ebb3-4465-892c-3d4db52080b8', 'It opens port 80 in the firewall', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('5d312ea7-3d92-48e6-9a6e-84f32f367c8b', '4b4023e4-e123-42fe-8fb9-154cb11d2833', 'q-nginx-3', 'Why should you run ''nginx -t'' before reloading the configuration?', 2);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('32e7f91c-a5b7-464f-a70d-d82f564a5cd1', '5d312ea7-3d92-48e6-9a6e-84f32f367c8b', 'To benchmark the server''s performance', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('60f83583-7ee4-4f62-a10e-14a38933b68e', '5d312ea7-3d92-48e6-9a6e-84f32f367c8b', 'To test the configuration for syntax errors before applying it', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('aef23202-9174-494c-9a9c-c2634dce303e', '5d312ea7-3d92-48e6-9a6e-84f32f367c8b', 'To display the Nginx version', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('b4845919-6916-496f-a545-796aa13c5599', '5d312ea7-3d92-48e6-9a6e-84f32f367c8b', 'To list all active connections', FALSE, 3);

-- Questions and answers for ufw step
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('26dd8d4a-3fd4-4ce4-929f-2b9267a6fe0e', '05782de5-0676-48bc-825e-a126969086bb', 'q-ufw-1', 'Why must you allow SSH before enabling UFW?', 0);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('340b6f27-8e73-4b84-8969-cbf8cfb1d5ab', '26dd8d4a-3fd4-4ce4-929f-2b9267a6fe0e', 'SSH is required for UFW to function', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('6ca66529-4199-4d50-b990-ea4e58ca2408', '26dd8d4a-3fd4-4ce4-929f-2b9267a6fe0e', 'Without allowing SSH, you could lock yourself out of the server remotely', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('da922174-2027-4673-a4f7-74035bc39dab', '26dd8d4a-3fd4-4ce4-929f-2b9267a6fe0e', 'UFW does not start without SSH rules', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('05e7da32-6f39-4306-9934-cf9c75a5fdea', '26dd8d4a-3fd4-4ce4-929f-2b9267a6fe0e', 'SSH traffic is always blocked by default on Ubuntu', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('f1314ad7-3207-4f59-b4ba-c0fcbb5d0976', '05782de5-0676-48bc-825e-a126969086bb', 'q-ufw-2', 'What does ''Nginx Full'' include when used with UFW?', 1);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('6735609b-1189-4f52-be78-5506ad9ad248', 'f1314ad7-3207-4f59-b4ba-c0fcbb5d0976', 'Only port 80 (HTTP)', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('4640b71b-e44f-44d1-bae4-f4f2ef13c7f3', 'f1314ad7-3207-4f59-b4ba-c0fcbb5d0976', 'Only port 443 (HTTPS)', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('0152fd7d-3792-4f9a-bfee-03849d64c139', 'f1314ad7-3207-4f59-b4ba-c0fcbb5d0976', 'Both port 80 (HTTP) and port 443 (HTTPS)', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('8916d6fe-59f2-482a-ad20-2a0f984b0c12', 'f1314ad7-3207-4f59-b4ba-c0fcbb5d0976', 'Ports 80, 443, and 8080', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('d228f7d4-1e81-40ae-ba2c-134281a32457', '05782de5-0676-48bc-825e-a126969086bb', 'q-ufw-3', 'What is the default policy of UFW when enabled?', 2);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('aa3c0fec-3ef7-4d84-bb47-be723b2395a5', 'd228f7d4-1e81-40ae-ba2c-134281a32457', 'Allow all incoming and outgoing traffic', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('b0f25121-4eb3-4980-968a-f81a32a85e64', 'd228f7d4-1e81-40ae-ba2c-134281a32457', 'Deny all incoming traffic and allow all outgoing traffic', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('4a8862bc-2cc6-44b6-91c5-6c33b6b0a483', 'd228f7d4-1e81-40ae-ba2c-134281a32457', 'Block all traffic in both directions', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('7d9ce5e0-4660-4670-9518-f4e29a7df17b', 'd228f7d4-1e81-40ae-ba2c-134281a32457', 'Allow all incoming traffic and deny all outgoing traffic', FALSE, 3);

-- Questions and answers for sshd step
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('1e69daf9-7b93-47d7-b9b0-795ae73436e2', 'ec4bcbdd-dabc-4c76-a967-470c14e8adc4', 'q-ssh-1', 'What does disabling root login via SSH actually prevent?', 0);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('97842594-0f90-4de4-91ff-5036e907b060', '1e69daf9-7b93-47d7-b9b0-795ae73436e2', 'It removes root from the system entirely', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('87591bb2-e9bb-4d3f-ade6-a2325898eb00', '1e69daf9-7b93-47d7-b9b0-795ae73436e2', 'It prevents logging in directly as root over SSH — you can still gain root privileges on the server using sudo or su once logged in as a regular user', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('e7a37afe-d21e-41a6-b4a2-4d39d9731596', '1e69daf9-7b93-47d7-b9b0-795ae73436e2', 'It blocks all administrative actions on the server', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('4aa4ba46-ef24-4f19-b465-1b3238b8b19b', '1e69daf9-7b93-47d7-b9b0-795ae73436e2', 'It disables sudo and su commands', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('da03aa02-cf4a-4a9f-9d9a-d000ff374c25', 'ec4bcbdd-dabc-4c76-a967-470c14e8adc4', 'q-ssh-2', 'What is sshd and what is its role on the server?', 1);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('5859d9ac-2c1f-4806-a862-10ac113f0c47', 'da03aa02-cf4a-4a9f-9d9a-d000ff374c25', 'A tool for transferring files between servers', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a9fa7d3e-2360-4bcd-8468-8454fc55526e', 'da03aa02-cf4a-4a9f-9d9a-d000ff374c25', 'The SSH daemon — a background service that listens for incoming SSH connections and handles authentication', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('e3f3551d-fb9e-489e-bf93-a1f2d72872ed', 'da03aa02-cf4a-4a9f-9d9a-d000ff374c25', 'A command you run manually each time you want to allow a remote connection', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('0096f2af-dfc7-4ef2-84d5-7ab5a3a0111f', 'da03aa02-cf4a-4a9f-9d9a-d000ff374c25', 'A firewall that blocks unauthorised SSH traffic', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('c8daeee0-aecd-4061-a075-1bd9e5b123a7', 'ec4bcbdd-dabc-4c76-a967-470c14e8adc4', 'q-ssh-3', 'Why does changing the default SSH port from 22 to a non-standard port help security?', 2);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('159a86e2-3f29-4b7d-9603-20e614327506', 'c8daeee0-aecd-4061-a075-1bd9e5b123a7', 'It encrypts SSH traffic more strongly', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('71ba9c0b-acf5-4860-a71b-9226660547a3', 'c8daeee0-aecd-4061-a075-1bd9e5b123a7', 'It prevents all unauthorised access completely', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a2658b52-d014-4cf1-9c3d-e32e723ef690', 'c8daeee0-aecd-4061-a075-1bd9e5b123a7', 'Automated bots constantly scan port 22; using a different port reduces the volume of brute-force attempts hitting the server', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a4b39f34-5722-409a-9c2f-f19f3c665462', 'c8daeee0-aecd-4061-a075-1bd9e5b123a7', 'It disables SSH entirely when not in use', FALSE, 3);

-- Questions and answers for ssh-connect-windows step
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 'a1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e', 'q-ssh-connect-win-1', 'What interface style should you choose when installing WinSCP, and what does it give you?', 0);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 'Explorer — a single-pane view of the server only', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 'Commander — a dual-pane view with local files on the left and server files on the right', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 'Terminal — a command-line interface for running remote commands', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 'Minimal — a lightweight mode with no file transfer support', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'a1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e', 'q-ssh-connect-win-2', 'What should you do when PuTTY shows a security alert with the server fingerprint on first connection?', 1);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'Always click Accept immediately to save time', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'Compare the displayed fingerprint against the one you obtained directly from the server, then Accept only if they match', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'Click Cancel and reinstall PuTTY', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'The alert can be ignored — it is just a warning, not a security check', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 'a1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e', 'q-ssh-connect-win-3', 'How can you edit a file directly on the server using WinSCP without downloading it first?', 2);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('d0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f4a', 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 'You cannot — you must download the file, edit it locally, then re-upload it', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4a5b', 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 'Right-click the file on the server in WinSCP and choose Edit — WinSCP opens it in its built-in editor and saves it back automatically', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b6c', 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 'Open a PuTTY terminal and use the nano editor', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c7d', 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 'Double-click the file in WinSCP to open it in Notepad', FALSE, 3);

-- Questions and answers for ssh-connect-linux step
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('d4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 'b2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', 'q-ssh-connect-linux-1', 'How do you verify if the OpenSSH client is installed on Linux?', 0);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9c', 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 'Check the system settings GUI', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0d', 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 'Run ssh -V to check for the version output', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1e', 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 'Look for the SSH icon in the application menu', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2f', 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a', 'It is always installed by default on every Linux distribution', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'b2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', 'q-ssh-connect-linux-2', 'What does the -r flag do when using scp?', 1);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0e', 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'It resumes an interrupted transfer', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1f', 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'It copies directories and their contents recursively', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d20', 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'It renames the file during transfer', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e30', 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'It restricts the transfer speed', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'b2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', 'q-ssh-connect-linux-3', 'What does accepting the server fingerprint on first connection protect against?', 2);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c2a', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'Viruses on the server', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d3a', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'Man-in-the-middle attacks — it verifies you are connecting to the real server', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e4a', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'Data loss during file transfers', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('d0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f5a', 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'Unauthorized users accessing your local machine', FALSE, 3);

-- Questions and answers for port-forwarding step
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('c016443e-03a8-4d3d-a926-70ce013a64fe', 'ff7f23e8-1c03-467a-a1da-7abfa901bacf', 'q-port-1', 'Why is port forwarding necessary to access your server from the internet?', 0);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('75aaf94c-73f3-4744-a323-79c72b0c87d2', 'c016443e-03a8-4d3d-a926-70ce013a64fe', 'Linux servers cannot connect to the internet without it', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('5ee34059-84bf-4752-851a-fc87fe919c96', 'c016443e-03a8-4d3d-a926-70ce013a64fe', 'Your router uses NAT, so incoming traffic needs to be explicitly directed to your server''s internal IP', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('b5a74b90-268e-43e2-b60b-6a14dad24102', 'c016443e-03a8-4d3d-a926-70ce013a64fe', 'Port forwarding encrypts the traffic for security', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('6ef79f64-65cd-4c21-aaa8-b0a7aa85aae2', 'c016443e-03a8-4d3d-a926-70ce013a64fe', 'It increases your internet speed', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('d2146dd1-a768-4cf5-a4a6-ccedda5a0e46', 'ff7f23e8-1c03-467a-a1da-7abfa901bacf', 'q-port-2', 'Why should you assign a static IP to your server?', 1);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('b61298b1-c3f8-473e-b080-876431d53f0b', 'd2146dd1-a768-4cf5-a4a6-ccedda5a0e46', 'Static IPs are faster than dynamic ones', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('d3e234a3-1452-431d-9938-54747c06fc8b', 'd2146dd1-a768-4cf5-a4a6-ccedda5a0e46', 'So the port forwarding rules always point to the correct internal address', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('88daecd1-4f6c-40c0-8acc-513545438c81', 'd2146dd1-a768-4cf5-a4a6-ccedda5a0e46', 'DHCP does not work with Linux servers', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('e36a4eb4-c97a-4190-884d-adbb0fee64d2', 'd2146dd1-a768-4cf5-a4a6-ccedda5a0e46', 'It is required by Nginx to function', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('9b466fb7-6f90-404f-bc6b-afbf3f54b6cf', 'ff7f23e8-1c03-467a-a1da-7abfa901bacf', 'q-port-3', 'Should you forward your SSH port to the internet?', 2);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('b59484b7-8f83-4e61-b07a-e3eff7d8da59', '9b466fb7-6f90-404f-bc6b-afbf3f54b6cf', 'Always, it is required for the server to work', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('603da238-8739-4ca7-a726-1d063db778f8', '9b466fb7-6f90-404f-bc6b-afbf3f54b6cf', 'Never, SSH should be completely disabled', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('9387dd5b-968a-4736-9077-0e6a8f25dfdd', '9b466fb7-6f90-404f-bc6b-afbf3f54b6cf', 'Only if you need remote access from outside your network, as it increases attack surface', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('845e1a70-eb46-441c-af10-a5208aa7e116', '9b466fb7-6f90-404f-bc6b-afbf3f54b6cf', 'Only on port 22, never on a custom port', FALSE, 3);

-- Questions and answers for dynamic-dns step
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('a426d6c3-6688-49fa-ad1a-b484e23ac55c', '6d688465-40a8-4de1-b60c-7794b07492a5', 'q-ddns-1', 'Why do you need Dynamic DNS for a home server?', 0);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('e29c67d9-30e5-459c-8cfa-9dffc75e0486', 'a426d6c3-6688-49fa-ad1a-b484e23ac55c', 'To make your server faster', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('8266e068-da95-49f0-9653-74cb5ed8b952', 'a426d6c3-6688-49fa-ad1a-b484e23ac55c', 'Because most home internet connections have a dynamic IP that changes, and DDNS keeps your hostname pointed at the current IP', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('1be92222-acfd-4f35-8ec0-c80476a8161a', 'a426d6c3-6688-49fa-ad1a-b484e23ac55c', 'To encrypt traffic between your server and the internet', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('5864cd6f-696f-4ac0-8ee7-1e7768614132', 'a426d6c3-6688-49fa-ad1a-b484e23ac55c', 'Because DNS is required for Nginx to work', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('bcaddc60-116c-4a22-b366-41bd7fc31086', '6d688465-40a8-4de1-b60c-7794b07492a5', 'q-ddns-2', 'What does the No-IP DUC (Dynamic Update Client) do?', 1);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('76bbbf60-6dbd-47f1-a2af-5efb22495f0e', 'bcaddc60-116c-4a22-b366-41bd7fc31086', 'It provides a firewall for your server', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('5ddb2425-9c7b-40d7-9f41-9e4cd032e64f', 'bcaddc60-116c-4a22-b366-41bd7fc31086', 'It monitors your public IP and updates the No-IP DNS record when it changes', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('853b343e-86be-4176-8eb4-8867cbb3fe26', 'bcaddc60-116c-4a22-b366-41bd7fc31086', 'It replaces your router''s DNS settings', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('583349b3-7f6e-4b36-8e37-9bde0b3203e1', 'bcaddc60-116c-4a22-b366-41bd7fc31086', 'It assigns a static IP to your server', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('62ceeb54-e800-4210-b86a-b9063107a2d0', '6d688465-40a8-4de1-b60c-7794b07492a5', 'q-ddns-3', 'Why should you create a systemd service for the No-IP client?', 2);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ca6ea02c-ead5-480f-b644-4e70d4e4d101', '62ceeb54-e800-4210-b86a-b9063107a2d0', 'Systemd makes the client run faster', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('f1a14b0e-2f5e-4f61-923d-dcc0574002f9', '62ceeb54-e800-4210-b86a-b9063107a2d0', 'So the client starts automatically on boot and restarts if it crashes', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('d0a9a88e-6fef-4f56-b35d-3e0d994a6be2', '62ceeb54-e800-4210-b86a-b9063107a2d0', 'Systemd is required for all Linux applications', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('4ebf3001-4800-451e-9341-3d4bd1fec636', '62ceeb54-e800-4210-b86a-b9063107a2d0', 'To allow the client to modify firewall rules', FALSE, 3);
