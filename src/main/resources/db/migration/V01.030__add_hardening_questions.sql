-- Questions for "Hardening a Linux Server" certification.
-- 3 questions per page × 13 pages = 39 questions, each with 3 answer options.
-- Correct answer length is deliberately varied: the correct answer is the
-- longest option in fewer than 1 in 4 questions to prevent length-guessing.
-- Correct answer position (sequence_order) is also spread across 0, 1, 2.

-- ============================================================
-- STEP 1: Introduction
-- ============================================================

-- Q1: correct=0 (short), wrong options are longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-intro-1', 'hs-step-intro', 'hs-q-intro-1', 'What does "defence in depth" mean in the context of server security?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-intro-1a', 'hs-q-intro-1', 'Layering multiple independent defences so that if one fails, others still protect the system.', TRUE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-intro-1b', 'hs-q-intro-1', 'Using a single, very strong firewall to block all attacks at the network boundary before they reach the server.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-intro-1c', 'hs-q-intro-1', 'Encrypting all data at rest and in transit.', FALSE, 2);

-- Q2: correct=1 (medium), wrong options are shorter and longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-intro-2', 'hs-step-intro', 'hs-q-intro-2', 'What is the "attack surface" of a server?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-intro-2a', 'hs-q-intro-2', 'The physical size of the server hardware.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-intro-2b', 'hs-q-intro-2', 'The total number of entry points an attacker can use, including open ports, running services, and user accounts.', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-intro-2c', 'hs-q-intro-2', 'The number of CPU cores available to handle incoming connections, which determines how many simultaneous attacks can be processed.', FALSE, 2);

-- Q3: correct=0 (short), wrong options longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-intro-3', 'hs-step-intro', 'hs-q-intro-3', 'According to the principle of least privilege, what access should a web server process have?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-intro-3a', 'hs-q-intro-3', 'Only what it needs: read web files and write logs — nothing more.', TRUE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-intro-3b', 'hs-q-intro-3', 'Root access, so it can write to any directory and restart itself if it crashes without requiring administrator intervention.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-intro-3c', 'hs-q-intro-3', 'Read access to the entire filesystem so it can serve any file a user requests, including configuration files and logs from other services.', FALSE, 2);

-- ============================================================
-- STEP 2: Fail2ban
-- ============================================================

-- Q4: correct=2 (long), wrong options shorter — one of our ≤25% long-correct cases
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-f2b-1', 'hs-step-fail2ban', 'hs-q-f2b-1', 'Why should you edit jail.local instead of jail.conf to customise fail2ban settings?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-f2b-1a', 'hs-q-f2b-1', 'jail.conf is write-protected by the operating system and cannot be edited without first changing its ownership.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-f2b-1b', 'hs-q-f2b-1', 'jail.local is processed first, so settings there take priority over anything defined later in jail.conf.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-f2b-1c', 'hs-q-f2b-1', 'jail.conf is overwritten when fail2ban is upgraded, so jail.local is the correct place to put customisations that survive updates.', TRUE, 2);

-- Q5: correct=0 (medium), wrong longer and shorter
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-f2b-2', 'hs-step-fail2ban', 'hs-q-f2b-2', 'What is the difference between DENY (DROP) and REJECT in fail2ban ban actions?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-f2b-2a', 'hs-q-f2b-2', 'DENY silently drops the packet with no reply; REJECT sends back an ICMP message telling the attacker the connection was refused.', TRUE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-f2b-2b', 'hs-q-f2b-2', 'DENY blocks TCP traffic while REJECT blocks UDP, making both necessary for full protection against mixed-protocol attacks.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-f2b-2c', 'hs-q-f2b-2', 'They are identical in effect.', FALSE, 2);

