-- Insert "SSL with Certbot from Let's Encrypt" as a coming-soon certification

INSERT INTO T_certification (id, title, description, coming_soon, sequence_order, created_at, updated_at)
VALUES ('ssl-certbot-letsencrypt', 'SSL with Certbot from Let''s Encrypt',
'Secure your website with HTTPS — for free. Learn why SSL/TLS certificates matter, how the browser-server handshake works, and build bash scripts that automate certificate creation and renewal using Certbot and Let''s Encrypt. Never worry about expired certificates again.',
TRUE, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ============================================================
-- STEP 1: Introduction — Why SSL/TLS Matters
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ssl-step-intro', 'ssl-certbot-letsencrypt', 'intro',
'Welcome to SSL with Certbot',
'Every time a browser connects to a website over plain HTTP, the data travels in clear text — passwords, credit card numbers, personal information, all readable by anyone on the network path. SSL/TLS encryption wraps that communication in a secure tunnel that only the browser and server can read. This certification teaches you how HTTPS works under the hood, how to obtain free certificates from Let''s Encrypt, and how to build automation scripts so your certificates renew themselves.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-intro-1', 'ssl-step-intro',
'SSL/TLS',
'SSL (Secure Sockets Layer) and its successor TLS (Transport Layer Security) are cryptographic protocols that provide encrypted communication between a client and a server. When you see the padlock icon in your browser, TLS is active. Modern browsers use TLS 1.2 or 1.3 — the term "SSL" persists colloquially but the actual protocol in use is TLS.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-intro-2', 'ssl-step-intro',
'Certificate Authority (CA)',
'A Certificate Authority is a trusted third party that verifies domain ownership and issues digital certificates. When your browser sees a certificate signed by a trusted CA, it knows the server is who it claims to be. Let''s Encrypt is a free, automated CA that has issued billions of certificates.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-intro-3', 'ssl-step-intro',
'ACME Protocol',
'The Automatic Certificate Management Environment protocol is the standard used by Let''s Encrypt to automate certificate issuance and renewal. Certbot speaks ACME — it proves you control a domain, requests a certificate, and installs it, all without manual intervention.',
2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ssl-in-intro-1', 'ssl-step-intro',
'This is what happens when a browser connects to an HTTPS server — the TLS handshake establishes a secure channel before any application data is exchanged:',
NULL, NULL,
'sequenceDiagram
    participant Browser
    participant Server

    Browser->>Server: ClientHello (supported TLS versions, cipher suites)
    Server->>Browser: ServerHello (chosen TLS version, cipher suite)
    Server->>Browser: Certificate (signed by CA)
    Server->>Browser: ServerKeyExchange
    Browser->>Browser: Verify certificate against trusted CAs
    Browser->>Server: ClientKeyExchange (encrypted pre-master secret)
    Note over Browser,Server: Both derive session keys from pre-master secret
    Browser->>Server: Finished (encrypted with session key)
    Server->>Browser: Finished (encrypted with session key)
    Note over Browser,Server: Secure channel established — all data encrypted',
0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ssl-in-intro-2', 'ssl-step-intro',
'This certification builds on the Linux Home Server Setup certification. You should have a working Nginx web server accessible via a domain name before starting. You will learn to obtain, install, and automatically renew SSL certificates using bash scripts.',
NULL, NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ssl-in-intro-3', 'ssl-step-intro',
'This certification is coming soon. The pages ahead show what you will learn — check back later for the full content!',
NULL, NULL, NULL, 2);

-- ============================================================
-- STEP 2: How HTTPS and Certificates Work
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ssl-step-how-it-works', 'ssl-certbot-letsencrypt', 'how-https-works',
'How HTTPS and Certificates Work',
'Before automating anything, you need to understand what a certificate actually is, what it contains, and why browsers trust some certificates but reject others. This foundational knowledge will help you debug certificate problems, understand error messages, and make informed decisions about your TLS configuration.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-how-1', 'ssl-step-how-it-works',
'X.509 Certificate',
'An X.509 certificate is a digital document that binds a public key to a domain name (or other identity). It contains the domain name, the public key, the issuer (CA), a validity period, and a digital signature from the CA. Browsers check this signature against their built-in list of trusted CAs.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-how-2', 'ssl-step-how-it-works',
'Certificate Chain',
'Certificates form a chain of trust: your server''s certificate is signed by an intermediate CA, which is signed by a root CA that the browser trusts. The server must send the full chain (server cert + intermediates) so the browser can verify each link back to a trusted root.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-how-3', 'ssl-step-how-it-works',
'Domain Validation (DV)',
'Domain Validation is the simplest level of certificate verification. The CA confirms you control the domain — typically by placing a specific file on the web server or creating a DNS record. Let''s Encrypt uses DV exclusively, which is why issuance can be fully automated.',
2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ssl-in-how-1', 'ssl-step-how-it-works',
'Examine the certificate of any HTTPS website to see its structure: subject, issuer, validity dates, public key, and the full certificate chain.',
'echo | openssl s_client -connect example.com:443 -servername example.com 2>/dev/null | openssl x509 -noout -text | head -30',
'The -servername flag is important for servers hosting multiple domains (SNI). Without it, you may get the wrong certificate.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ssl-in-how-2', 'ssl-step-how-it-works',
'Understand what happens when a certificate expires: browsers display a full-page security warning and most users will leave immediately. Let''s Encrypt certificates are valid for 90 days — intentionally short to encourage automation.',
NULL,
'A 90-day validity means you must renew at least every 60 days (Certbot does this automatically). Short validity also limits the damage window if a private key is compromised.',
NULL, 1);

