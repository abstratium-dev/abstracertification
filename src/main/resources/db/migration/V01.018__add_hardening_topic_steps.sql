-- Remove the topic-specific instructions from the intro step (keep only the mermaid diagram and the preamble)
DELETE FROM T_instruction WHERE id IN (
  'b2c3d4e5-2222-4f6a-7b8c-9d0e1f2a3b4c',
  'c3d4e5f6-3333-4a7b-8c9d-0e1f2a3b4c5d',
  'd4e5f6a7-4444-4b8c-9d0e-1f2a3b4c5d6e',
  'e5f6a7b8-5555-4c9d-0e1f-2a3b4c5d6e7f',
  'f6a7b8c9-6666-4d0e-1f2a-3b4c5d6e7f8a',
  'a7b8c9d0-7777-4e1f-2a3b-4c5d6e7f8a9b',
  'b8c9d0e1-8888-4f2a-3b4c-5d6e7f8a9b0c',
  'c9d0e1f2-9999-4a3b-4c5d-6e7f8a9b0c1d',
  'd0e1f2a3-aaaa-4b4c-5d6e-7f8a9b0c1d2e',
  'e1f2a3b4-bbbb-4c5d-6e7f-8a9b0c1d2e3f',
  'f2a3b4c5-cccc-4d6e-7f8a-9b0c1d2e3f4a',
  'a3b4c5d6-dddd-4e7f-8a9b-0c1d2e3f4a5b'
);

-- Add a short overview instruction to the intro step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('b2c3d4e5-2222-4f6a-7b8c-9d0e1f2a3b4c', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'This certification builds on the Linux Home Server Setup certification. You should complete that first if you have not already. Each page ahead covers one hardening technique — work through them in order to build a fully hardened server.',
NULL, NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('c3d4e5f6-3333-4a7b-8c9d-0e1f2a3b4c5d', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'This certification is coming soon. The pages ahead show what you will learn — check back later for the full content!',
NULL, NULL, NULL, 2);

-- ============================================================
-- STEP 2: Fail2ban
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-fail2ban', 'hardening-linux-server', 'fail2ban',
'Fail2ban — Intrusion Detection and Auto-Banning',
'A public-facing server receives hundreds or thousands of automated brute-force login attempts per day. Without intrusion detection, attackers can try passwords endlessly until they find one that works. Fail2ban monitors your logs in real time and automatically bans IP addresses that show malicious behaviour — turning a flood of attacks into a non-issue.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-f2b-1', 'hs-step-fail2ban', 'Jail',
'A fail2ban jail is a configuration block that defines what log file to monitor, what patterns constitute a failed attempt, how many failures trigger a ban, and how long the ban lasts. Each service (SSH, Nginx, Postfix) typically gets its own jail with tailored settings.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-f2b-2', 'hs-step-fail2ban', 'Filter',
'A filter is a set of regular expressions that fail2ban uses to identify failed authentication attempts in log files. For example, the sshd filter matches lines like "Failed password for invalid user" in /var/log/auth.log.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-f2b-3', 'hs-step-fail2ban', 'Ban Action',
'When the failure threshold is reached, fail2ban executes a ban action — typically inserting an iptables or nftables rule that drops all traffic from the offending IP. The ban can be temporary (e.g. 24 hours) or permanent for repeat offenders using the recidive jail.',
2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-f2b-1', 'hs-step-fail2ban',
'Install fail2ban and enable it to start on boot. The default installation includes sensible defaults for SSH protection.',
'sudo apt install fail2ban && sudo systemctl enable fail2ban',
'Fail2ban works out of the box for SSH, but you should always create a local configuration file to customise it.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-f2b-2', 'hs-step-fail2ban',
'Create a local jail configuration. Never edit jail.conf directly — it gets overwritten on updates. Instead, create jail.local which overrides the defaults.',
'sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local',
'In jail.local you will set bantime, findtime, maxretry, and enable jails for each service you want to protect.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-f2b-3', 'hs-step-fail2ban',
'Configure the SSH jail with aggressive settings: ban after 3 failed attempts, ban duration of 24 hours, and enable the recidive jail to permanently ban IPs that get banned repeatedly.',
NULL,
'The recidive jail watches fail2ban''s own log. If an IP gets banned three times in a week, the recidive jail bans it for a full year.',
NULL, 2);