-- Q6: correct=1 (short), wrong options longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-f2b-3', 'hs-step-fail2ban', 'hs-q-f2b-3', 'What does the recidive jail do?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-f2b-3a', 'hs-q-f2b-3', 'It monitors outbound traffic for signs that your server has been compromised and is being used to attack others, then alerts you.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-f2b-3b', 'hs-q-f2b-3', 'It imposes a much longer ban on IPs that are banned multiple times, escalating repeat offenders automatically.', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-f2b-3c', 'hs-q-f2b-3', 'It watches the recycle bin directory for deleted fail2ban configuration files and restores them automatically to prevent accidental misconfiguration.', FALSE, 2);

-- ============================================================
-- STEP 3: Advanced Firewall Configuration
-- ============================================================

-- Q7: correct=1 (medium), wrong shorter and longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-fw-1', 'hs-step-firewall', 'hs-q-fw-1', 'What is egress filtering and why does it matter?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-fw-1a', 'hs-q-fw-1', 'Filtering incoming traffic at the edge of the network.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-fw-1b', 'hs-q-fw-1', 'Restricting outbound traffic so a compromised service cannot exfiltrate data or download malware from the internet.', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-fw-1c', 'hs-q-fw-1', 'Scanning all outbound email messages for malware attachments before they are delivered to recipients outside the organisation.', FALSE, 2);

-- Q8: correct=2 (short), wrong longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-fw-2', 'hs-step-firewall', 'hs-q-fw-2', 'What does the command "sudo ufw limit ssh" do?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-fw-2a', 'hs-q-fw-2', 'It completely blocks all SSH connections to the server, preventing anyone from connecting remotely until the rule is removed.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-fw-2b', 'hs-q-fw-2', 'It allows only a pre-approved list of IP addresses to connect via SSH, blocking all other source addresses at the firewall level.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-fw-2c', 'hs-q-fw-2', 'It rate-limits SSH connections: a maximum of 6 per 30 seconds from a single IP.', TRUE, 2);

-- Q9: correct=0 (long) — one of our ≤25% long-correct cases
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-fw-3', 'hs-step-firewall', 'hs-q-fw-3', 'Why must you add outbound allow rules before enabling UFW when you have set the default outbound policy to deny?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-fw-3a', 'hs-q-fw-3', 'Because enabling UFW applies all rules immediately, and without outbound allows for DNS and apt, your server loses internet access and cannot receive updates or resolve hostnames.', TRUE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-fw-3b', 'hs-q-fw-3', 'UFW ignores deny rules until the firewall is enabled.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-fw-3c', 'hs-q-fw-3', 'Outbound rules must always come before inbound rules in the UFW rule table.', FALSE, 2);

-- ============================================================
-- STEP 4: Disable ICMP Ping
-- ============================================================

-- Q10: correct=1 (short), wrong longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-ping-1', 'hs-step-disable-ping', 'hs-q-ping-1', 'What is the purpose of disabling ICMP echo responses on a public server?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-ping-1a', 'hs-q-ping-1', 'It prevents the server from communicating with other servers on the same network, isolating it completely from internal traffic.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-ping-1b', 'hs-q-ping-1', 'It makes the server invisible to automated ping sweeps used in the reconnaissance phase of attacks.', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-ping-1c', 'hs-q-ping-1', 'It saves bandwidth by stopping the server from responding to ICMP packets, which accumulate in very large numbers on busy internet-facing servers.', FALSE, 2);

-- Q11: correct=2 (medium), wrong shorter and longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-ping-2', 'hs-step-disable-ping', 'hs-q-ping-2', 'How do you make a sysctl setting like disabling ICMP ping persist across reboots?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-ping-2a', 'hs-q-ping-2', 'Run sudo sysctl -w each time the server boots using a cron job.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-ping-2b', 'hs-q-ping-2', 'Reboot the server twice.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-ping-2c', 'hs-q-ping-2', 'Add the setting to /etc/sysctl.conf or a file in /etc/sysctl.d/ and apply it with sudo sysctl -p.', TRUE, 2);