-- ============================================================
-- STEP 3: Installing and Configuring Certbot
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ssl-step-certbot-install', 'ssl-certbot-letsencrypt', 'certbot-install',
'Installing and Configuring Certbot',
'Certbot is the official Let''s Encrypt client. It handles the entire certificate lifecycle: proving domain ownership, requesting the certificate, installing it in your web server configuration, and setting up automatic renewal. Getting Certbot installed and configured correctly is the foundation for everything that follows.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-cb-1', 'ssl-step-certbot-install',
'Certbot',
'Certbot is a free, open-source tool maintained by the EFF (Electronic Frontier Foundation) that automates Let''s Encrypt certificate management. It has plugins for Apache, Nginx, and standalone mode, and can handle everything from a single domain to hundreds of subdomains.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-cb-2', 'ssl-step-certbot-install',
'Webroot vs Standalone',
'Certbot can prove domain ownership in two main ways: webroot mode places a verification file in your existing web server''s document root (no downtime), while standalone mode temporarily starts its own web server on port 80 (requires stopping your web server). For production servers with Nginx, webroot mode is preferred.',
1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ssl-in-cb-1', 'ssl-step-certbot-install',
'Install Certbot and the Nginx plugin from the official repositories.',
'sudo apt update && sudo apt install certbot python3-certbot-nginx',
'The python3-certbot-nginx plugin can automatically modify your Nginx configuration to use the new certificate and set up proper redirects.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ssl-in-cb-2', 'ssl-step-certbot-install',
'Verify that your domain''s DNS A record points to your server''s public IP and that port 80 is open in your firewall. Certbot must be reachable from the internet to prove domain ownership.',
'dig +short A yourdomain.com',
'If your domain does not resolve to your server''s IP, the ACME challenge will fail. Double-check your DNS settings and wait for propagation (can take up to 48 hours for new records).',
NULL, 1);

-- ============================================================
-- STEP 4: Obtaining Your First Certificate
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ssl-step-first-cert', 'ssl-certbot-letsencrypt', 'first-certificate',
'Obtaining Your First Certificate',
'This is the moment your server goes from HTTP to HTTPS. You will run Certbot to obtain a certificate for your domain, understand what files it creates and where they are stored, and verify that your Nginx configuration is correctly updated to serve traffic over HTTPS.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-fc-1', 'ssl-step-first-cert',
'Certificate Files',
'Certbot stores certificates in /etc/letsencrypt/live/yourdomain.com/. The key files are: fullchain.pem (your certificate + intermediates), privkey.pem (your private key), cert.pem (just your certificate), and chain.pem (just the intermediates). Nginx needs fullchain.pem and privkey.pem.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-fc-2', 'ssl-step-first-cert',
'HTTP to HTTPS Redirect',
'After obtaining a certificate, you should redirect all HTTP traffic to HTTPS. This ensures every visitor uses the encrypted connection. Certbot can set this up automatically, or you can configure it manually in Nginx with a 301 redirect.',
1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ssl-in-fc-1', 'ssl-step-first-cert',
'Run Certbot with the Nginx plugin to obtain a certificate and automatically configure Nginx. Certbot will ask whether to redirect HTTP to HTTPS — always choose yes for production servers.',
'sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com',
'Replace yourdomain.com with your actual domain. The -d flag can be repeated for multiple subdomains — all will be covered by the same certificate.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ssl-in-fc-2', 'ssl-step-first-cert',
'Verify the certificate is installed correctly by checking Nginx''s configuration and testing the HTTPS connection.',
'sudo nginx -t && echo | openssl s_client -connect yourdomain.com:443 -servername yourdomain.com 2>/dev/null | openssl x509 -noout -dates',
'The output should show "notBefore" (today) and "notAfter" (90 days from now). If the dates look wrong or the connection fails, check the Nginx error log.',
NULL, 1);