-- ============================================================
-- STEP 3: Disk Encryption with AbstraVault
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-encryption', 'hardening-linux-server', 'disk-encryption',
'Disk Encryption with AbstraVault',
'Even if every network defence is perfect, physical access to your server or its drives bypasses all of them. Disk encryption ensures that data at rest is unreadable without the correct key — protecting against theft, improper disposal, and physical compromise. AbstraVault streamlines LUKS-based encryption for Linux servers.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-enc-1', 'hs-step-encryption', 'LUKS',
'Linux Unified Key Setup is the standard disk encryption specification for Linux. It stores encryption metadata in a header on the partition, supports multiple key slots (so you can have backup passphrases), and integrates with the kernel''s dm-crypt subsystem for transparent encryption and decryption.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-enc-2', 'hs-step-encryption', 'Data at Rest',
'Data at rest refers to data stored on disk as opposed to data in transit (moving over a network) or data in use (loaded in memory). Encryption at rest means files on the disk are encrypted — even if the physical drive is removed and connected to another machine, the contents are gibberish without the decryption key.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-enc-3', 'hs-step-encryption', 'AbstraVault',
'AbstraVault is a tool that simplifies setting up and managing LUKS-encrypted volumes on Linux servers. It handles key management, automatic unlocking at boot using TPM or key files, and provides a consistent interface for creating, mounting, and rotating encrypted partitions.',
2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-enc-1', 'hs-step-encryption',
'You will learn to identify which partitions contain sensitive data and should be encrypted — typically /home, /var, and any database storage directories.',
NULL,
'Encrypting the root partition requires special boot configuration. For most servers, encrypting data partitions while leaving root unencrypted is a practical balance between security and operational simplicity.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-enc-2', 'hs-step-encryption',
'Set up LUKS encryption on a data partition using AbstraVault, configure automatic unlocking at boot, and verify that the encrypted volume is mounted correctly after a reboot.',
NULL,
'Always keep a backup of your LUKS header and a recovery passphrase stored securely offline. If the header is corrupted and you have no backup, the data is permanently lost.',
NULL, 1);

-- ============================================================
-- STEP 4: Advanced Firewall Configuration
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-firewall', 'hardening-linux-server', 'firewall',
'Advanced Firewall Configuration',
'A basic firewall that blocks unused incoming ports is a good start, but a hardened server needs much more. You need to control outbound traffic (preventing compromised services from calling home), rate-limit connections to slow down scanners, and create rules that work together with fail2ban to dynamically block attackers. This page takes your UFW configuration from basic to battle-ready.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-fw-1', 'hs-step-firewall', 'Egress Filtering',
'Egress filtering restricts outbound traffic from your server. Most basic firewall setups only filter inbound traffic, but a compromised service could use unrestricted outbound access to exfiltrate data or download malware. By allowing outbound connections only to specific ports and destinations, you limit what an attacker can do even after gaining access.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-fw-2', 'hs-step-firewall', 'Connection Rate Limiting',
'Connection rate limiting restricts how many new connections a single IP can establish within a time window. This slows down port scanners, brute-force tools, and denial-of-service attempts at the network layer — before traffic even reaches your application.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-fw-3', 'hs-step-firewall', 'Port Knocking',
'Port knocking is a stealth technique where the server keeps all ports closed until a client sends a specific sequence of connection attempts to predetermined ports. Only after the correct "knock" sequence does the server open the requested port for that IP. This makes services invisible to port scanners.',
2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-fw-1', 'hs-step-firewall',
'Review your current UFW rules and identify gaps: are outbound connections unrestricted? Are there rate limits on SSH or HTTP? Are any ports open that should not be?',
'sudo ufw status verbose',
'If the output shows "Default: allow (outgoing)", your server has no egress filtering — any compromised process can freely communicate with the internet.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-fw-2', 'hs-step-firewall',
'Configure default-deny outbound policy, then explicitly allow only the traffic your server needs: DNS (port 53), HTTP/HTTPS (ports 80/443 for package updates), NTP (port 123), and SMTP (port 587 if your server sends email).',
NULL,
'Start with a logging-only outbound policy to discover what your server actually needs before blocking everything. Check logs for a week, then switch to deny.',
NULL, 1);