-- Q12: correct=0 (short), wrong longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-ping-3', 'hs-step-disable-ping', 'hs-q-ping-3', 'What does "sudo sysctl -w net.ipv4.icmp_echo_ignore_all=0" do?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-ping-3a', 'hs-q-ping-3', 'It temporarily re-enables ping responses without changing the persistent configuration file.', TRUE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-ping-3b', 'hs-q-ping-3', 'It permanently disables ping responses and writes the setting to /etc/sysctl.conf so it survives future reboots of the server.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-ping-3c', 'hs-q-ping-3', 'It removes the ICMP kernel module entirely, which means ping cannot be re-enabled without reinstalling it from the package manager.', FALSE, 2);

-- ============================================================
-- STEP 5a: SSH Hardening — Linux Client
-- ============================================================

-- Q13: correct=1 (short), wrong longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-sshl-1', 'hs-step-ssh-linux', 'hs-q-sshl-1', 'What is the role of the authorized_keys file on the server?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshl-1a', 'hs-q-sshl-1', 'It stores encrypted copies of all passwords that have been used to authenticate to the server, for auditing purposes.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshl-1b', 'hs-q-sshl-1', 'It lists every public key permitted to log in to that account.', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshl-1c', 'hs-q-sshl-1', 'It contains the private key of the server, which is sent to clients during the SSH handshake so they can verify the server''s identity before connecting.', FALSE, 2);

-- Q14: correct=0 (medium), wrong shorter and longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-sshl-2', 'hs-step-ssh-linux', 'hs-q-sshl-2', 'What is the purpose of ssh-agent?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshl-2a', 'hs-q-sshl-2', 'It holds decrypted private keys in memory so you only enter your passphrase once per session, not on every connection.', TRUE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshl-2b', 'hs-q-sshl-2', 'It manages the SSH daemon on the server.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshl-2c', 'hs-q-sshl-2', 'It generates new SSH key pairs automatically every 90 days and distributes the updated public key to all servers in your authorized_keys list.', FALSE, 2);

-- Q15: correct=2 (long) — one of our ≤25% long-correct cases
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-sshl-3', 'hs-step-ssh-linux', 'hs-q-sshl-3', 'Why should you test key-based authentication before setting PasswordAuthentication to no in sshd_config?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshl-3a', 'hs-q-sshl-3', 'To avoid exceeding the MaxAuthTries limit.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshl-3b', 'hs-q-sshl-3', 'So that sshd can cache your key before passwords are disabled.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshl-3c', 'hs-q-sshl-3', 'If key auth is not working and you disable passwords, you will be locked out of the server with no way to reconnect remotely.', TRUE, 2);

-- ============================================================
-- STEP 5b: SSH Hardening — Windows Client
-- ============================================================

-- Q16: correct=0 (medium), wrong shorter and longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-sshw-1', 'hs-step-ssh-windows', 'hs-q-sshw-1', 'What is Pageant and what problem does it solve?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshw-1a', 'hs-q-sshw-1', 'Pageant is PuTTY''s authentication agent; it holds your decrypted private key in memory so you enter the passphrase only once per Windows session.', TRUE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshw-1b', 'hs-q-sshw-1', 'A tool for generating PPK files.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshw-1c', 'hs-q-sshw-1', 'A Windows service that monitors SSH connections for brute-force attempts and blocks attacking IP addresses by modifying the Windows Firewall rules automatically.', FALSE, 2);

-- Q17: correct=2 (short), wrong longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-sshw-2', 'hs-step-ssh-windows', 'hs-q-sshw-2', 'What format must the public key be in when you paste it into authorized_keys on the server?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshw-2a', 'hs-q-sshw-2', 'PPK format, because that is what PuTTYgen produces and what the Linux SSH daemon expects to read from the authorized_keys file.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshw-2b', 'hs-q-sshw-2', 'Base64-encoded DER format, which must be converted using the openssl command-line tool before the server will accept it.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshw-2c', 'hs-q-sshw-2', 'OpenSSH format: a single line beginning with ssh-ed25519 or ssh-rsa.', TRUE, 2);

