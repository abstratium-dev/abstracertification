-- Rewrite "Hardening a Linux Server" certification — Part 1 of 2.
-- Deleting the certification cascades to ALL child entities:
--   T_certification → T_certification_step → T_info_item, T_instruction, T_question → T_answer_option
--   T_certification → T_page_entry → T_choice_variant
-- One DELETE statement is sufficient.
DELETE FROM T_certification WHERE id = 'hardening-linux-server';

-- ============================================================
-- CERTIFICATION
-- ============================================================
INSERT INTO T_certification (id, title, description, coming_soon, sequence_order, created_at, updated_at)
VALUES ('hardening-linux-server', 'Hardening a Linux Server',
'Your server is online — now make it untouchable. Learn battle-tested techniques to lock down a Linux server against real-world attacks: intrusion detection with fail2ban, firewall hardening, SSH certificate authentication, rate limiting, kernel hardening, automatic updates, and more. Go from exposed to hardened in one certification.',
FALSE, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ============================================================
-- STEP 1: Introduction
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-intro', 'hardening-linux-server', 'intro',
'Welcome to Linux Server Hardening',
'You have built a Linux server and connected it to the internet — congratulations. But every minute it sits online, automated scanners are probing it for weaknesses. Default configurations are designed for convenience, not security. This certification will teach you to systematically eliminate attack surfaces, detect intrusions, and ensure that even if one layer is breached, the attacker hits another wall.',
TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-intro-1', 'hs-step-intro', 'Attack Surface',
'The attack surface is the total number of entry points an attacker can use to gain access to your system. Every open port, running service, and user account is part of the attack surface. Hardening means systematically reducing it — closing ports you do not need, removing software you do not use, and restricting access to the minimum required.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-intro-2', 'hs-step-intro', 'Defence in Depth',
'Defence in depth layers multiple independent defences so that if one fails, others still protect the system. For example: a firewall blocks unauthorised ports, fail2ban blocks brute-force attempts, SSH key authentication prevents password guessing. No single measure is enough — the combination is what makes a server resilient.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-intro-3', 'hs-step-intro', 'Zero Trust',
'Zero trust is the principle that no user, device, or network should be automatically trusted — even those inside your own network. Every access request must be verified. This means configuring services to authenticate and authorise every connection, using certificates instead of passwords where possible.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-intro-4', 'hs-step-intro', 'Principle of Least Privilege',
'Every process, user, and service should have only the permissions it absolutely needs to function. A web server needs to read web files and write logs — nothing else. A database needs to read/write its data directory — nothing else. This limits the blast radius of any single compromise.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-intro-1', 'hs-step-intro',
'This certification builds on the Linux Home Server Setup certification. You should complete that first if you have not already. Each page ahead covers one hardening technique — work through them in order to build a fully hardened server.',
NULL, NULL, NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-intro-2', 'hs-step-intro',
'Here is what a hardened server looks like. Each layer in the diagram below is described briefly:

**UFW Firewall** — controls which inbound ports are open and restricts outbound connections so that a compromised service cannot call home or exfiltrate data.

**Fail2ban** — monitors logs in real time and automatically bans IP addresses after repeated failures, turning a flood of brute-force attempts into a non-issue.

**Nginx Rate Limiting** — limits how many requests per second a single client can make, absorbing denial-of-service attempts and brute-force attacks on web endpoints.

**SSH Daemon** — hardened to use certificate-based authentication only (no passwords), disallow root login, and enforce connection timeouts.

**Kernel Hardening (sysctl)** — protects the network stack against SYN floods, IP spoofing, and source routing exploits, and restricts access to sensitive kernel information.

**Unattended Upgrades** — automatically installs security patches within hours of release, closing the window between a vulnerability being published and being fixed on your server.

**Log Monitoring** — daily security summaries and disk space alerts ensure you are notified of unusual activity and disk pressure before they become critical problems.

**User and Permission Hardening** — every service runs under its own limited account; sudo is configured with fine-grained permissions; AppArmor profiles sandbox individual services.',
NULL, NULL,
'graph TD
    subgraph internet ["Internet"]
        direction LR
        attacker([Attacker])
        legitimate([Legitimate User])
    end
    subgraph server ["Hardened Linux Server"]
        direction TB
        firewall["UFW Firewall\nMinimal Open Ports\nEgress Filtering"]
        fail2ban["Fail2ban\nIntrusion Detection\nAuto-Ban Repeat Offenders"]
        nginx["Nginx\nRate Limiting\nRequest Filtering"]
        sshd["SSH Daemon\nCertificate Auth Only\nNo Root Login"]
        users["User Hardening\nLeast Privilege\nAppArmor Profiles"]
        subgraph cross ["Cross-Cutting Protections"]
            direction LR
            kernel["Kernel Hardening\nSYN Flood Protection\nICMP Disabled"]
            updates["Unattended Upgrades\nAuto Security Patches"]
            logging["Log Monitoring\nDaily Reports + Disk Alerts"]
        end
    end
    internet --> server
    attacker -->|"Blocked by firewall"| firewall
    attacker -->|"Banned after failures"| fail2ban
    attacker -->|"Throttled"| nginx
    legitimate -->|"Certificate auth"| sshd
    firewall --> fail2ban
    fail2ban --> nginx
    nginx --> sshd
    sshd --> users
    users --> cross',
1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-intro-3', 'hs-step-intro',
'Before you begin, take a snapshot or backup of your server. Some changes in this certification — particularly SSH hardening and firewall configuration — can lock you out if misconfigured. A backup makes any mistake recoverable.',
NULL,
'If you are on a VPS, use your provider''s snapshot feature. If on physical hardware, ensure you have console access (keyboard and monitor connected directly) as a fallback before changing SSH settings.',
NULL, 2);