-- ============================================================
-- STEP 5: Disable ICMP Ping
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-disable-ping', 'hardening-linux-server', 'disable-ping',
'Disable ICMP Ping — Stealth Mode',
'By default, any device on the internet can ping your server to confirm it exists. Automated scanners use ping sweeps to discover live hosts before launching targeted attacks. Disabling ICMP echo responses makes your server invisible to these scans — attackers cannot attack what they cannot find.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ping-1', 'hs-step-disable-ping', 'ICMP',
'Internet Control Message Protocol is used for network diagnostics. Ping uses ICMP echo request and echo reply messages. While useful for troubleshooting, ICMP can also be abused for reconnaissance (discovering live hosts), amplification attacks (smurf attacks), and covert data channels.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ping-2', 'hs-step-disable-ping', 'Network Reconnaissance',
'Reconnaissance is the first phase of most attacks. Scanners like nmap send ICMP echo requests across entire IP ranges to build a list of live hosts. Hosts that respond to ping are added to the target list. Hosts that do not respond are often skipped, dramatically reducing your exposure.',
1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ping-1', 'hs-step-disable-ping',
'Disable ICMP echo responses at the kernel level using sysctl. This takes effect immediately and persists across reboots when added to sysctl.conf.',
'echo "net.ipv4.icmp_echo_ignore_all = 1" | sudo tee -a /etc/sysctl.conf && sudo sysctl -p',
'If you need to debug network issues, you can temporarily re-enable ping with: sudo sysctl -w net.ipv4.icmp_echo_ignore_all=0',
NULL, 0);

-- ============================================================
-- STEP 6: SSH Hardening
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-ssh', 'hardening-linux-server', 'ssh-hardening',
'SSH Hardening with Certificate-Based Authentication',
'SSH is the primary way you manage your server remotely — and the primary target for attackers. Password authentication is the weakest link: passwords can be guessed, leaked, or brute-forced. Certificate-based authentication uses cryptographic key pairs that make brute-force mathematically futile. Combined with hardened SSH daemon settings, you can make SSH virtually impenetrable.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ssh-1', 'hs-step-ssh', 'Public Key Cryptography',
'Public key cryptography uses a mathematically linked pair of keys: a private key (kept secret) and a public key (shared with the server). Data encrypted with the public key can only be decrypted with the private key. For SSH authentication, the server challenges the client to prove it holds the private key — without the key ever being transmitted.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ssh-2', 'hs-step-ssh', 'SSH Certificates vs Keys',
'SSH certificates are signed by a Certificate Authority (CA) and include metadata like validity period and allowed principals. Unlike plain SSH keys which must be individually distributed to every server, a certificate signed by a trusted CA is automatically accepted by all servers that trust that CA — simplifying management at scale.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ssh-3', 'hs-step-ssh', 'SSH Daemon Hardening',
'Beyond authentication, the SSH daemon (sshd) has many tuneable security settings: disabling root login, changing the default port, limiting which users can connect, setting idle timeouts, restricting allowed authentication methods, and enabling strict mode to reject connections with improper file permissions.',
2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-1', 'hs-step-ssh',
'Generate a strong SSH key pair on your local machine. Use Ed25519 for the best security-to-performance ratio, or RSA 4096 for maximum compatibility.',
'ssh-keygen -t ed25519 -C "your-server-key"',
'An attacker would need to guess a 256-bit Ed25519 key, which has more possible combinations than atoms in the observable universe.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-2', 'hs-step-ssh',
'Harden the SSH daemon configuration: disable password authentication, disable root login, change the default port, set connection timeouts, and restrict allowed users.',
NULL,
'After disabling password authentication, ensure your key-based login works before disconnecting. Locking yourself out of SSH on a remote server is very difficult to recover from.',
NULL, 1);

