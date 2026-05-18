-- Rewrite "Hardening a Linux Server" — Part 2 of 2.
-- Continues from V01.028. Adds steps 6-11, two new steps (monitoring, AppArmor),
-- SSH choice page entry with variants, and all page entries.

-- ============================================================
-- STEP 6: Nginx Rate Limiting
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-nginx', 'hardening-linux-server', 'nginx-rate-limiting',
'Nginx Rate Limiting',
'Rate limiting controls how many requests a client can make in a given time window. Without it, your web server is vulnerable to denial-of-service attacks, brute-force login attempts on web applications, and aggressive scrapers. A well-configured rate limit lets legitimate users browse normally while automatically throttling or blocking abusive clients.',
TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-nginx-1', 'hs-step-nginx', 'Leaky Bucket Algorithm',
'Nginx rate limiting is based on the leaky bucket algorithm. Imagine a bucket with a hole in the bottom. Requests pour in from the top; the hole drains them at a fixed rate. If requests arrive faster than the bucket can drain, it fills up. Once full, new requests overflow and are rejected. This enforces a maximum sustained rate while tolerating short bursts up to the bucket capacity.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-nginx-2', 'hs-step-nginx', 'Rate Limit Zones',
'A rate limit zone defines a shared memory region that tracks request counts per key (typically the client IP address). You define the zone name, key, memory size, and allowed rate. Multiple zones can apply to different locations — a strict limit on login endpoints, a relaxed limit on static assets.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-nginx-3', 'hs-step-nginx', 'burst and nodelay',
'The "burst" parameter allows a client to briefly exceed the rate, queuing excess requests rather than immediately rejecting them. "nodelay" processes queued burst requests immediately rather than spacing them out evenly. Without nodelay, burst requests are spaced over time, causing noticeable delays for legitimate users who make a few quick requests.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-nginx-4', 'hs-step-nginx', 'HTTP 429 Too Many Requests',
'When a client exceeds the rate limit and the burst queue is full, Nginx returns HTTP 429 (Too Many Requests). This is the correct status code for rate limiting. You can configure fail2ban to monitor Nginx access logs for 429 responses and ban IPs that trigger them repeatedly, creating a two-tier defence.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-nginx-1', 'hs-step-nginx',
'This diagram shows how the leaky bucket algorithm works in Nginx. Requests arrive from a client, fill the bucket, drain at a fixed rate, and overflow when the bucket is full.',
NULL, NULL,
'graph TD
    client([Client sends requests])
    check{Bucket full?}
    bucket["Bucket (burst queue)\nHolds up to ''burst'' requests\nwaiting to be processed"]
    drain["Drain at fixed rate\ne.g. 10 req/sec\nprocessed normally"]
    accept["Request Accepted\n200 OK"]
    reject["Request Rejected\n429 Too Many Requests"]

    client -->|New request arrives| check
    check -->|No — space available| bucket
    check -->|Yes — overflow| reject
    bucket -->|Processed at fixed rate| drain
    drain --> accept',
0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-nginx-2', 'hs-step-nginx',
'Define rate limit zones in the http block of your Nginx configuration (typically /etc/nginx/nginx.conf). Add these lines inside the http { } block.',
NULL,
'```nginx
# General zone: 10 req/sec per IP, 10 MB shared memory
limit_req_zone $binary_remote_addr zone=general:10m rate=10r/s;

# Strict zone for login/API: 3 req/sec per IP
limit_req_zone $binary_remote_addr zone=strict:10m rate=3r/s;