-- ============================================================
-- STEP 2: Fail2ban
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-fail2ban', 'hardening-linux-server', 'fail2ban',
'Fail2ban — Intrusion Detection and Auto-Banning',
'A public-facing server receives hundreds or thousands of automated brute-force login attempts per day. Without intrusion detection, attackers can try passwords endlessly. Fail2ban monitors your logs in real time and automatically bans IP addresses that show malicious behaviour — turning a flood of attacks into a non-issue.',
TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-f2b-1', 'hs-step-fail2ban', 'Jail',
'A fail2ban jail is a configuration block that defines: which log file to monitor, which patterns constitute a failed attempt (via a filter), how many failures within a time window trigger a ban (maxretry), and how long the ban lasts (bantime). Each service — SSH, Nginx, Postfix — typically gets its own jail.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-f2b-2', 'hs-step-fail2ban', 'Filter',
'A filter is a set of regular expressions that fail2ban uses to identify failed authentication attempts in log files. The built-in sshd filter matches lines like "Failed password for invalid user" in /var/log/auth.log. You can write custom filters for any application that writes logs.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-f2b-3', 'hs-step-fail2ban', 'Ban Action',
'When the failure threshold is reached, fail2ban executes a ban action — typically inserting an iptables or UFW rule that drops all traffic from the offending IP. The ban can be temporary (e.g. 24 hours) or near-permanent for repeat offenders via the recidive jail.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-f2b-4', 'hs-step-fail2ban', 'UFW REJECT vs DENY (DROP)',
'REJECT sends an ICMP "port unreachable" response back to the attacker, informing them the connection was refused. DENY (DROP) silently discards the packet with no response. DENY is preferable for security: it gives the attacker no information about whether the host exists, wastes their time waiting for timeouts, and reduces ICMP traffic. Use DENY for all ban actions on public-facing servers.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-f2b-5', 'hs-step-fail2ban', 'Recidive Jail',
'The recidive jail watches fail2ban''s own log file. If an IP address gets banned multiple times within a set period (e.g. three bans in one week), the recidive jail imposes a much longer ban — typically one year. This automatically escalates persistent attackers to near-permanent bans without manual intervention.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-f2b-1', 'hs-step-fail2ban',
'Install fail2ban and enable it to start on boot.',
'sudo apt install fail2ban
sudo systemctl enable --now fail2ban',
'Fail2ban works out of the box for SSH, but always create a local configuration file to customise settings rather than relying on defaults.',
NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-f2b-2', 'hs-step-fail2ban',
'Create a local jail configuration. Never edit jail.conf directly — it is overwritten on upgrades. jail.local overrides the defaults and is preserved across updates.',
'sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local',
'Open jail.local with your editor. Find the [DEFAULT] section — this is where you set global settings that apply to all jails unless overridden.',
NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-f2b-3', 'hs-step-fail2ban',
'In the [DEFAULT] section of jail.local, configure aggressive global defaults.',
NULL,
'Key settings:

```
bantime  = 86400
findtime = 600
maxretry = 3
banaction = ufw
```

This bans an IP for 24 hours after 3 failures within 10 minutes, using UFW DROP rules.',
NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-f2b-4', 'hs-step-fail2ban',
'Enable the SSH jail explicitly in jail.local.',
NULL,
'```
[sshd]
enabled = true
port = ssh
logpath = %(sshd_log)s
backend = %(sshd_backend)s
maxretry = 3
bantime = 86400
```',
NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-f2b-5', 'hs-step-fail2ban',
'Enable the recidive jail to permanently ban repeat offenders.',
NULL,
'```
[recidive]
enabled = true
logpath = /var/log/fail2ban.log
banaction = ufw
bantime = 31536000
findtime = 604800
maxretry = 3
```

This bans any IP for 365 days if it triggers 3 separate bans within 7 days.',
NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-f2b-6', 'hs-step-fail2ban',
'Restart fail2ban to apply your configuration and verify the jails are active.',
'sudo systemctl restart fail2ban
sudo fail2ban-client status',
'Both sshd and recidive should appear as active jails. To check banned IPs in a specific jail: sudo fail2ban-client status sshd',
NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-f2b-7', 'hs-step-fail2ban',
'To manually unban an IP (for example if you accidentally lock out a trusted machine):',
'sudo fail2ban-client set sshd unbanip <IP_ADDRESS>',
'If you lock yourself out of SSH entirely, you will need console access to unban yourself. This is why having console access available before hardening SSH is critical.',
NULL, 6);

-- ============================================================
-- STEP 3: Advanced Firewall Configuration
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-firewall', 'hardening-linux-server', 'firewall',
'Advanced Firewall Configuration',
'A basic firewall that blocks unused incoming ports is a good start, but a hardened server needs much more. You need to control outbound traffic, rate-limit connections, and create rules that work with fail2ban to dynamically block attackers.',
TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-fw-1', 'hs-step-firewall', 'Egress Filtering',
'Egress filtering restricts outbound traffic from your server. Most basic setups only filter inbound traffic, but a compromised service could use unrestricted outbound access to exfiltrate data or download malware. By allowing outbound connections only to specific ports, you limit what an attacker can do even after gaining access.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-fw-2', 'hs-step-firewall', 'Connection Rate Limiting',
'Connection rate limiting restricts how many new connections a single IP can establish within a time window. This slows down port scanners, brute-force tools, and denial-of-service attempts at the network layer — before traffic reaches your application.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-fw-3', 'hs-step-firewall', 'Port Knocking',
'Port knocking keeps all ports closed until a client sends a specific sequence of connection attempts to predetermined ports. Only after the correct "knock" sequence does the server open the requested port for that IP, making services invisible to port scanners.',
2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-fw-1', 'hs-step-firewall',
'Check your current UFW status to understand what rules are already in place.',
'sudo ufw status verbose',
'If the output shows "Default: allow (outgoing)", your server has no egress filtering — any compromised process can communicate freely with the internet. Note every open port and ask: does this server actually need this?',
NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-fw-2', 'hs-step-firewall',
'Set default policies: deny all incoming and deny all outgoing. Then add explicit allow rules before enabling.',
'sudo ufw default deny incoming
sudo ufw default deny outgoing
sudo ufw default deny routed',
'Setting outbound to deny will break your server until you add the outbound allow rules below. Run all the allow commands in the same session before disconnecting.',
NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-fw-3', 'hs-step-firewall',
'Allow the outbound traffic your server legitimately needs: DNS, package updates, NTP time sync.',
'sudo ufw allow out 53
sudo ufw allow out 80/tcp
sudo ufw allow out 443/tcp
sudo ufw allow out 123/udp',
'If your server sends email, also allow: sudo ufw allow out 587/tcp
Check /etc/apt/sources.list — if package repos use HTTP, port 80 outbound is needed.',
NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-fw-4', 'hs-step-firewall',
'Allow inbound traffic for the services you are running.',
'sudo ufw allow in ssh
sudo ufw allow in 80/tcp
sudo ufw allow in 443/tcp',
'If you changed your SSH port from the default 22: sudo ufw allow in 2222/tcp',
NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-fw-5', 'hs-step-firewall',
'Enable UFW rate limiting on SSH to slow brute-force at the firewall level, complementing fail2ban.',
'sudo ufw limit ssh',
'UFW''s limit rule allows a maximum of 6 connections per 30 seconds from a single IP. This is coarser than fail2ban but operates at a lower level.',
NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-fw-6', 'hs-step-firewall',
'Enable UFW and verify the final ruleset.',
'sudo ufw enable
sudo ufw status numbered',
'Confirm SSH is in the allow list before enabling. If you are connected via SSH, verify the allow rule is present before pressing Enter.',
NULL, 5);

-- ============================================================
-- STEP 4: Disable ICMP Ping
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-disable-ping', 'hardening-linux-server', 'disable-ping',
'Disable ICMP Ping — Stealth Mode',
'By default, any device on the internet can ping your server to confirm it exists. Automated scanners use ping sweeps to discover live hosts before launching targeted attacks. Disabling ICMP echo responses makes your server invisible to these scans.',
TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ping-1', 'hs-step-disable-ping', 'ICMP',
'Internet Control Message Protocol is used for network diagnostics. Ping uses ICMP echo request and reply messages. While useful for troubleshooting, ICMP can be abused for reconnaissance (discovering live hosts), amplification attacks, and covert data channels.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ping-2', 'hs-step-disable-ping', 'Network Reconnaissance',
'Reconnaissance is the first phase of most attacks. Automated scanners send ICMP echo requests across entire IP ranges. Hosts that respond are added to the target list. Hosts that do not respond are often skipped, dramatically reducing your exposure to opportunistic attacks.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ping-3', 'hs-step-disable-ping', 'Sysctl',
'Sysctl is the Linux interface for reading and writing kernel parameters at runtime. Changes can be made immediately with "sysctl -w". To persist changes across reboots, add them to /etc/sysctl.conf or a file in /etc/sysctl.d/ and apply with "sysctl -p".',
2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ping-1', 'hs-step-disable-ping',
'Disable ICMP echo responses by adding the setting to /etc/sysctl.conf and applying it immediately.',
'echo "net.ipv4.icmp_echo_ignore_all = 1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p',
'The -p flag reloads all settings from /etc/sysctl.conf immediately without a reboot.',
NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ping-2', 'hs-step-disable-ping',
'Verify the change is active.',
'sudo sysctl net.ipv4.icmp_echo_ignore_all',
'The output should read: net.ipv4.icmp_echo_ignore_all = 1
Try pinging your server from another machine — you should receive no replies.',
NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ping-3', 'hs-step-disable-ping',
'To temporarily re-enable ping for debugging without editing the config file:',
'sudo sysctl -w net.ipv4.icmp_echo_ignore_all=0',
'This change is not persistent — it reverts to disabled on the next reboot since /etc/sysctl.conf still has it set to 1.',
NULL, 2);

-- ============================================================
-- STEP 5a: SSH Hardening — Linux client
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-ssh-linux', 'hardening-linux-server', 'ssh-hardening-linux',
'SSH Hardening with Certificate-Based Authentication — Linux Client',
'SSH is the primary way you manage your server remotely — and the primary target for attackers. Password authentication can be guessed, leaked, or brute-forced. Certificate-based authentication uses cryptographic key pairs that make brute-force mathematically futile. This page covers the Linux client workflow using the standard OpenSSH toolchain and ssh-agent for key management.',
TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ssh-l-1', 'hs-step-ssh-linux', 'Public Key Cryptography',
'Public key cryptography uses a mathematically linked pair of keys: a private key (kept secret on your machine) and a public key (placed on the server). During SSH authentication, the server sends a challenge that only someone holding the private key can answer — the key is never transmitted over the network.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ssh-l-2', 'hs-step-ssh-linux', 'ssh-agent',
'ssh-agent is a background process that holds decrypted private keys in memory. Once you add your key with ssh-add, you only need to enter your passphrase once per session. Subsequent SSH connections use the agent automatically — the private key file is never sent to the server.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ssh-l-3', 'hs-step-ssh-linux', 'Ed25519 vs RSA',
'Ed25519 is a modern elliptic-curve algorithm offering excellent security with short keys and fast performance. RSA with 4096 bits offers broad compatibility with older systems. For new setups on modern servers, Ed25519 is preferred.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ssh-l-4', 'hs-step-ssh-linux', 'authorized_keys',
'The ~/.ssh/authorized_keys file on the server lists every public key permitted to log in to that account. When you connect, the server checks whether your private key corresponds to any entry. If it matches, you are authenticated — no password required.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ssh-l-5', 'hs-step-ssh-linux', 'SSH Daemon Hardening',
'Beyond authentication, the SSH daemon (sshd) has many security settings: disabling root login, changing the default port, limiting which users can connect, setting idle timeouts, restricting allowed authentication methods, and enforcing strict mode to reject connections when key files have incorrect permissions.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-l-1', 'hs-step-ssh-linux',
'On your local Linux machine, generate a strong SSH key pair.',
'ssh-keygen -t ed25519 -C "your-server-name"',
'When prompted for a passphrase, enter a strong one. The passphrase encrypts the private key file — even if someone steals the file, they cannot use it without the passphrase.',
NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-l-2', 'hs-step-ssh-linux',
'Copy your public key to the server. You will be prompted for your password this one time.',
'ssh-copy-id -i ~/.ssh/id_ed25519.pub user@your-server-ip',
'ssh-copy-id handles creating the .ssh directory and authorized_keys file with correct permissions automatically.',
NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-l-3', 'hs-step-ssh-linux',
'Test key-based authentication before making any changes to sshd configuration.',
'ssh -i ~/.ssh/id_ed25519 user@your-server-ip',
'If this connects without prompting for a password (only the key passphrase if you set one), key auth is working. Do not disable password auth until this succeeds.',
NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-l-4', 'hs-step-ssh-linux',
'Start ssh-agent and add your key so you only need to enter the passphrase once per session.',
'eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519',
'To have ssh-agent start automatically on login, add the eval line to your ~/.bashrc or ~/.profile.',
NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-l-5', 'hs-step-ssh-linux',
'On the server, harden /etc/ssh/sshd_config.',
'sudo nano /etc/ssh/sshd_config',
'Key settings to apply:

```
PasswordAuthentication no
PermitRootLogin no
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
MaxAuthTries 3
LoginGraceTime 30
ClientAliveInterval 300
ClientAliveCountMax 2
X11Forwarding no
AllowAgentForwarding no
PermitEmptyPasswords no
```

Optionally change the default port: `Port 2222` — update your UFW rules to allow the new port before restarting sshd.',
NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-l-6', 'hs-step-ssh-linux',
'Test the sshd configuration for syntax errors, then restart. Keep your existing session open while testing from a second terminal.',
'sudo sshd -t
sudo systemctl restart sshd',
'sshd -t validates config without restarting. If no errors are reported, restart is safe. Always verify from a second terminal before closing the existing session.',
NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-l-7', 'hs-step-ssh-linux',
'Create a ~/.ssh/config file on your local machine to simplify future connections.',
NULL,
'Example:

Host myserver
    HostName your-server-ip
    User youruser
    IdentityFile ~/.ssh/id_ed25519
    Port 22

With this in place you can connect with simply: ssh myserver',
NULL, 6);

-- ============================================================
-- STEP 5b: SSH Hardening — Windows client
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-ssh-windows', 'hardening-linux-server', 'ssh-hardening-windows',
'SSH Hardening with Certificate-Based Authentication — Windows Client',
'SSH is the primary way you manage your server remotely — and the primary target for attackers. Password authentication can be guessed, leaked, or brute-forced. Certificate-based authentication uses cryptographic key pairs that make brute-force mathematically futile. This page covers the Windows client workflow using PuTTY, WinSCP, and Pageant for key management.',
TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ssh-w-1', 'hs-step-ssh-windows', 'PuTTY',
'PuTTY is the most widely used SSH client on Windows. It provides a graphical interface for SSH connections and supports key-based authentication using PPK (PuTTY Private Key) format files. The PuTTY suite also includes PuTTYgen for generating key pairs and Pageant for managing keys in memory.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ssh-w-2', 'hs-step-ssh-windows', 'WinSCP',
'WinSCP is a graphical SFTP and SCP client for Windows that integrates with PuTTY. It allows you to transfer files to and from your server using a drag-and-drop interface, using the same SSH key authentication as PuTTY. WinSCP can import sessions directly from PuTTY.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ssh-w-3', 'hs-step-ssh-windows', 'PuTTYgen',
'PuTTYgen (PuTTY Key Generator) generates SSH key pairs in PPK format and converts between OpenSSH and PPK formats. After generating a key pair, PuTTYgen shows the public key in OpenSSH format — the text you need to copy to the server''s authorized_keys file.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ssh-w-4', 'hs-step-ssh-windows', 'Pageant',
'Pageant is PuTTY''s authentication agent — the Windows equivalent of ssh-agent on Linux. You load your private key into Pageant once per session, entering the passphrase once. From that point, any PuTTY or WinSCP connection automatically uses Pageant — you never need to re-enter the passphrase until you restart Pageant or your computer.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-ssh-w-5', 'hs-step-ssh-windows', 'PPK Format',
'PPK (PuTTY Private Key) is the private key format used by PuTTY tools. It differs from the OpenSSH private key format used on Linux. PuTTYgen converts between formats. The public key you copy to the server must be in OpenSSH format — the long line beginning with "ssh-ed25519" or "ssh-rsa".',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-w-1', 'hs-step-ssh-windows',
'Download and install the PuTTY suite from the official website. The suite includes PuTTY, PuTTYgen, WinSCP, and Pageant.',
NULL,
'Download the 64-bit MSI installer from: https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html
Download WinSCP from: https://winscp.net/',
NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-w-2', 'hs-step-ssh-windows',
'Open PuTTYgen. Select Ed25519 as the key type. Click Generate and move your mouse randomly over the blank area to generate entropy. Enter a strong passphrase in the Key passphrase fields.',
NULL,
'After generating, PuTTYgen shows your public key in a text box at the top. Leave PuTTYgen open — you need this public key text to copy to the server.',
NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-w-3', 'hs-step-ssh-windows',
'Save your private key as a PPK file: File → Save private key. Store it securely — for example C:\Users\YourName\.ssh\myserver.ppk.',
NULL,
'Never store the private key in a cloud-synced folder or anywhere accessible to others. If the PPK file is stolen and your passphrase is weak, your server is compromised.',
NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-w-4', 'hs-step-ssh-windows',
'Copy the public key to your server. Use PuTTY with password auth (still enabled) to connect, then paste the public key into authorized_keys.',
'mkdir -p ~/.ssh && chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys',
'Paste the public key as a single line. Save and exit. Then:
chmod 600 ~/.ssh/authorized_keys
Permissions must be exact — SSH refuses authorized_keys if it is world-readable.',
NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-w-5', 'hs-step-ssh-windows',
'Test key-based auth before disabling passwords. In PuTTY: Connection → SSH → Auth → Credentials → set "Private key file for authentication" to your PPK. Connect — you should be prompted for your key passphrase, not your account password.',
NULL,
'If the connection fails check: (1) public key is on one line in authorized_keys, (2) permissions are 700 on ~/.ssh and 600 on authorized_keys, (3) the username matches, (4) you selected the correct PPK file.',
NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-w-6', 'hs-step-ssh-windows',
'Set up Pageant so you only enter your passphrase once per Windows session. Start Pageant (it appears in the system tray). Right-click the Pageant icon → Add Key → select your PPK file. Enter your passphrase once.',
NULL,
'To auto-start Pageant and load your key at Windows startup, create a shortcut to Pageant.exe with the PPK path as an argument:
"C:\Program Files\PuTTY\pageant.exe" "C:\Users\YourName\.ssh\myserver.ppk"
Place this shortcut in your Startup folder (Win+R → shell:startup).',
NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-w-7', 'hs-step-ssh-windows',
'Save your PuTTY session (Session → Saved Sessions) with hostname and username. In WinSCP, create a new SFTP site and import your PuTTY session — it will use Pageant automatically.',
NULL,
'With Pageant running, PuTTY and WinSCP connections require no passphrase — Pageant answers the challenge from memory.',
NULL, 6);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-ssh-w-8', 'hs-step-ssh-windows',
'Once key auth is confirmed working, harden sshd_config on the server to disable password authentication.',
'sudo nano /etc/ssh/sshd_config',
'Set the following in `/etc/ssh/sshd_config`:

```
PasswordAuthentication no
PermitRootLogin no
MaxAuthTries 3
LoginGraceTime 30
ClientAliveInterval 300
ClientAliveCountMax 2
```

Then run `sudo sshd -t && sudo systemctl restart sshd` to validate and apply. Verify from your **existing** PuTTY session before closing it.',
NULL, 7);