-- ============================================================
-- STEP 7: Nginx Rate Limiting
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-nginx', 'hardening-linux-server', 'nginx-rate-limiting',
'Nginx Rate Limiting',
'Rate limiting controls how many requests a client can make in a given time window. Without it, your web server is vulnerable to denial-of-service attacks, brute-force login attempts, and aggressive web scrapers. A well-configured rate limit lets legitimate users browse normally while automatically throttling or blocking abusive clients.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-nginx-1', 'hs-step-nginx', 'Leaky Bucket Algorithm',
'Nginx rate limiting uses the leaky bucket algorithm: requests fill a bucket at a variable rate, and the bucket drains at a fixed rate. If the bucket overflows (too many requests too fast), excess requests are either delayed or rejected. This smooths out bursts while enforcing a sustained request rate.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-nginx-2', 'hs-step-nginx', 'Rate Limit Zones',
'A rate limit zone defines a shared memory region that tracks request counts per key (typically client IP). You define the zone size, the key, and the allowed rate. Multiple zones can be applied to different locations — for example, a strict limit on login pages and a relaxed limit on static assets.',
1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-nginx-1', 'hs-step-nginx',
'Configure rate limiting zones in your Nginx http block: one general zone for all requests and a strict zone for sensitive endpoints like login pages and API routes.',
NULL,
'A common starting point: 10 requests per second per IP for general traffic, 3 requests per second for login endpoints. Adjust based on your application''s actual usage patterns.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-nginx-2', 'hs-step-nginx',
'Integrate Nginx rate limiting with fail2ban: configure fail2ban to monitor Nginx error logs for rate-limited requests (HTTP 429/503) and ban IPs that trigger rate limits repeatedly.',
NULL,
'Combined with fail2ban, this creates a powerful two-tier defence: Nginx slows down abusive clients, and fail2ban permanently blocks those that persist.',
NULL, 1);

-- ============================================================
-- STEP 8: Kernel Hardening and Sysctl Tuning
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-kernel', 'hardening-linux-server', 'kernel-hardening',
'Kernel Hardening and Sysctl Tuning',
'The Linux kernel is the foundation all other software runs on. Its default settings prioritise compatibility and performance over security. By tuning kernel parameters via sysctl, you can protect against SYN flood attacks, IP spoofing, source routing exploits, and restrict access to sensitive kernel information. These are the defences that limit damage even when a service running on top of the kernel is compromised.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-kern-1', 'hs-step-kernel', 'Sysctl',
'Sysctl is the interface for reading and writing kernel parameters at runtime. Parameters in /proc/sys/ control network stack behaviour, memory management, filesystem settings, and security policies. Changes can be made live with the sysctl command or persisted in /etc/sysctl.conf.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-kern-2', 'hs-step-kernel', 'SYN Flood Protection',
'A SYN flood attack sends massive numbers of TCP SYN packets without completing the handshake, exhausting the server''s connection table. SYN cookies (net.ipv4.tcp_syncookies) allow the server to handle SYN floods without allocating resources until the handshake completes.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-kern-3', 'hs-step-kernel', 'Core Dump Restriction',
'Core dumps are memory snapshots written to disk when a process crashes. They can contain sensitive data like passwords, encryption keys, and session tokens. Restricting core dumps (fs.suid_dumpable=0) prevents attackers from crashing a process to extract secrets from its memory.',
2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-kern-1', 'hs-step-kernel',
'Apply a comprehensive set of security-focused sysctl settings: enable SYN cookies, disable IP source routing, enable reverse path filtering, restrict kernel pointer and log exposure, and disable core dumps for setuid programs.',
NULL,
'Test each setting individually on a non-production system first. Some settings can break specific applications — for example, disabling ICMP redirects may affect complex routing setups.',
NULL, 0);

-- ============================================================
-- STEP 9: Automatic Security Updates
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-updates', 'hardening-linux-server', 'auto-updates',
'Automatic Security Updates',
'Many real-world breaches exploit known vulnerabilities that have patches available — but the patches were never applied. The gap between a vulnerability being disclosed and a patch being installed is when your server is most at risk. Automatic security updates eliminate the human delay factor, ensuring critical patches are applied within hours of release.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-upd-1', 'hs-step-updates', 'Unattended Upgrades',
'The unattended-upgrades package on Debian/Ubuntu automatically downloads and installs security updates. It can be configured to handle only security patches (safest), all updates, or specific package origins. It also supports automatic reboots when kernel updates require them.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-upd-2', 'hs-step-updates', 'CVE',
'A Common Vulnerabilities and Exposures identifier is a unique reference for a publicly known security flaw. When a CVE is published, automated scanners immediately start probing for vulnerable systems. The time between CVE publication and patch application is your window of exposure.',
1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-upd-1', 'hs-step-updates',
'Install and configure unattended-upgrades to automatically apply security patches. Enable email notifications so you know when updates are applied.',
'sudo apt install unattended-upgrades && sudo dpkg-reconfigure -plow unattended-upgrades',
'Configure /etc/apt/apt.conf.d/50unattended-upgrades to enable automatic reboots at a safe time (e.g. 4:00 AM) when kernel updates require it.',
NULL, 0);