-- ============================================================
-- STEP 5: Writing a Certificate Request Script
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ssl-step-request-script', 'ssl-certbot-letsencrypt', 'request-script',
'Writing a Certificate Request Script',
'Running Certbot manually is fine for a single domain, but if you manage multiple domains or want a repeatable, documented process, a bash script is essential. You will write a script that takes a domain name as an argument, validates prerequisites, obtains the certificate, configures Nginx, and verifies everything works — all in one command.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-rs-1', 'ssl-step-request-script',
'Idempotent Scripts',
'An idempotent script produces the same result whether you run it once or ten times. For certificate management, this means the script should check if a certificate already exists before requesting a new one, verify the Nginx configuration before reloading, and handle errors gracefully without leaving the system in a broken state.',
0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ssl-in-rs-1', 'ssl-step-request-script',
'You will build a bash script that accepts a domain name, checks DNS resolution, verifies Nginx is running, requests a certificate with Certbot in non-interactive mode, and tests the result. The script will be idempotent — safe to run repeatedly.',
NULL,
'Non-interactive mode (--non-interactive) is crucial for scripts. It prevents Certbot from prompting for input, which would cause the script to hang in cron jobs or automated pipelines.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ssl-in-rs-2', 'ssl-step-request-script',
'Add error handling: the script should exit with a clear error message if DNS is misconfigured, if port 80 is blocked, if Certbot fails, or if the Nginx configuration test fails after certificate installation.',
NULL,
'Use set -euo pipefail at the top of your script to catch errors early. Each step should validate the previous step''s output before continuing.',
NULL, 1);

-- ============================================================
-- STEP 6: Automatic Renewal
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ssl-step-renewal', 'ssl-certbot-letsencrypt', 'auto-renewal',
'Automatic Certificate Renewal',
'Let''s Encrypt certificates expire after 90 days. If you forget to renew, your site shows a scary browser warning and visitors leave. Certbot includes a built-in renewal mechanism, but you need to verify it works, monitor it, and handle edge cases like Nginx reload after renewal. This page teaches you to set up bulletproof automatic renewal.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-ren-1', 'ssl-step-renewal',
'Certbot Renew',
'The certbot renew command checks all installed certificates and renews any that are within 30 days of expiry. It uses the same method (webroot, standalone, or nginx plugin) that was used for the original issuance. It is designed to be run frequently (e.g. twice daily) and does nothing if no renewal is needed.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-ren-2', 'ssl-step-renewal',
'Deploy Hook',
'A deploy hook is a script that Certbot runs after a successful renewal. The most common hook reloads Nginx so it picks up the new certificate files. Without a deploy hook, Nginx continues serving the old certificate from memory even after renewal, and the new certificate only takes effect after a manual restart.',
1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ssl-in-ren-1', 'ssl-step-renewal',
'Test the renewal process with a dry run. This simulates renewal without actually contacting Let''s Encrypt, verifying that your configuration and permissions are correct.',
'sudo certbot renew --dry-run',
'If the dry run succeeds, real renewal will work. If it fails, the error message will tell you exactly what is wrong — usually a permissions issue or a web server configuration problem.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ssl-in-ren-2', 'ssl-step-renewal',
'Configure a deploy hook that reloads Nginx after every successful renewal, and verify the systemd timer or cron job that triggers certbot renew twice daily.',
'sudo sh -c ''echo "#!/bin/bash\nnginx -t && systemctl reload nginx" > /etc/letsencrypt/renewal-hooks/deploy/reload-nginx.sh && chmod +x /etc/letsencrypt/renewal-hooks/deploy/reload-nginx.sh''',
'Certbot on modern Debian/Ubuntu installs a systemd timer (certbot.timer) that runs renewal twice daily. Verify with: systemctl list-timers | grep certbot',
NULL, 1);

