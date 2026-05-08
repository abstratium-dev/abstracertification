-- Continue: Questions and answers for nginx step
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-nginx-1', 'step-nginx', 'q-nginx-1', 'What is the primary role of Nginx on a home server?', 0);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-nginx-1-0', 'q-nginx-1', 'It provides a firewall for your network', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-nginx-1-1', 'q-nginx-1', 'It serves web pages and acts as a reverse proxy', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-nginx-1-2', 'q-nginx-1', 'It manages user accounts on the system', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-nginx-1-3', 'q-nginx-1', 'It provides DNS resolution', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-nginx-2', 'step-nginx', 'q-nginx-2', 'What does ''systemctl enable nginx'' do?', 1);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-nginx-2-0', 'q-nginx-2', 'It starts Nginx immediately', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-nginx-2-1', 'q-nginx-2', 'It installs Nginx from the repository', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-nginx-2-2', 'q-nginx-2', 'It configures Nginx to start automatically when the server boots', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-nginx-2-3', 'q-nginx-2', 'It opens port 80 in the firewall', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-nginx-3', 'step-nginx', 'q-nginx-3', 'Why should you run ''nginx -t'' before reloading the configuration?', 2);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-nginx-3-0', 'q-nginx-3', 'To benchmark the server''s performance', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-nginx-3-1', 'q-nginx-3', 'To test the configuration for syntax errors before applying it', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-nginx-3-2', 'q-nginx-3', 'To display the Nginx version', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-nginx-3-3', 'q-nginx-3', 'To list all active connections', FALSE, 3);

-- Questions and answers for ufw step
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-ufw-1', 'step-ufw', 'q-ufw-1', 'Why must you allow SSH before enabling UFW?', 0);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ufw-1-0', 'q-ufw-1', 'SSH is required for UFW to function', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ufw-1-1', 'q-ufw-1', 'Without allowing SSH, you could lock yourself out of the server remotely', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ufw-1-2', 'q-ufw-1', 'UFW does not start without SSH rules', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ufw-1-3', 'q-ufw-1', 'SSH traffic is always blocked by default on Ubuntu', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-ufw-2', 'step-ufw', 'q-ufw-2', 'What does ''Nginx Full'' include when used with UFW?', 1);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ufw-2-0', 'q-ufw-2', 'Only port 80 (HTTP)', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ufw-2-1', 'q-ufw-2', 'Only port 443 (HTTPS)', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ufw-2-2', 'q-ufw-2', 'Both port 80 (HTTP) and port 443 (HTTPS)', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ufw-2-3', 'q-ufw-2', 'Ports 80, 443, and 8080', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-ufw-3', 'step-ufw', 'q-ufw-3', 'What is the default policy of UFW when enabled?', 2);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ufw-3-0', 'q-ufw-3', 'Allow all incoming and outgoing traffic', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ufw-3-1', 'q-ufw-3', 'Deny all incoming traffic and allow all outgoing traffic', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ufw-3-2', 'q-ufw-3', 'Block all traffic in both directions', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ufw-3-3', 'q-ufw-3', 'Allow all incoming traffic and deny all outgoing traffic', FALSE, 3);

-- Questions and answers for sshd step
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-sshd-1', 'step-sshd', 'q-ssh-1', 'Why should you disable root login via SSH?', 0);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-sshd-1-0', 'q-sshd-1', 'The root account does not exist on Ubuntu', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-sshd-1-1', 'q-sshd-1', 'To prevent direct remote access as root, reducing the risk of compromise', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-sshd-1-2', 'q-sshd-1', 'Because root cannot use SSH by design', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-sshd-1-3', 'q-sshd-1', 'To speed up SSH connections', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-sshd-2', 'step-sshd', 'q-ssh-2', 'What is the advantage of key-based authentication over passwords?', 1);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-sshd-2-0', 'q-sshd-2', 'Keys are shorter and easier to remember', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-sshd-2-1', 'q-sshd-2', 'Keys are immune to brute-force attacks and are significantly more secure', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-sshd-2-2', 'q-sshd-2', 'Keys don''t require any configuration', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-sshd-2-3', 'q-sshd-2', 'Passwords are more secure but less convenient', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-sshd-3', 'step-sshd', 'q-ssh-3', 'What should you do before disabling password authentication?', 2);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-sshd-3-0', 'q-sshd-3', 'Disable the firewall', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-sshd-3-1', 'q-sshd-3', 'Reboot the server', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-sshd-3-2', 'q-sshd-3', 'Confirm that key-based authentication is working', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-sshd-3-3', 'q-sshd-3', 'Uninstall OpenSSH and reinstall it', FALSE, 3);

-- Questions and answers for port-forwarding step
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-port-1', 'step-portfwd', 'q-port-1', 'Why is port forwarding necessary to access your server from the internet?', 0);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-port-1-0', 'q-port-1', 'Linux servers cannot connect to the internet without it', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-port-1-1', 'q-port-1', 'Your router uses NAT, so incoming traffic needs to be explicitly directed to your server''s internal IP', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-port-1-2', 'q-port-1', 'Port forwarding encrypts the traffic for security', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-port-1-3', 'q-port-1', 'It increases your internet speed', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-port-2', 'step-portfwd', 'q-port-2', 'Why should you assign a static IP to your server?', 1);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-port-2-0', 'q-port-2', 'Static IPs are faster than dynamic ones', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-port-2-1', 'q-port-2', 'So the port forwarding rules always point to the correct internal address', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-port-2-2', 'q-port-2', 'DHCP does not work with Linux servers', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-port-2-3', 'q-port-2', 'It is required by Nginx to function', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-port-3', 'step-portfwd', 'q-port-3', 'Should you forward your SSH port to the internet?', 2);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-port-3-0', 'q-port-3', 'Always, it is required for the server to work', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-port-3-1', 'q-port-3', 'Never, SSH should be completely disabled', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-port-3-2', 'q-port-3', 'Only if you need remote access from outside your network, as it increases attack surface', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-port-3-3', 'q-port-3', 'Only on port 22, never on a custom port', FALSE, 3);

-- Questions and answers for dynamic-dns step
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-ddns-1', 'step-ddns', 'q-ddns-1', 'Why do you need Dynamic DNS for a home server?', 0);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ddns-1-0', 'q-ddns-1', 'To make your server faster', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ddns-1-1', 'q-ddns-1', 'Because most home internet connections have a dynamic IP that changes, and DDNS keeps your hostname pointed at the current IP', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ddns-1-2', 'q-ddns-1', 'To encrypt traffic between your server and the internet', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ddns-1-3', 'q-ddns-1', 'Because DNS is required for Nginx to work', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-ddns-2', 'step-ddns', 'q-ddns-2', 'What does the No-IP DUC (Dynamic Update Client) do?', 1);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ddns-2-0', 'q-ddns-2', 'It provides a firewall for your server', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ddns-2-1', 'q-ddns-2', 'It monitors your public IP and updates the No-IP DNS record when it changes', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ddns-2-2', 'q-ddns-2', 'It replaces your router''s DNS settings', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ddns-2-3', 'q-ddns-2', 'It assigns a static IP to your server', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('q-ddns-3', 'step-ddns', 'q-ddns-3', 'Why should you create a systemd service for the No-IP client?', 2);

INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ddns-3-0', 'q-ddns-3', 'Systemd makes the client run faster', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ddns-3-1', 'q-ddns-3', 'So the client starts automatically on boot and restarts if it crashes', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ddns-3-2', 'q-ddns-3', 'Systemd is required for all Linux applications', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('a-ddns-3-3', 'q-ddns-3', 'To allow the client to modify firewall rules', FALSE, 3);