# Return 429 instead of 503 for rate-limited requests
limit_req_status 429;
```',
NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-nginx-3', 'hs-step-nginx',
'Apply the rate limits in your server block configuration (e.g. /etc/nginx/sites-available/default).',
NULL,
'```nginx
server {
    # General limit on all requests, burst of 20
    limit_req zone=general burst=20 nodelay;

    location /login {
        limit_req zone=strict burst=5 nodelay;
        # proxy_pass or try_files here
    }

    location /api/ {
        limit_req zone=strict burst=10 nodelay;
        # proxy_pass or try_files here
    }
}
```',
NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-nginx-4', 'hs-step-nginx',
'Test the Nginx configuration and reload.',
'sudo nginx -t
sudo systemctl reload nginx',
'nginx -t checks the configuration without applying it. Only reload after it reports "syntax is ok".',
NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-nginx-5', 'hs-step-nginx',
'Configure fail2ban to ban IPs that repeatedly trigger rate limits. Create a custom filter and jail for Nginx 429 responses.',
NULL,
'Create /etc/fail2ban/filter.d/nginx-ratelimit.conf:

[Definition]
failregex = ^<HOST> -.*"(GET|POST|HEAD).*" 429

Then add to /etc/fail2ban/jail.local:

[nginx-ratelimit]
enabled = true
port = http,https
logpath = /var/log/nginx/access.log
filter = nginx-ratelimit
maxretry = 10
findtime = 60
bantime = 3600

Restart fail2ban: sudo systemctl restart fail2ban',
NULL, 4);

-- ============================================================
-- STEP 7: Kernel Hardening and Sysctl Tuning
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-kernel', 'hardening-linux-server', 'kernel-hardening',
'Kernel Hardening and Sysctl Tuning',
'The Linux kernel is the foundation all other software runs on. Its default settings prioritise compatibility and performance over security. By tuning kernel parameters via sysctl, you can protect against SYN flood attacks, IP spoofing, source routing exploits, and restrict access to sensitive kernel information. These are the defences that limit damage even when a service running on top of the kernel is compromised.',
TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-kern-1', 'hs-step-kernel', 'Sysctl',
'Sysctl is the interface for reading and writing kernel parameters at runtime. Parameters in /proc/sys/ control network stack behaviour, memory management, filesystem settings, and security policies. Changes can be made live with "sysctl -w" or persisted in /etc/sysctl.d/ files.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-kern-2', 'hs-step-kernel', 'SYN Flood Protection',
'A SYN flood attack sends massive numbers of TCP SYN packets without completing the handshake, exhausting the server''s connection table. SYN cookies (net.ipv4.tcp_syncookies = 1) allow the server to handle SYN floods without allocating per-connection resources until the handshake completes — effectively making SYN floods harmless.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-kern-3', 'hs-step-kernel', 'IP Spoofing and Source Routing',
'IP spoofing sends packets with a forged source IP address. Reverse path filtering (rp_filter = 1) verifies that incoming packets arrive on the interface they would logically come from, rejecting spoofed traffic. Source routing allows packets to specify their own path through the network and should always be disabled on servers.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-kern-4', 'hs-step-kernel', 'Core Dump Restriction',
'Core dumps are memory snapshots written to disk when a process crashes. They can contain sensitive data like passwords, encryption keys, and session tokens. Setting fs.suid_dumpable = 0 prevents privileged processes from writing core dumps, blocking one method attackers use to extract secrets from memory.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-kern-5', 'hs-step-kernel', 'Kernel Pointer and dmesg Restrictions',
'Kernel pointers in /proc and dmesg output can leak memory addresses, making certain vulnerability classes easier to exploit. kernel.kptr_restrict = 2 hides kernel addresses from all users. kernel.dmesg_restrict = 1 hides kernel ring buffer messages from non-root users.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-kern-1', 'hs-step-kernel',
'Create a dedicated sysctl hardening file. Using /etc/sysctl.d/ is cleaner than editing /etc/sysctl.conf and survives package updates.',
'sudo nano /etc/sysctl.d/99-hardening.conf',
'The 99- prefix ensures this file is processed last and overrides any earlier conflicting settings.',
NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-kern-2', 'hs-step-kernel',
'Add the following security-hardening parameters to the file.',
NULL,
'```ini
# SYN flood protection
net.ipv4.tcp_syncookies = 1

# Disable IP source routing
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0

# Reverse path filtering (anti-spoofing)
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1

# Disable ICMP redirects
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0

# Ignore ICMP ping
net.ipv4.icmp_echo_ignore_all = 1

# Ignore broadcast pings (smurf attack mitigation)
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Log suspicious (martian) packets
net.ipv4.conf.all.log_martians = 1

# Increase TCP SYN backlog
net.ipv4.tcp_max_syn_backlog = 2048

# Restrict core dumps
fs.suid_dumpable = 0

# Hide kernel pointers from unprivileged users
kernel.kptr_restrict = 2

# Restrict dmesg to root only
kernel.dmesg_restrict = 1