-- ============================================================
-- STEP 10: Log Monitoring and Auditing
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-logging', 'hardening-linux-server', 'log-monitoring',
'Log Monitoring and Auditing',
'Security is not just about prevention — it is about detection. A well-monitored server alerts you to unusual patterns before a minor incident becomes a catastrophic breach. You will learn to set up centralised logging, configure daily security summaries, and interpret auth logs and access logs to detect suspicious activity.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-log-1', 'hs-step-logging', 'Auth Log',
'/var/log/auth.log records every authentication event on your system: successful and failed SSH logins, sudo usage, user switches, and PAM module activity. Monitoring this file is essential for detecting brute-force attempts, unauthorised access, and privilege escalation.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-log-2', 'hs-step-logging', 'Logwatch',
'Logwatch is a log analysis tool that generates daily summary reports from your system logs. It parses auth logs, syslog, Nginx access logs, and more, presenting key events in a concise email report: failed login attempts, new users, service restarts, and disk usage warnings.',
1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-log-1', 'hs-step-logging',
'Install logwatch and configure it to email daily security summaries. Set the detail level to High to catch subtle anomalies.',
'sudo apt install logwatch',
'Review logwatch reports daily for the first week to establish a baseline of what "normal" looks like on your server. After that, focus on deviations from the baseline.',
NULL, 0);

-- ============================================================
-- STEP 11: User and Permission Hardening
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-users', 'hardening-linux-server', 'user-permissions',
'User and Permission Hardening',
'If a web server process is compromised, it should not be able to read your SSH keys or database files. The principle of least privilege means every user and service runs with the minimum access it needs — and nothing more. Proper isolation ensures that a breach in one service cannot spread to the entire system.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-usr-1', 'hs-step-users', 'Principle of Least Privilege',
'Every process, user, and service should have only the permissions it absolutely needs to function. A web server needs to read web files and write logs — nothing else. A database needs to read/write its data directory — nothing else. This limits the blast radius of any single compromise.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-usr-2', 'hs-step-users', 'AppArmor',
'AppArmor is a Linux kernel security module that restricts what files and capabilities a program can access, based on per-program profiles. Even if an attacker compromises a process, AppArmor prevents it from accessing anything outside its defined profile — like a sandbox for individual services.',
1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-usr-1', 'hs-step-users',
'Audit all user accounts on the system: identify unused accounts, remove unnecessary ones, ensure each service runs under its own dedicated user, and configure sudo with fine-grained permissions instead of blanket root access.',
'cat /etc/passwd | grep -v nologin | grep -v false',
'Any account with a real shell that you do not recognise is a potential security risk. Disable it immediately with: sudo usermod -s /usr/sbin/nologin <username>',
NULL, 0);

-- ============================================================
-- Page entries: one per step, ordered sequentially after the intro
-- ============================================================
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required) VALUES
('hs-pe-fail2ban',     'hardening-linux-server', 'DIRECT', 1, 'hs-step-fail2ban',     NULL, NULL, NULL, NULL),
('hs-pe-encryption',   'hardening-linux-server', 'DIRECT', 2, 'hs-step-encryption',   NULL, NULL, NULL, NULL),
('hs-pe-firewall',     'hardening-linux-server', 'DIRECT', 3, 'hs-step-firewall',     NULL, NULL, NULL, NULL),
('hs-pe-disable-ping', 'hardening-linux-server', 'DIRECT', 4, 'hs-step-disable-ping', NULL, NULL, NULL, NULL),
('hs-pe-ssh',          'hardening-linux-server', 'DIRECT', 5, 'hs-step-ssh',          NULL, NULL, NULL, NULL),
('hs-pe-nginx',        'hardening-linux-server', 'DIRECT', 6, 'hs-step-nginx',        NULL, NULL, NULL, NULL),
('hs-pe-kernel',       'hardening-linux-server', 'DIRECT', 7, 'hs-step-kernel',       NULL, NULL, NULL, NULL),
('hs-pe-updates',      'hardening-linux-server', 'DIRECT', 8, 'hs-step-updates',      NULL, NULL, NULL, NULL),
('hs-pe-logging',      'hardening-linux-server', 'DIRECT', 9, 'hs-step-logging',      NULL, NULL, NULL, NULL),
('hs-pe-users',        'hardening-linux-server', 'DIRECT', 10, 'hs-step-users',       NULL, NULL, NULL, NULL);