-- Q18: correct=1 (medium), wrong shorter and longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-sshw-3', 'hs-step-ssh-windows', 'hs-q-sshw-3', 'What permissions must the ~/.ssh directory and authorized_keys file have for SSH to accept them?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshw-3a', 'hs-q-sshw-3', 'Any permissions work; SSH only cares about the file contents.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshw-3b', 'hs-q-sshw-3', 'The .ssh directory must be 700 (owner only) and authorized_keys must be 600, otherwise SSH will refuse to use them.', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-sshw-3c', 'hs-q-sshw-3', 'Both must be set to 777 so that the SSH daemon, which runs as a different system user, can read the file and compare the stored keys against the connecting client''s credentials.', FALSE, 2);

-- ============================================================
-- STEP 6: Nginx Rate Limiting
-- ============================================================

-- Q19: correct=0 (medium), wrong shorter and longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-nginx-1', 'hs-step-nginx', 'hs-q-nginx-1', 'What does the "burst" parameter do in an Nginx rate limit configuration?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-nginx-1a', 'hs-q-nginx-1', 'It allows a client to briefly exceed the defined rate by queueing excess requests rather than immediately rejecting them.', TRUE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-nginx-1b', 'hs-q-nginx-1', 'It sets the maximum rate.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-nginx-1c', 'hs-q-nginx-1', 'It defines a burst mode that doubles the allowed rate for VIP clients whose IP addresses have been pre-approved in a whitelist configuration file.', FALSE, 2);

-- Q20: correct=1 (short), wrong longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-nginx-2', 'hs-step-nginx', 'hs-q-nginx-2', 'Which HTTP status code does Nginx return when a client exceeds the rate limit and the burst queue is full?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-nginx-2a', 'hs-q-nginx-2', '503 Service Unavailable, which Nginx uses by default to indicate that the upstream server is temporarily unable to handle the request.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-nginx-2b', 'hs-q-nginx-2', '429 Too Many Requests.', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-nginx-2c', 'hs-q-nginx-2', '403 Forbidden, because the client has been identified as a threat and is now denied access to all resources on the server permanently.', FALSE, 2);

-- Q21: correct=2 (medium), wrong shorter and longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-nginx-3', 'hs-step-nginx', 'hs-q-nginx-3', 'What does "nodelay" do when combined with the burst parameter?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-nginx-3a', 'hs-q-nginx-3', 'It disables rate limiting entirely for the location.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-nginx-3b', 'hs-q-nginx-3', 'It adds a random delay to each request to confuse automated scanners attempting to profile the server''s response patterns.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-nginx-3c', 'hs-q-nginx-3', 'It processes queued burst requests immediately rather than spacing them out, preventing noticeable delays for legitimate users making a few quick requests.', TRUE, 2);

-- ============================================================
-- STEP 7: Kernel Hardening
-- ============================================================

-- Q22: correct=0 (short), wrong longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-kern-1', 'hs-step-kernel', 'hs-q-kern-1', 'What does enabling SYN cookies (net.ipv4.tcp_syncookies = 1) protect against?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-kern-1a', 'hs-q-kern-1', 'SYN flood attacks that exhaust the server''s connection table.', TRUE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-kern-1b', 'hs-q-kern-1', 'Cross-site scripting attacks targeting web applications running on the server, by inspecting TCP payloads for malicious JavaScript.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-kern-1c', 'hs-q-kern-1', 'Brute-force SSH login attempts by tracking the source IP addresses of all incomplete TCP handshakes and adding them to a blocklist.', FALSE, 2);