# Restrict ptrace to root
kernel.yama.ptrace_scope = 1
```',
NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-kern-3', 'hs-step-kernel',
'Apply all new settings immediately without rebooting.',
'sudo sysctl -p /etc/sysctl.d/99-hardening.conf',
'To reload all sysctl files at once: sudo sysctl --system',
NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-kern-4', 'hs-step-kernel',
'Verify a selection of critical settings were applied correctly.',
'sudo sysctl net.ipv4.tcp_syncookies
sudo sysctl net.ipv4.conf.all.rp_filter
sudo sysctl kernel.kptr_restrict',
'Each should return the value you set. If any returns the wrong value, check for conflicting settings in other files under /etc/sysctl.d/.',
NULL, 3);

-- ============================================================
-- STEP 8: Automatic Security Updates
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-updates', 'hardening-linux-server', 'auto-updates',
'Automatic Security Updates',
'Many real-world breaches exploit known vulnerabilities that have patches available — but the patches were never applied. The gap between a vulnerability being disclosed and a patch being installed is when your server is most at risk. Automatic security updates eliminate the human delay factor, ensuring critical patches are applied within hours of release.',
TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-upd-1', 'hs-step-updates', 'Unattended Upgrades',
'The unattended-upgrades package on Debian/Ubuntu automatically downloads and installs security updates. It can be configured to handle only security patches (safest), all updates, or specific package origins. It also supports automatic reboots when kernel updates require them.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-upd-2', 'hs-step-updates', 'CVE',
'A Common Vulnerabilities and Exposures identifier is a unique reference for a publicly known security flaw. When a CVE is published, automated scanners immediately start probing for vulnerable systems. The time between CVE publication and patch application is your window of exposure.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-upd-3', 'hs-step-updates', 'Reboot Required',
'Kernel updates and some library updates (glibc, OpenSSL) require a reboot to take full effect. The file /var/run/reboot-required is created automatically when a reboot is needed. Unattended-upgrades can reboot at a scheduled time, or you can reboot manually during a maintenance window.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-upd-4', 'hs-step-updates', 'SMTP Relay',
'To receive email notifications, your server needs a way to send email. A fresh Linux server has no mail server installed. The simplest approach is msmtp: a lightweight mail transfer agent that relays outgoing email through an existing provider (Gmail, SendGrid, Mailgun) using credentials you supply. No full mail server is needed.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-upd-1', 'hs-step-updates',
'Install unattended-upgrades and run its interactive configuration tool.',
'sudo apt install unattended-upgrades apt-listchanges
sudo dpkg-reconfigure -plow unattended-upgrades',
'Answer "Yes" when prompted to automatically download and install stable updates. This creates the base configuration files.',
NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-upd-2', 'hs-step-updates',
'Edit the main configuration file to restrict updates to security patches and enable automatic reboots.',
'sudo nano /etc/apt/apt.conf.d/50unattended-upgrades',
'Key settings to configure:

Unattended-Upgrade::Allowed-Origins {
    "$${distro_id}:$${distro_codename}-security";
};

Unattended-Upgrade::Remove-Unused-Dependencies "true";
Unattended-Upgrade::Automatic-Reboot "true";
Unattended-Upgrade::Automatic-Reboot-Time "04:00";

Setting Automatic-Reboot-Time schedules any required reboot for 4 AM — a low-traffic window.',
NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-upd-3', 'hs-step-updates',
'Install msmtp to give your server the ability to send email via an external SMTP provider. No full mail server is required.',
'sudo apt install msmtp msmtp-mta',
'msmtp-mta sets msmtp as the system MTA so that tools like unattended-upgrades and logwatch can send email via the "mail" or "sendmail" command.',
NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-upd-4', 'hs-step-updates',
'Configure msmtp with your email provider credentials. Create /etc/msmtprc:',
NULL,
'```
defaults
auth           on
tls            on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile        /var/log/msmtp.log

