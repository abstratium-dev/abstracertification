-- Insert "Hardening a Linux Server" as a coming-soon certification
-- This certification has only an introduction page and is not yet fully developed.

-- Certification (coming_soon = TRUE)
INSERT INTO T_certification (id, title, description, coming_soon, created_at, updated_at)
VALUES ('hardening-linux-server', 'Hardening a Linux Server',
'Your server is online — now make it untouchable. Learn battle-tested techniques to lock down a Linux server against real-world attacks: intrusion detection with fail2ban, disk encryption, firewall hardening, SSH certificate authentication, rate limiting, and more. Go from exposed to hardened in one certification.',
TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Single intro step
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c', 'hardening-linux-server', 'intro',
'Welcome to Linux Server Hardening',
'You have built a Linux server and connected it to the internet — congratulations. But every minute it sits online, automated scanners are probing it for weaknesses. Default configurations are designed for convenience, not security. This certification will teach you to systematically eliminate attack surfaces, detect intrusions, encrypt sensitive data, and ensure that even if one layer is breached, the attacker hits another wall. You will learn the same hardening techniques used by professional system administrators to protect production servers.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Info items for the intro step — key concepts
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('d8b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'Attack Surface',
'The attack surface is the total number of entry points an attacker can use to try to gain access to your system. Every open port, running service, and user account is part of the attack surface. Hardening means systematically reducing it — closing ports you do not need, removing software you do not use, and restricting access to the minimum required.',
0);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('e9c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'Defence in Depth',
'Defence in depth is a security strategy that layers multiple independent defences so that if one fails, others still protect the system. For example: a firewall blocks unauthorised ports, fail2ban blocks brute-force attempts on open ports, SSH key authentication prevents password guessing, and disk encryption protects data even if the physical drive is stolen. No single measure is enough — the combination is what makes a server resilient.',
1);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('f0d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'Zero Trust',
'Zero trust is the principle that no user, device, or network should be automatically trusted — even those inside your own network. Every access request must be verified. This means configuring services to authenticate and authorise every connection, using certificates instead of passwords where possible, and assuming that any part of your infrastructure could be compromised at any time.',
2);

-- Instructions for the intro step — the roadmap
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('a1b2c3d4-1111-4e5f-6a7b-8c9d0e1f2a3b', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'This is what a hardened server looks like — multiple layers of defence, each independent, each making an attacker''s job exponentially harder:',
NULL, NULL,
'graph TB
    subgraph Internet ["Internet"]
        attacker([Attacker])
        legitimate([Legitimate User])
    end

    subgraph Server ["Hardened Linux Server"]
        direction TB
        nginx["Nginx<br/>Rate Limiting<br/>Request Filtering"]
        firewall["UFW Firewall<br/>Minimal Open Ports<br/>Outbound Restrictions"]
        fail2ban["Fail2ban<br/>Intrusion Detection<br/>Auto-Ban Repeat Offenders"]
        sshd["SSH Daemon<br/>Certificate Auth Only<br/>No Root Login<br/>Non-Standard Port"]
        encryption["Disk Encryption<br/>AbstraVault<br/>Data at Rest Protection"]
        kernel["Kernel Hardening<br/>Disable Ping<br/>SYN Flood Protection<br/>Restrict Core Dumps"]
        services["Service Isolation<br/>Minimal Running Services<br/>Least Privilege"]
    end

    attacker -->|"Blocked by rate limit"| nginx
    attacker -->|"Blocked by firewall"| firewall
    attacker -->|"Banned after 3 attempts"| fail2ban
    legitimate -->|"Certificate auth"| sshd
    nginx --> firewall
    firewall --> fail2ban
    fail2ban --> sshd
    sshd --> services
    services --> encryption
    kernel -.->|"Protects all layers"| services',
0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('b2c3d4e5-2222-4f6a-7b8c-9d0e1f2a3b4c', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'This certification builds on the Linux Home Server Setup certification. You should complete that first if you have not already. Here is what you will learn to configure:',
NULL, NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('c3d4e5f6-3333-4a7b-8c9d-0e1f2a3b4c5d', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'Fail2ban — Intrusion detection and automatic banning. Fail2ban monitors your server logs in real time. When it detects repeated failed login attempts or suspicious patterns, it automatically creates firewall rules to block the offending IP address. A typical configuration bans an IP after 3 failed SSH login attempts for 24 hours.',
NULL,
'On a public-facing server, you can expect hundreds or thousands of automated SSH brute-force attempts per day. Fail2ban turns this flood into a non-issue — attackers get exactly three guesses before they are locked out.',
NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('d4e5f6a7-4444-4b8c-9d0e-1f2a3b4c5d6e', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'Disk Encryption with AbstraVault — Protect data at rest. Even if someone physically steals your server or hard drive, encrypted data is unreadable without the decryption key. AbstraVault provides a streamlined approach to full-disk and partition-level encryption using LUKS (Linux Unified Key Setup), the standard disk encryption framework for Linux.',
NULL,
'Disk encryption protects against physical theft, improper disposal of drives, and scenarios where an attacker gains physical access to your hardware. It is the last line of defence — if every other security measure fails and someone gets your drive, encryption ensures they get nothing useful.',
NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('e5f6a7b8-5555-4c9d-0e1f-2a3b4c5d6e7f', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'Advanced Firewall Configuration — Go beyond basic UFW. You will learn to create granular firewall rules: restrict outbound connections to only what your server needs, implement port knocking as a stealth layer, set up rate limiting at the firewall level, and create rules that adapt to detected threats.',
NULL,
'A basic firewall blocks incoming traffic on unused ports. An advanced firewall also controls outbound traffic (preventing a compromised service from calling home), limits connection rates (slowing down scanners), and can work with fail2ban to dynamically block attackers.',
NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('f6a7b8c9-6666-4d0e-1f2a-3b4c5d6e7f8a', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'Disable ICMP Ping — Stealth mode. By default, any device on the internet can ping your server to confirm it exists. Disabling ICMP echo responses makes your server invisible to basic network scans. Attackers cannot attack what they cannot find.',
NULL,
'Disabling ping is a simple but effective measure against automated network reconnaissance. Tools like nmap use ping sweeps to discover live hosts before launching targeted attacks. A server that does not respond to pings is often skipped entirely.',
NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('a7b8c9d0-7777-4e1f-2a3b-4c5d6e7f8a9b', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'SSH Hardening with Certificate-Based Authentication — Eliminate passwords entirely. Password authentication is the weakest link in SSH security. Certificate-based authentication uses cryptographic key pairs: a private key on your machine and a public key on the server. Without the private key file, authentication is impossible — no amount of guessing will work.',
NULL,
'With certificate-based authentication, you can completely disable password login over SSH. This means brute-force attacks become mathematically futile: an attacker would need to guess a 4096-bit RSA key, which would take longer than the age of the universe with current computing power.',
NULL, 6);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('b8c9d0e1-8888-4f2a-3b4c-5d6e7f8a9b0c', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'Nginx Rate Limiting — Protect web services from abuse. Rate limiting controls how many requests a client can make in a given time window. This defends against denial-of-service attacks, brute-force login attempts on web applications, and web scrapers that could overload your server.',
NULL,
'A well-configured rate limit lets legitimate users browse normally while automatically throttling or blocking clients that send an abnormal volume of requests. Combined with fail2ban monitoring of Nginx logs, repeat offenders get permanently banned.',
NULL, 7);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('c9d0e1f2-9999-4a3b-4c5d-6e7f8a9b0c1d', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'Kernel Hardening and Sysctl Tuning — Harden the operating system itself. The Linux kernel exposes tuneable parameters via sysctl that control network behaviour, memory management, and process isolation. You will configure protections against SYN flood attacks, IP spoofing, and source routing exploits, and restrict access to kernel logs and core dumps.',
NULL,
'Kernel-level protections are the foundation all other defences sit on. Even if an attacker compromises a service, kernel hardening limits what they can do with that access — restricting core dumps prevents them from extracting secrets from memory, and network stack hardening prevents them from pivoting to other machines.',
NULL, 8);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('d0e1f2a3-aaaa-4b4c-5d6e-7f8a9b0c1d2e', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'Automatic Security Updates — Keep your server patched without manual intervention. Unattended-upgrades automatically installs security patches as soon as they are released, closing vulnerabilities before attackers can exploit them.',
NULL,
'Many real-world breaches happen because known vulnerabilities go unpatched for weeks or months. Automatic security updates eliminate the human delay factor — your server applies critical patches within hours of release.',
NULL, 9);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('e1f2a3b4-bbbb-4c5d-6e7f-8a9b0c1d2e3f', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'Log Monitoring and Auditing — Know what is happening on your server. You will set up centralised logging, configure logwatch for daily security summaries, and learn to read and interpret auth logs, syslog, and Nginx access logs to detect suspicious activity before it becomes a breach.',
NULL,
'Security is not just about prevention — it is about detection. A well-monitored server alerts you to unusual patterns: a spike in failed SSH attempts, an unexpected new user account, or a service accessing files it should not. Early detection is often the difference between a minor incident and a catastrophic breach.',
NULL, 10);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('f2a3b4c5-cccc-4d6e-7f8a-9b0c1d2e3f4a', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'User and Permission Hardening — Principle of least privilege. You will audit user accounts, remove unnecessary ones, configure sudo with fine-grained permissions, set proper file ownership and permissions, and use tools like chroot and AppArmor to restrict what each service can access.',
NULL,
'If a web server is compromised, it should not be able to read SSH keys or database files. Proper user isolation and permission hardening ensures that each service runs with the minimum access it needs — and nothing more.',
NULL, 11);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('a3b4c5d6-dddd-4e7f-8a9b-0c1d2e3f4a5b', 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c',
'This certification is coming soon. Check back later to begin your hardening journey!',
NULL, NULL, NULL, 12);

-- Page entry: single DIRECT page pointing to the intro step
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('a1b2c3d4-eeee-4f5a-6b7c-8d9e0f1a2b3c', 'hardening-linux-server', 'DIRECT', 0, 'c7a1b2c3-d4e5-4f6a-7b8c-9d0e1f2a3b4c', NULL, NULL, NULL, NULL);