-- Q23: correct=1 (medium), wrong shorter and longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-kern-2', 'hs-step-kernel', 'hs-q-kern-2', 'What does reverse path filtering (rp_filter = 1) prevent?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-kern-2a', 'hs-q-kern-2', 'Outbound traffic on non-standard ports.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-kern-2b', 'hs-q-kern-2', 'IP spoofing, by rejecting incoming packets that do not arrive on the interface they would logically come from.', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-kern-2c', 'hs-q-kern-2', 'All forms of denial-of-service attacks by filtering out packets that exceed a configurable rate threshold defined in the kernel''s network scheduler settings.', FALSE, 2);

-- Q24: correct=2 (short), wrong longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-kern-3', 'hs-step-kernel', 'hs-q-kern-3', 'Why add sysctl hardening settings to /etc/sysctl.d/99-hardening.conf instead of /etc/sysctl.conf?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-kern-3a', 'hs-q-kern-3', 'Because /etc/sysctl.conf is only read by the kernel at compile time and changes to it require a full kernel recompilation to take effect.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-kern-3b', 'hs-q-kern-3', 'Files in /etc/sysctl.d/ are processed in alphabetical order, so placing settings there with a 99- prefix ensures they load before the main config.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-kern-3c', 'hs-q-kern-3', 'A dedicated file in /etc/sysctl.d/ survives package updates and keeps hardening settings separate from the base config.', TRUE, 2);

-- ============================================================
-- STEP 8: Automatic Security Updates
-- ============================================================

-- Q25: correct=1 (long) — one of our ≤25% long-correct cases
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-upd-1', 'hs-step-updates', 'hs-q-upd-1', 'Why is msmtp used instead of installing a full mail server to send notification emails?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-upd-1a', 'hs-q-upd-1', 'msmtp is the only mail tool supported by unattended-upgrades.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-upd-1b', 'hs-q-upd-1', 'msmtp is a lightweight relay agent that forwards mail through an existing provider like Gmail, requiring no mail server configuration, no inbound port 25, and no DNS records.', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-upd-1c', 'hs-q-upd-1', 'Full mail servers are blocked by most VPS providers.', FALSE, 2);

-- Q26: correct=0 (short), wrong longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-upd-2', 'hs-step-updates', 'hs-q-upd-2', 'What does the Automatic-Reboot-Time setting in unattended-upgrades do?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-upd-2a', 'hs-q-upd-2', 'It schedules automatic reboots (when required by updates) to happen at a specified time, such as 4 AM.', TRUE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-upd-2b', 'hs-q-upd-2', 'It sets a hard timeout after which the server forcibly terminates all running processes and reboots, regardless of whether any updates have actually been applied or are pending.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-upd-2c', 'hs-q-upd-2', 'It specifies the maximum amount of time unattended-upgrades is allowed to run before aborting, to prevent the update process from blocking the server during peak hours.', FALSE, 2);

-- Q27: correct=2 (medium), wrong shorter and longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-upd-3', 'hs-step-updates', 'hs-q-upd-3', 'How do you check whether the server requires a reboot after installing updates?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-upd-3a', 'hs-q-upd-3', 'Run sudo apt status and look for packages marked as requiring a restart in the output.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-upd-3b', 'hs-q-upd-3', 'Check whether the apt lock file at /var/lib/dpkg/lock exists and is held by an active process — if so, another update is still running and you should wait before rebooting.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-upd-3c', 'hs-q-upd-3', 'Check whether /var/run/reboot-required exists; if it does, a reboot is needed and the triggering packages are listed in /var/run/reboot-required.pkgs.', TRUE, 2);

-- ============================================================
-- STEP 9: Log Monitoring
-- ============================================================

-- Q28: correct=0 (medium), wrong shorter and longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-log-1', 'hs-step-logging', 'hs-q-log-1', 'What kind of information is recorded in /var/log/auth.log?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-log-1a', 'hs-q-log-1', 'Every authentication event: successful and failed SSH logins, sudo usage, user switches, and PAM module activity.', TRUE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-log-1b', 'hs-q-log-1', 'Nginx access logs only.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-log-1c', 'hs-q-log-1', 'A complete record of every file opened, modified, or deleted on the server by any user or process, including system daemons and background services.', FALSE, 2);