account        default
host           smtp.gmail.com
port           587
from           your-server@gmail.com
user           your-server@gmail.com
password       your-app-password
```

For Gmail, create an App Password at: **Google Account → Security → 2-Step Verification → App Passwords**. Do NOT use your main Gmail password.

Secure the file:
```
sudo chmod 600 /etc/msmtprc
sudo chown root:root /etc/msmtprc
```',
NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-upd-5', 'hs-step-updates',
'Test that email sending works from the server.',
'echo "Test email from $(hostname)" | msmtp -v your-email@example.com',
'If the test email arrives, msmtp is configured correctly. If it fails, check /var/log/msmtp.log. Common issues: incorrect app password, wrong port, or UFW blocking outbound port 587.',
NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-upd-6', 'hs-step-updates',
'Set the notification email address in the unattended-upgrades config.',
'sudo nano /etc/apt/apt.conf.d/50unattended-upgrades',
'Add or uncomment:

Unattended-Upgrade::Mail "your-email@example.com";
Unattended-Upgrade::MailReport "on-change";

"on-change" sends email only when packages are actually upgraded.
Use "always" to receive a daily report even when nothing changed.',
NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-upd-7', 'hs-step-updates',
'Perform a dry run to verify the full configuration is correct.',
'sudo unattended-upgrades --dry-run --debug',
'The output shows which packages would be upgraded and whether email would be sent. Fix any errors before relying on the automatic behaviour.',
NULL, 6);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-upd-8', 'hs-step-updates',
'How to perform manual updates when you want to patch immediately.',
'sudo apt update
sudo apt upgrade
sudo apt autoremove',
'"apt update" refreshes the package lists from repositories.
"apt upgrade" installs available updates (prompts for confirmation).
"apt autoremove" removes packages that were installed as dependencies but are no longer needed.',
NULL, 7);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-upd-9', 'hs-step-updates',
'After updates, check whether a reboot is required.',
'cat /var/run/reboot-required 2>/dev/null && echo "Reboot required" || echo "No reboot needed"',
'To see which packages triggered the reboot requirement:
cat /var/run/reboot-required.pkgs',
NULL, 8);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-upd-10', 'hs-step-updates',
'When you are ready to reboot: warn any connected users, confirm no critical jobs are running, and ensure you can reconnect afterwards (test SSH in a second terminal before rebooting).',
'sudo reboot',
'Your SSH connection will drop when the server reboots. Wait 1-2 minutes and reconnect. If you cannot reconnect, check that sshd started: sudo systemctl status sshd (via console access if needed).',
NULL, 9);

-- ============================================================
-- STEP 9: Log Monitoring and Auditing
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-logging', 'hardening-linux-server', 'log-monitoring',
'Log Monitoring and Auditing',
'Security is not just about prevention — it is about detection. A well-monitored server alerts you to unusual patterns before a minor incident becomes a catastrophic breach. You will set up daily security summaries and automated disk space alerts sent by email.',
TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-log-1', 'hs-step-logging', 'Auth Log',
'/var/log/auth.log records every authentication event: successful and failed SSH logins, sudo usage, user switches, and PAM module activity. Monitoring this file is essential for detecting brute-force attempts, unauthorised access, and privilege escalation.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-log-2', 'hs-step-logging', 'Syslog',
'/var/log/syslog is the general system log, recording kernel messages, service start/stop events, cron job output, and other system events. Unusual entries can indicate hardware problems, misconfigured services, or intrusion attempts.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-log-3', 'hs-step-logging', 'Logwatch',
'Logwatch parses multiple log files and generates a concise daily summary report covering failed logins, successful logins, new user accounts, service restarts, and more. It sends the report as an email, giving you a daily security digest without manually reading raw logs.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-log-4', 'hs-step-logging', 'Disk Space Monitoring',
'Full disks prevent logs from being written (hiding attacks), can crash running services, and may indicate a log-flooding attack. Automated monitoring sends an alert before the disk becomes critically full, giving you time to investigate.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-log-1', 'hs-step-logging',
'Familiarise yourself with the key log files you will monitor regularly.',
'sudo tail -f /var/log/auth.log',
'Watch for: "Failed password", "Invalid user", "Accepted publickey", "sudo:". Press Ctrl+C to stop.
To search for all failures in the last hour: sudo grep "Failed" /var/log/auth.log | tail -50',
NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-log-2', 'hs-step-logging',
'Install logwatch.',
'sudo apt install logwatch',
'Logwatch runs daily via cron. Its configuration lives in /etc/logwatch/conf/logwatch.conf.',
NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-log-3', 'hs-step-logging',
'Create the logwatch configuration file to send daily email reports.',
'sudo mkdir -p /etc/logwatch/conf
sudo nano /etc/logwatch/conf/logwatch.conf',
'Add these lines:

```
Output = mail
MailTo = your-email@example.com
MailFrom = logwatch@your-server-hostname
Detail = High
Range = yesterday
Service = All
```

Test immediately: `sudo logwatch --output mail --mailto your-email@example.com --detail high`',
NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-log-4', 'hs-step-logging',
'Install interactive monitoring tools to view server performance at any time.',
'sudo apt install htop iotop nethogs ncdu',
'- htop: interactive process viewer showing CPU and memory per process
- iotop: disk I/O per process — find what is hammering the disk
- nethogs: network bandwidth per process — detect unexpected outbound data transfers
- ncdu: interactive disk usage analyser — find which directories consume the most space',
NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-log-5', 'hs-step-logging',
'Create an automated disk space alert script that emails you when any partition exceeds 80% usage.',
NULL,
'Create /usr/local/bin/disk-alert.sh:

#!/bin/bash
THRESHOLD=80
MAILTO="your-email@example.com"
HOSTNAME=$(hostname)

df -H | grep -vE "^Filesystem|tmpfs|cdrom" | awk ''{ print $5 " " $1 }'' | while read output; do
  USAGE=$(echo $output | awk ''{ print $1}'' | sed ''s/%//g'')
  PARTITION=$(echo $output | awk ''{ print $2 }'')
  if [ "$USAGE" -ge "$THRESHOLD" ]; then
    echo "WARNING: Disk usage on $${HOSTNAME} is $${USAGE}% on $${PARTITION}" | msmtp $MAILTO
  fi
done

Make it executable:
sudo chmod +x /usr/local/bin/disk-alert.sh

Schedule it to run daily at 7 AM:
echo "0 7 * * * root /usr/local/bin/disk-alert.sh" | sudo tee /etc/cron.d/disk-alert',
NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-log-6', 'hs-step-logging',
'Test the disk alert script manually.',
'sudo /usr/local/bin/disk-alert.sh',
'If all partitions are below 80%, temporarily set THRESHOLD=1 in the script to force a test alert and confirm email delivery works, then set it back to 80.',
NULL, 5);

-- ============================================================
-- STEP 10: User and Permission Hardening
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-users', 'hardening-linux-server', 'user-permissions',
'User and Permission Hardening',
'If a web server process is compromised, it should not be able to read your SSH keys or database files. The principle of least privilege means every user and service runs with the minimum access it needs — and nothing more. Proper isolation ensures a breach in one service cannot spread to the entire system.',
TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-usr-1', 'hs-step-users', 'The Ten Columns of ls -la',
'When you run "ls -la", each line shows: (1) type and permissions string e.g. -rwxr-xr-- — first char is type ("-"=file, "d"=dir, "l"=symlink), then three groups of three: owner permissions, group permissions, others permissions — "r"=read, "w"=write, "x"=execute/enter, "-"=denied; (2) hard link count; (3) owner name; (4) group name; (5) file size in bytes; (6) month; (7) day; (8) time or year; (9) filename. Example: "-rw-r----- 1 root ssl-cert 1679 Jan 10 sslkey" means a regular file, owner can read+write, group can read only, others have no access.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-usr-2', 'hs-step-users', 'chmod — Changing Permissions',
'chmod changes file permissions. Numeric (octal) mode: each digit represents owner, group, others. 4=read, 2=write, 1=execute — add them: 7=rwx, 6=rw-, 5=r-x, 4=r--. Example: chmod 640 file.txt gives owner rw-, group r--, others nothing. Symbolic mode: chmod u+x adds execute for owner; chmod go-w removes write from group and others; chmod a=r sets everyone to read-only. The -R flag applies recursively to a directory.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-usr-3', 'hs-step-users', 'chown and chgrp',
'chown changes file ownership. "sudo chown alice file.txt" makes alice the owner. "sudo chown alice:webteam file.txt" sets both owner and group simultaneously. chgrp changes only the group: "sudo chgrp webteam file.txt". The -R flag applies recursively: "sudo chown -R www-data:www-data /var/www/html" sets everything under /var/www/html to be owned by the www-data user and group.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-usr-4', 'hs-step-users', 'Principle of Least Privilege',
'Every process, user, and service should have only the permissions it absolutely needs. A web server needs to read web files and write logs — nothing else. A database needs to read/write its data directory — nothing else. This limits the blast radius of any single compromise: even if the web server is exploited, it cannot access SSH keys or database credentials stored elsewhere.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-usr-5', 'hs-step-users', 'AppArmor',
'AppArmor is a Linux kernel security module that restricts what files and capabilities a program can access, based on per-program profiles. Even if an attacker compromises a process, AppArmor prevents it from accessing anything outside its defined profile — a sandbox for individual services. Ubuntu ships with AppArmor enabled and pre-built profiles for common services like Nginx and MySQL.',
4);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-usr-6', 'hs-step-users', 'sudo and /etc/sudoers',
'sudo allows ordinary users to run specific commands as root. /etc/sudoers (edited safely with visudo) controls which users can run which commands. The default "ALL=(ALL:ALL) ALL" grants unrestricted root access — avoid this for service accounts. Instead, grant only the specific commands each account needs.',
5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-usr-1', 'hs-step-users',
'Understanding the columns of ls -la. Run this to see SSH key file permissions:',
'ls -la /etc/ssh/',
'Example line:
-rw------- 1 root root 411 Jan 10 09:23 ssh_host_ed25519_key

Reading it column by column:
Col 1: "-rw-------" → regular file; owner=rw, group=none, others=none
Col 2: "1" → one hard link
Col 3: "root" → owner
Col 4: "root" → group
Col 5: "411" → size in bytes
Cols 6-8: "Jan 10 09:23" → last modified
Col 9: "ssh_host_ed25519_key" → filename

Only root can read or write this private key — exactly right.',
NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-usr-2', 'hs-step-users',
'Audit all user accounts with real login shells — these are the accounts an attacker could use.',
'awk -F: ''$7 !~ /nologin|false/ { print $1, $7 }'' /etc/passwd',
'You should only see your own account and root with real shells. Service accounts (www-data, mysql, postgres) should have /usr/sbin/nologin or /bin/false. Any unrecognised account with a real shell should be investigated immediately.',
NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-usr-3', 'hs-step-users',
'Disable any account you do not recognise or no longer need.',
'sudo usermod -s /usr/sbin/nologin <username>',
'This prevents login without deleting the account or its files. To re-enable later: sudo usermod -s /bin/bash <username>
To fully delete a user and their home directory: sudo deluser --remove-home <username>',
NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-usr-4', 'hs-step-users',
'Review which users have sudo access.',
'getent group sudo
sudo cat /etc/sudoers
sudo ls /etc/sudoers.d/',
'Be suspicious of any account in the sudo group you did not explicitly add. An unauthorised sudo account is effectively a root backdoor.',
NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-usr-5', 'hs-step-users',
'Find world-writable files — files any user on the system can modify, which is rarely intentional.',
'sudo find / -type f -perm -o+w -not -path "/proc/*" -not -path "/sys/*" 2>/dev/null',
'Any world-writable file outside /tmp and /var/tmp is a potential risk. Fix with: sudo chmod o-w /path/to/file',
NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-usr-6', 'hs-step-users',
'Find SUID and SGID binaries — programs that run with elevated permissions. Review this list regularly.',
'sudo find / -type f \( -perm -4000 -o -perm -2000 \) -not -path "/proc/*" 2>/dev/null',
'Some SUID binaries are legitimate: sudo, passwd, ping. Any SUID binary you do not recognise is suspicious. Remove the SUID bit if unneeded: sudo chmod u-s /path/to/binary',
NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-usr-7', 'hs-step-users',
'Set correct ownership and permissions for web server files.',
'sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html',
'755 on directories: owner can read/write/enter, group and others can read and enter but not write.
Config files that contain secrets (passwords, API keys) should be 640 so only the owner and group can read them.',
NULL, 6);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-usr-8', 'hs-step-users',
'Check AppArmor status and ensure profiles are enforced for running services.',
'sudo apparmor_status',
'Look for profiles in "enforce" mode. If a profile shows "complain" mode, it is logging violations but not blocking them — switch to enforce: sudo aa-enforce /etc/apparmor.d/<profile-name>
To see which services have AppArmor profiles: ls /etc/apparmor.d/',
NULL, 7);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-usr-9', 'hs-step-users',
'Use visudo to safely edit sudo permissions. Never edit /etc/sudoers directly — a syntax error locks out all sudo access.',
'sudo visudo',
'Example of a fine-grained sudo rule for a deploy user who only needs to restart Nginx:

deploy ALL=(root) NOPASSWD: /bin/systemctl restart nginx

This is far better than adding deploy to the sudo group and giving them full root access.',
NULL, 8);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-usr-10', 'hs-step-users',
'Grant a deploy user write access to /var/www using a shared group. This is the cleanest approach: Nginx runs as www-data, your deploy user joins the same group, and the directory is group-writable.',
'sudo groupadd webdeploy
sudo usermod -aG webdeploy www-data
sudo usermod -aG webdeploy your-deploy-user
sudo chown -R www-data:webdeploy /var/www/html
sudo chmod -R 775 /var/www/html
sudo find /var/www/html -type d -exec chmod g+s {} \;',
'`chmod g+s` sets the **setgid bit** on every directory. This makes any new file or directory created inside inherit the `webdeploy` group automatically — so files copied in by your deploy user are immediately readable by `www-data` without manual permission fixes.

The deploy user must **log out and back in** (or start a new SSH session) after being added to the group for the membership to take effect. Verify with: `id your-deploy-user`',
NULL, 9);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-usr-11', 'hs-step-users',
'Test that your deploy user can write to /var/www/html by creating and removing a test file.',
'sudo -u your-deploy-user touch /var/www/html/deploy-test.txt
ls -la /var/www/html/deploy-test.txt
sudo -u your-deploy-user rm /var/www/html/deploy-test.txt',
'Check the output of `ls -la`: the group should show `webdeploy` and the permissions should be `-rw-r--r--` or similar. If you see a "Permission denied" error, confirm the setgid bit is set on the directory (`ls -la /var/www/` should show `drwxrwsr-x`) and that the deploy user''s group membership is active.',
NULL, 10);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-usr-12', 'hs-step-users',
'Copy your website files to the server using scp (from your local machine) or rsync for incremental updates.',
NULL,
'**Copy a single file:**
```
scp ./index.html your-deploy-user@your-server-ip:/var/www/html/
```

**Copy an entire directory (rsync — preferred for updates):**
```
rsync -avz --delete ./dist/ your-deploy-user@your-server-ip:/var/www/html/
```

`--delete` removes files on the server that no longer exist locally, keeping the deployment clean. Omit it if you want to preserve files not in your local build.

After copying, verify Nginx can still read the files:
```
sudo -u www-data ls /var/www/html/
```
If any file shows as unreadable, fix with: `sudo chmod -R o+r /var/www/html/`',
NULL, 11);

-- ============================================================
-- STEP 11: Server Performance Monitoring
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-monitoring', 'hardening-linux-server', 'monitoring',
'Server Performance Monitoring',
'Knowing the baseline performance of your server makes security incidents far easier to detect. A sudden spike in CPU or network activity often indicates compromise — a miner, a DDoS participant, or data exfiltration. This page sets up lightweight monitoring tools so you can view real-time performance and receive alerts when resources are critically low.',
TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-mon-1', 'hs-step-monitoring', 'Load Average',
'The load average (shown in htop and uptime) represents the average number of processes waiting for CPU time over the last 1, 5, and 15 minutes. A load average higher than your number of CPU cores means processes are queueing — the server is overloaded. On a 2-core server, a sustained load above 2.0 warrants investigation.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-mon-2', 'hs-step-monitoring', 'Memory Pressure',
'When a server runs low on RAM, the kernel starts using swap space (disk) for memory, causing dramatic slowdowns. Monitoring memory usage helps you identify memory leaks in services before they cause an outage. The "free -h" command shows total, used, free, and available memory — "available" is the most useful figure as it accounts for cached memory that can be reclaimed.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-mon-3', 'hs-step-monitoring', 'I/O Wait',
'I/O wait (shown in htop as %iowait) is the percentage of time the CPU spends waiting for disk or network I/O to complete. High I/O wait indicates a disk bottleneck — common causes are a failing disk, a runaway process writing excessively to disk, or a full disk.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-mon-4', 'hs-step-monitoring', 'Netdata',
'Netdata is a lightweight, real-time monitoring tool that provides a web-based dashboard showing CPU, memory, disk, network, and per-process metrics with per-second granularity. It runs as a local service and can send alerts by email when metrics cross configurable thresholds.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-mon-1', 'hs-step-monitoring',
'Install the core set of interactive monitoring tools.',
'sudo apt install htop iotop nethogs ncdu sysstat',
'- htop: interactive CPU and memory view per process
- iotop: disk I/O per process (run with sudo)
- nethogs: network bandwidth per process (run with sudo)
- ncdu: interactive disk usage browser
- sysstat: provides sar, iostat, and mpstat for historical performance data',
NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-mon-2', 'hs-step-monitoring',
'Enable sysstat to collect performance data every 10 minutes for historical analysis.',
'sudo systemctl enable --now sysstat',
'After enabling, historical data is collected to /var/log/sysstat/. View CPU history for today: sar -u
View disk I/O history: sar -d
View memory history: sar -r',
NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-mon-3', 'hs-step-monitoring',
'Install Netdata for a web-based real-time monitoring dashboard.',
'wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh
sudo sh /tmp/netdata-kickstart.sh --stable-channel --disable-telemetry',
'Netdata listens on port 19999 by default. After installation, view the dashboard at http://your-server-ip:19999 — but only after adding a UFW rule temporarily: sudo ufw allow in 19999/tcp
For production, access Netdata via an SSH tunnel instead: ssh -L 19999:localhost:19999 user@your-server-ip
Then open http://localhost:19999 on your local machine.',
NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-mon-4', 'hs-step-monitoring',
'Configure Netdata email alerts. Edit the Netdata health notification configuration.',
'sudo nano /etc/netdata/health_alarm_notify.conf',
'Find and set these values:

```
SEND_EMAIL="YES"
DEFAULT_RECIPIENT_EMAIL="your-email@example.com"
EMAIL_SENDER="netdata@$(hostname)"
```

Netdata uses the system MTA (msmtp, configured earlier) to send emails. Test alerts with:
`sudo -u netdata /usr/libexec/netdata/plugins.d/alarm-notify.sh test`',
NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-mon-5', 'hs-step-monitoring',
'View current disk usage across all mounted filesystems.',
'df -h',
'The "Use%" column shows percentage used. Any filesystem above 80% should be investigated. To find which directories are largest in a specific path: sudo ncdu /var',
NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-mon-6', 'hs-step-monitoring',
'View current memory usage.',
'free -h',
'Focus on the "available" column — this is the memory the kernel can make available quickly. If available is consistently below 10% of total RAM, consider adding swap space or upgrading RAM.',
NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-mon-7', 'hs-step-monitoring',
'Quick performance snapshot: see load average, top CPU consumers, and memory at a glance.',
'uptime
ps aux --sort=-%cpu | head -10
ps aux --sort=-%mem | head -10',
'The three numbers after "load average:" are 1-minute, 5-minute, and 15-minute averages. If all three are high, the server has been under sustained load — not just a brief spike.',
NULL, 6);

-- ============================================================
-- STEP 12: AppArmor — Sandboxing Services
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('hs-step-apparmor', 'hardening-linux-server', 'apparmor',
'AppArmor — Sandboxing Services with Mandatory Access Control',
'Even with perfect permissions, a vulnerability in a service could allow an attacker to access files the service owner can read. AppArmor enforces a whitelist of exactly what files and capabilities each program is allowed to use — regardless of Linux user permissions. If a service is compromised, AppArmor contains the damage.',
TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-aa-1', 'hs-step-apparmor', 'Mandatory Access Control',
'Traditional Linux permissions are discretionary: a file owner decides who can access it. Mandatory Access Control (MAC) is enforced by the kernel regardless of owner decisions. AppArmor is a MAC system — even if a process runs as root, AppArmor can prevent it from accessing files or capabilities outside its profile.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-aa-2', 'hs-step-apparmor', 'Enforce vs Complain Mode',
'An AppArmor profile in enforce mode blocks any access not explicitly permitted and logs the violation. Complain mode logs violations but does not block them — useful when initially building a profile for an application. Always move profiles to enforce mode in production.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('hs-ii-aa-3', 'hs-step-apparmor', 'Profile',
'An AppArmor profile is a text file that defines exactly what a specific program is allowed to do: which files it can read or write, which capabilities it can use, which network operations are permitted, and which other programs it can execute. Profiles are stored in /etc/apparmor.d/.',
2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-aa-1', 'hs-step-apparmor',
'Check AppArmor is active and see the current status of all loaded profiles.',
'sudo apparmor_status',
'The output shows how many profiles are loaded, how many are in enforce mode, and how many are in complain mode. Ubuntu ships with AppArmor enabled and enforce-mode profiles for services like Nginx, MySQL, and others.',
NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-aa-2', 'hs-step-apparmor',
'Install the AppArmor utilities package for additional tools.',
'sudo apt install apparmor-utils',
'This provides aa-enforce, aa-complain, aa-genprof (profile generator), and aa-logprof (log-based profile refinement).',
NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-aa-3', 'hs-step-apparmor',
'Switch any profiles currently in complain mode to enforce mode.',
'sudo aa-enforce /etc/apparmor.d/*',
'If a specific service breaks after switching to enforce mode, check /var/log/syslog or /var/log/kern.log for AppArmor denial messages to understand what additional access the service needs.',
NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-aa-4', 'hs-step-apparmor',
'Check for recent AppArmor denials — these indicate either a misconfigured profile or a service attempting to access something it should not.',
'sudo grep "apparmor.*DENIED" /var/log/syslog | tail -20',
'A denial on a healthy server in enforce mode is either a profile that needs refinement (legitimate access being blocked) or a sign of an attempted intrusion (a compromised process trying to access files outside its normal scope).',
NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('hs-in-aa-5', 'hs-step-apparmor',
'To create a new profile for a service that does not have one, use aa-genprof. It watches the program run and builds a profile from what it observes.',
'sudo aa-genprof /path/to/program',
'Run the program through its normal operations while aa-genprof is watching, then press S to scan the logs and F to finish. The tool will propose allow rules based on what the program actually did — review each one before accepting.',
NULL, 4);

-- ============================================================
-- PAGE ENTRIES
-- ============================================================

-- Page 0: Introduction (DIRECT)
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('hs-pe-intro', 'hardening-linux-server', 'DIRECT', 0, 'hs-step-intro', NULL, NULL, NULL, NULL);

-- Page 1: Fail2ban (DIRECT)
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('hs-pe-fail2ban', 'hardening-linux-server', 'DIRECT', 1, 'hs-step-fail2ban', NULL, NULL, NULL, NULL);

-- Page 2: Firewall (DIRECT)
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('hs-pe-firewall', 'hardening-linux-server', 'DIRECT', 2, 'hs-step-firewall', NULL, NULL, NULL, NULL);

-- Page 3: Disable Ping (DIRECT)
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('hs-pe-disable-ping', 'hardening-linux-server', 'DIRECT', 3, 'hs-step-disable-ping', NULL, NULL, NULL, NULL);

-- Page 4: SSH Hardening (CHOICE — Linux or Windows client)
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('hs-pe-ssh', 'hardening-linux-server', 'CHOICE', 4, NULL,
'SSH Hardening with Certificate-Based Authentication',
'SSH certificate-based authentication eliminates password login entirely. Choose your local operating system — the steps differ for Linux (using the built-in OpenSSH tools and ssh-agent) and Windows (using PuTTY, WinSCP, and Pageant).',
1, 1);

INSERT INTO T_choice_variant (id, page_entry_id, label, description, step_id, sequence_order)
VALUES ('hs-cv-ssh-linux', 'hs-pe-ssh',
'Linux Client',
'Use ssh-keygen, ssh-copy-id, and ssh-agent on Linux or macOS to generate a key pair, copy it to the server, and manage your key in memory.',
'hs-step-ssh-linux', 0);

INSERT INTO T_choice_variant (id, page_entry_id, label, description, step_id, sequence_order)
VALUES ('hs-cv-ssh-windows', 'hs-pe-ssh',
'Windows Client',
'Use PuTTY, PuTTYgen, WinSCP, and Pageant on Windows to generate a key pair, copy it to the server, and store the decrypted key in Pageant so you only enter your passphrase once per session.',
'hs-step-ssh-windows', 1);

-- Page 5: Nginx Rate Limiting (DIRECT)
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('hs-pe-nginx', 'hardening-linux-server', 'DIRECT', 5, 'hs-step-nginx', NULL, NULL, NULL, NULL);

-- Page 6: Kernel Hardening (DIRECT)
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('hs-pe-kernel', 'hardening-linux-server', 'DIRECT', 6, 'hs-step-kernel', NULL, NULL, NULL, NULL);

-- Page 7: Auto Updates (DIRECT)
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('hs-pe-updates', 'hardening-linux-server', 'DIRECT', 7, 'hs-step-updates', NULL, NULL, NULL, NULL);

-- Page 8: Log Monitoring (DIRECT)
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('hs-pe-logging', 'hardening-linux-server', 'DIRECT', 8, 'hs-step-logging', NULL, NULL, NULL, NULL);

-- Page 9: User and Permission Hardening (DIRECT)
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('hs-pe-users', 'hardening-linux-server', 'DIRECT', 9, 'hs-step-users', NULL, NULL, NULL, NULL);

-- Page 10: Server Performance Monitoring (DIRECT)
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('hs-pe-monitoring', 'hardening-linux-server', 'DIRECT', 10, 'hs-step-monitoring', NULL, NULL, NULL, NULL);

-- Page 11: AppArmor (DIRECT)
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required)
VALUES ('hs-pe-apparmor', 'hardening-linux-server', 'DIRECT', 11, 'hs-step-apparmor', NULL, NULL, NULL, NULL);