-- ============================================================
-- STEP 7: Writing a Renewal Monitoring Script
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ssl-step-monitor-script', 'ssl-certbot-letsencrypt', 'monitor-script',
'Writing a Renewal Monitoring Script',
'Automatic renewal usually works perfectly — until it does not. A DNS change, a firewall rule, or a Certbot update can silently break renewal. By the time you notice, your certificate has expired and visitors see warnings. A monitoring script checks certificate expiry dates daily and alerts you before it is too late.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-mon-1', 'ssl-step-monitor-script',
'Certificate Expiry Check',
'You can check a live certificate''s expiry date using openssl s_client without any special tools. By parsing the "notAfter" date and comparing it to today, a script can determine exactly how many days remain and alert you if the number drops below a threshold (e.g. 14 days).',
0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ssl-in-mon-1', 'ssl-step-monitor-script',
'You will write a bash script that checks the expiry date of each certificate on the server, calculates days remaining, and sends an email alert if any certificate is within 14 days of expiry.',
NULL,
'Run this script daily via cron. If Certbot renewal is working correctly, you should never receive an alert. But when you do receive one, it means renewal is broken and you have 14 days to fix it.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ssl-in-mon-2', 'ssl-step-monitor-script',
'Check a certificate''s expiry date from the command line. This is the core logic your monitoring script will use.',
'echo | openssl s_client -connect yourdomain.com:443 -servername yourdomain.com 2>/dev/null | openssl x509 -noout -enddate',
'The output will look like: notAfter=Sep 15 12:00:00 2026 GMT. Your script will parse this date and compare it to today.',
NULL, 1);

-- ============================================================
-- STEP 8: Hardening Your TLS Configuration
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ssl-step-tls-hardening', 'ssl-certbot-letsencrypt', 'tls-hardening',
'Hardening Your TLS Configuration',
'Having a certificate is step one — configuring it securely is step two. Default Nginx TLS settings often allow outdated protocols and weak cipher suites. You will configure Nginx to use only TLS 1.2 and 1.3, prefer strong cipher suites, enable HSTS, and set up OCSP stapling. The goal is an A+ rating on SSL Labs.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-tls-1', 'ssl-step-tls-hardening',
'HSTS',
'HTTP Strict Transport Security is a response header that tells browsers to always use HTTPS for your domain, even if the user types http://. Once a browser receives an HSTS header, it will refuse to connect over plain HTTP for the specified duration (typically one year). This prevents SSL stripping attacks.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-tls-2', 'ssl-step-tls-hardening',
'OCSP Stapling',
'Online Certificate Status Protocol stapling allows your server to include a timestamped, CA-signed proof that its certificate has not been revoked. Without stapling, the browser must contact the CA directly to check revocation status, adding latency and a privacy leak. Stapling is faster and more private.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ssl-ii-tls-3', 'ssl-step-tls-hardening',
'Cipher Suite',
'A cipher suite is a combination of algorithms used for key exchange, encryption, and message authentication during a TLS connection. Strong suites use ECDHE for key exchange (forward secrecy), AES-256-GCM for encryption, and SHA-384 for integrity. Weak or deprecated suites should be disabled.',
2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ssl-in-tls-1', 'ssl-step-tls-hardening',
'Configure Nginx to disable TLS 1.0 and 1.1, set strong cipher suites, enable HSTS with a one-year max-age, and enable OCSP stapling.',
NULL,
'After making changes, test your configuration at ssllabs.com/ssltest. Aim for an A+ rating. Common issues that prevent A+: missing HSTS header, TLS 1.0/1.1 still enabled, or weak cipher suites in the list.',
NULL, 0);

-- ============================================================
-- Page entries: one per step, ordered sequentially
-- ============================================================
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required) VALUES
('ssl-pe-intro',          'ssl-certbot-letsencrypt', 'DIRECT', 0, 'ssl-step-intro',          NULL, NULL, NULL, NULL),
('ssl-pe-how-it-works',   'ssl-certbot-letsencrypt', 'DIRECT', 1, 'ssl-step-how-it-works',   NULL, NULL, NULL, NULL),
('ssl-pe-certbot',        'ssl-certbot-letsencrypt', 'DIRECT', 2, 'ssl-step-certbot-install', NULL, NULL, NULL, NULL),
('ssl-pe-first-cert',     'ssl-certbot-letsencrypt', 'DIRECT', 3, 'ssl-step-first-cert',     NULL, NULL, NULL, NULL),
('ssl-pe-request-script', 'ssl-certbot-letsencrypt', 'DIRECT', 4, 'ssl-step-request-script',  NULL, NULL, NULL, NULL),
('ssl-pe-renewal',        'ssl-certbot-letsencrypt', 'DIRECT', 5, 'ssl-step-renewal',         NULL, NULL, NULL, NULL),
('ssl-pe-monitor-script', 'ssl-certbot-letsencrypt', 'DIRECT', 6, 'ssl-step-monitor-script',  NULL, NULL, NULL, NULL),
('ssl-pe-tls-hardening',  'ssl-certbot-letsencrypt', 'DIRECT', 7, 'ssl-step-tls-hardening',   NULL, NULL, NULL, NULL);