-- Q29: correct=2 (short), wrong longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-log-2', 'hs-step-logging', 'hs-q-log-2', 'What does logwatch produce?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-log-2a', 'hs-q-log-2', 'A real-time dashboard showing CPU usage, memory, active connections, and disk I/O that refreshes every second in the terminal.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-log-2b', 'hs-q-log-2', 'A compressed archive of all log files rotated during the previous 24 hours, stored in /var/cache/logwatch for later analysis.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-log-2c', 'hs-q-log-2', 'A daily email summary of log activity covering failed logins, service restarts, and more.', TRUE, 2);

-- Q30: correct=1 (medium), wrong shorter and longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-log-3', 'hs-step-logging', 'hs-q-log-3', 'Why is a full disk a security concern, not just an availability concern?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-log-3a', 'hs-q-log-3', 'It causes SSH to disconnect.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-log-3b', 'hs-q-log-3', 'A full disk prevents logs from being written, which hides attack activity, and can also indicate a log-flooding attack designed to conceal intrusion.', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-log-3c', 'hs-q-log-3', 'When the disk is full, the kernel swaps all process memory to disk, dramatically slowing the server and making it easier for attackers to exploit timing vulnerabilities in authentication code.', FALSE, 2);

-- ============================================================
-- STEP 10: User and Permission Hardening
-- ============================================================

-- Q31: correct=2 (short), wrong longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-usr-1', 'hs-step-users', 'hs-q-usr-1', 'In the output of "ls -la", what does the first character of the permissions string indicate?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-usr-1a', 'hs-q-usr-1', 'The number of hard links the file has, which determines how many directory entries point to the same inode on the underlying filesystem.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-usr-1b', 'hs-q-usr-1', 'The owner''s read/write/execute permissions, shown as the first of the three permission groups after the file type character.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-usr-1c', 'hs-q-usr-1', 'The file type: "-" for a regular file, "d" for a directory, "l" for a symbolic link.', TRUE, 2);

-- Q32: correct=0 (medium), wrong shorter and longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-usr-2', 'hs-step-users', 'hs-q-usr-2', 'What does "chmod 640 file.txt" set?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-usr-2a', 'hs-q-usr-2', 'Owner can read and write, group can read only, and others have no access at all.', TRUE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-usr-2b', 'hs-q-usr-2', 'Full access for all.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-usr-2c', 'hs-q-usr-2', 'Owner can read, write, and execute; group can read and write; others can only read — this is a common setting for shared scripts that must be run by members of a group.', FALSE, 2);

-- Q33: correct=1 (short), wrong longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-usr-3', 'hs-step-users', 'hs-q-usr-3', 'What is the setgid bit (g+s) on a directory and why is it useful for web deployments?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-usr-3a', 'hs-q-usr-3', 'It makes the directory executable by all users, allowing any process to enter and list its contents without needing explicit read permissions on the directory itself.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-usr-3b', 'hs-q-usr-3', 'New files created inside inherit the directory''s group, so files copied in by a deploy user are automatically readable by www-data.', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-usr-3c', 'hs-q-usr-3', 'It grants the group the same elevated privileges as root for that directory only, meaning group members can install packages and modify system files within the scope of the web root.', FALSE, 2);

-- ============================================================
-- STEP 11: Server Performance Monitoring
-- ============================================================

-- Q34: correct=0 (short), wrong longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-mon-1', 'hs-step-monitoring', 'hs-q-mon-1', 'What does a sustained load average significantly higher than the number of CPU cores indicate?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-mon-1a', 'hs-q-mon-1', 'More processes are waiting for CPU time than the server can handle — it is overloaded.', TRUE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-mon-1b', 'hs-q-mon-1', 'The server''s CPU cores are underutilised and the load balancer should distribute fewer requests to this instance until the average drops back to a normal baseline level.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-mon-1c', 'hs-q-mon-1', 'The kernel is spending too much time on I/O wait due to a slow disk, which causes the load average metric to inflate even when no CPU-intensive processes are running.', FALSE, 2);

-- Q35: correct=2 (medium), wrong shorter and longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-mon-2', 'hs-step-monitoring', 'hs-q-mon-2', 'What does the "nethogs" tool show that "htop" does not?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-mon-2a', 'hs-q-mon-2', 'Disk I/O per process.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-mon-2b', 'hs-q-mon-2', 'Memory usage over time.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-mon-2c', 'hs-q-mon-2', 'Network bandwidth consumed per process, making it easy to spot unexpected outbound data transfers that could indicate a compromise.', TRUE, 2);

-- Q36: correct=1 (short), wrong longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-mon-3', 'hs-step-monitoring', 'hs-q-mon-3', 'Why is it recommended to access the Netdata dashboard via an SSH tunnel rather than opening port 19999 in the firewall?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-mon-3a', 'hs-q-mon-3', 'Because Netdata requires an SSH connection to collect performance metrics from the kernel and cannot function without an active tunnel to relay the data.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-mon-3b', 'hs-q-mon-3', 'To avoid exposing a monitoring dashboard — which reveals system details — to the public internet.', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-mon-3c', 'hs-q-mon-3', 'Port 19999 is reserved by IANA for a different protocol, so exposing it publicly would cause conflicts with legitimate traffic from other services that also use that port number.', FALSE, 2);

-- ============================================================
-- STEP 12: AppArmor
-- ============================================================

-- Q37: correct=0 (medium), wrong shorter and longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-aa-1', 'hs-step-apparmor', 'hs-q-aa-1', 'What is the difference between AppArmor enforce mode and complain mode?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-aa-1a', 'hs-q-aa-1', 'Enforce mode blocks and logs violations; complain mode only logs them without blocking, which is useful when building a new profile.', TRUE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-aa-1b', 'hs-q-aa-1', 'Enforce mode is stricter.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-aa-1c', 'hs-q-aa-1', 'Complain mode disables the AppArmor profile entirely and reverts the process to running with full root permissions, which is useful for temporarily granting a service unrestricted access.', FALSE, 2);

-- Q38: correct=2 (short), wrong longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-aa-2', 'hs-step-apparmor', 'hs-q-aa-2', 'What does an AppArmor profile define?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-aa-2a', 'hs-q-aa-2', 'The network ports a service is allowed to listen on, which are enforced by the kernel independently of UFW firewall rules already configured on the system.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-aa-2b', 'hs-q-aa-2', 'The maximum CPU and memory resources a process can consume, acting as a resource quota to prevent any single service from starving others under heavy load.', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-aa-2c', 'hs-q-aa-2', 'Exactly which files, capabilities, and network operations a specific program is allowed — a whitelist enforced by the kernel.', TRUE, 2);

-- Q39: correct=1 (medium), wrong shorter and longer
INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('hs-q-aa-3', 'hs-step-apparmor', 'hs-q-aa-3', 'If a service breaks after switching its AppArmor profile to enforce mode, where should you look to understand why?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-aa-3a', 'hs-q-aa-3', 'The service''s source code.', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-aa-3b', 'hs-q-aa-3', 'The system log (/var/log/syslog or /var/log/kern.log) for AppArmor DENIED messages, which show exactly what access was blocked.', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('hs-ao-aa-3c', 'hs-q-aa-3', 'The /etc/apparmor.d/ directory for syntax errors in all installed profile files, then reload each one individually using the aa-enforce command to isolate which specific profile is causing the service failure.', FALSE, 2);
