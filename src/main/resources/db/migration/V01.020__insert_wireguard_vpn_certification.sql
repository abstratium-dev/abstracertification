-- Insert "WireGuard VPN — Secure Peer-to-Peer Networking" as a coming-soon certification

INSERT INTO T_certification (id, title, description, coming_soon, sequence_order, created_at, updated_at)
VALUES ('wireguard-vpn', 'WireGuard VPN — Secure Peer-to-Peer Networking',
'Connect to your home network from anywhere in the world, or build a company VPN that restricts access to internal tools and files. Learn to configure WireGuard peers, manage cryptographic keys, route traffic securely, and set up split tunnelling — all with a protocol that is faster and simpler than traditional VPNs.',
TRUE, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ============================================================
-- STEP 1: Introduction
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('wg-step-intro', 'wireguard-vpn', 'intro',
'Welcome to WireGuard VPN',
'Traditional VPNs like OpenVPN and IPsec are complex to configure, slow to connect, and have massive codebases that are difficult to audit for security flaws. WireGuard is a modern VPN protocol built into the Linux kernel — it has roughly 4,000 lines of code compared to OpenVPN''s 100,000+, connects in milliseconds, and uses state-of-the-art cryptography. This certification teaches you to set up WireGuard for two real-world scenarios: secure remote access to your home network, and a company VPN for an SME.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-intro-1', 'wg-step-intro',
'WireGuard',
'WireGuard is a modern VPN protocol that runs inside the Linux kernel. It uses Curve25519 for key exchange, ChaCha20 for encryption, and Poly1305 for authentication — all considered best-in-class. Unlike OpenVPN, there are no cipher negotiations or complex handshakes. Each peer has a public/private key pair, and configuration is a simple text file.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-intro-2', 'wg-step-intro',
'Peer-to-Peer Architecture',
'WireGuard does not have a strict client/server model. Every node is a "peer" with equal capabilities. However, in practice you typically designate one peer as the "server" (always on, with a public IP) and others as "clients" that connect to it. This flexibility means the same configuration concepts apply whether you are building a home VPN or a corporate network.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-intro-3', 'wg-step-intro',
'VPN Tunnel',
'A VPN tunnel is an encrypted point-to-point connection between two peers. All traffic sent through the tunnel is encrypted before it leaves the sender and decrypted when it arrives at the receiver. Anyone intercepting the traffic in between sees only encrypted gibberish. WireGuard creates a virtual network interface (e.g. wg0) that handles this transparently.',
2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('wg-in-intro-1', 'wg-step-intro',
'Here is how WireGuard connects peers — whether for home access or a company VPN:',
NULL, NULL,
'graph LR
    subgraph Home ["Home Network / Office"]
        server["WireGuard Server<br/>Always On<br/>Public IP or DDNS"]
        nas["NAS / File Server"]
        app["Internal Apps"]
        server --- nas
        server --- app
    end

    subgraph Remote ["Remote Locations"]
        laptop["Laptop<br/>WireGuard Client"]
        phone["Phone<br/>WireGuard Client"]
        employee["Employee Device<br/>WireGuard Client"]
    end

    laptop -->|"Encrypted Tunnel"| server
    phone -->|"Encrypted Tunnel"| server
    employee -->|"Encrypted Tunnel"| server',
0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('wg-in-intro-2', 'wg-step-intro',
'This certification covers two use cases: connecting to your home network when you are away (accessing files, managing your server, using home services), and setting up a VPN for a small or medium business so that employees can only access internal tools when connected to the VPN.',
NULL, NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('wg-in-intro-3', 'wg-step-intro',
'This certification is coming soon. The pages ahead show what you will learn — check back later for the full content!',
NULL, NULL, NULL, 2);

-- ============================================================
-- STEP 2: How WireGuard Works
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('wg-step-how', 'wireguard-vpn', 'how-wireguard-works',
'How WireGuard Works',
'Before configuring anything, you need to understand the cryptographic primitives WireGuard uses, how peers discover and authenticate each other, and how the Cryptokey Routing table determines where traffic goes. This knowledge will help you debug connection issues and design network topologies.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-how-1', 'wg-step-how',
'Cryptokey Routing',
'WireGuard''s core concept: each peer has a public key and a list of allowed IP ranges. When a packet arrives on the WireGuard interface, the destination IP is checked against each peer''s allowed IPs to determine which peer to encrypt and send it to. When an encrypted packet arrives, the sender''s public key determines which peer it came from, and the source IP is checked against that peer''s allowed IPs.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-how-2', 'wg-step-how',
'Noise Protocol Framework',
'WireGuard uses the Noise protocol framework for its handshake, specifically the Noise_IKpsk2 pattern. This provides mutual authentication, forward secrecy, and identity hiding in just 1 round trip (1-RTT). The handshake happens silently in the background — there is no connection state, login, or disconnection event.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-how-3', 'wg-step-how',
'Roaming',
'WireGuard peers can change IP addresses seamlessly. If your phone switches from WiFi to mobile data, the WireGuard tunnel re-establishes automatically because authentication is based on cryptographic keys, not IP addresses. The server simply updates its record of where the peer is.',
2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('wg-in-how-1', 'wg-step-how',
'WireGuard operates at the network layer (Layer 3) and creates a virtual network interface. All traffic routed through this interface is encrypted. The kernel module handles encryption at line speed with minimal CPU overhead.',
NULL,
'WireGuard is significantly faster than OpenVPN because it runs in kernel space instead of user space, and uses modern AEAD ciphers that are hardware-accelerated on most CPUs.',
NULL, 0);

-- ============================================================
-- STEP 3: Key Generation and Management
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('wg-step-keys', 'wireguard-vpn', 'key-management',
'Key Generation and Management',
'Every WireGuard peer needs a public/private key pair. The private key must be kept secret and the public key is shared with peers that need to communicate with it. Proper key management is essential — a leaked private key compromises the entire tunnel. You will learn to generate, store, and distribute keys securely.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-keys-1', 'wg-step-keys',
'Curve25519',
'WireGuard uses Curve25519 for key exchange, an elliptic curve that provides 128 bits of security. Keys are 32 bytes (256 bits) and are typically represented as base64 strings. Unlike RSA keys that are thousands of bits, Curve25519 keys are compact and fast to generate.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-keys-2', 'wg-step-keys',
'Pre-Shared Key (PSK)',
'An optional pre-shared key adds a second layer of symmetric encryption to the tunnel. Even if an attacker breaks Curve25519 (e.g. with a future quantum computer), the PSK layer remains secure. For high-security deployments, always use a PSK in addition to the public key pair.',
1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('wg-in-keys-1', 'wg-step-keys',
'Generate a private key, derive the public key from it, and optionally generate a pre-shared key for the tunnel.',
'wg genkey | tee privatekey | wg pubkey > publickey && wg genpsk > presharedkey',
'Private keys should have restricted permissions (chmod 600) and never be transmitted over insecure channels. Share only the public key with peers.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('wg-in-keys-2', 'wg-step-keys',
'For an SME deployment with multiple employees, you will develop a script that generates a key pair per user and produces a ready-to-use configuration file they can import into the WireGuard app on their device.',
NULL,
'Never reuse key pairs across devices. Each device (laptop, phone, tablet) should have its own key pair and its own allowed IP address for audit and revocation purposes.',
NULL, 1);

-- ============================================================
-- STEP 4: Server Configuration
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('wg-step-server', 'wireguard-vpn', 'server-config',
'Configuring the WireGuard Server',
'The server peer is the always-on node with a public IP (or dynamic DNS) that all clients connect to. Its configuration defines the VPN subnet, the listening port, and the list of allowed client peers. Getting the server right is the foundation — every client depends on it.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-srv-1', 'wg-step-server',
'VPN Subnet',
'The VPN subnet is a private IP range used exclusively for WireGuard peers. Common choices are 10.0.0.0/24 or 10.10.0.0/24. The server gets the first address (e.g. 10.0.0.1) and each client gets a unique address in the range. This subnet must not overlap with your existing LAN subnet.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-srv-2', 'wg-step-server',
'PostUp / PostDown',
'PostUp and PostDown are hooks in the WireGuard config that run shell commands when the interface comes up or goes down. They are typically used to set up NAT (masquerading) so VPN clients can access the server''s LAN, and to add or remove firewall rules.',
1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('wg-in-srv-1', 'wg-step-server',
'Install WireGuard and create the server configuration file with the private key, VPN subnet address, listening port, and NAT rules.',
'sudo apt install wireguard',
'WireGuard is included in the Linux kernel since version 5.6. On older kernels, the wireguard package installs the kernel module as well.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('wg-in-srv-2', 'wg-step-server',
'Enable IP forwarding so the server can route traffic between VPN clients and the LAN. Without this, clients can reach the server but not anything behind it.',
'echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf && sudo sysctl -p',
'For an SME VPN, you may want to restrict forwarding to specific subnets using iptables rules in the PostUp hook, so VPN users can only access designated internal services.',
NULL, 1);

-- ============================================================
-- STEP 5: Client Configuration
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('wg-step-client', 'wireguard-vpn', 'client-config',
'Configuring WireGuard Clients',
'Each device that connects to the VPN needs a client configuration with its own key pair, a VPN IP address, and the server''s public key and endpoint. WireGuard clients are available for Linux, macOS, Windows, iOS, and Android. You will learn to create configurations for each platform and distribute them securely.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-cli-1', 'wg-step-client',
'AllowedIPs',
'The AllowedIPs field in the client config controls which traffic goes through the VPN. Setting it to 0.0.0.0/0 routes all traffic through the tunnel (full tunnel). Setting it to the server''s LAN range (e.g. 192.168.1.0/24, 10.0.0.0/24) routes only LAN traffic through the tunnel (split tunnel), keeping internet traffic direct.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-cli-2', 'wg-step-client',
'QR Code Provisioning',
'For mobile devices, WireGuard configurations can be converted to QR codes that the mobile app scans directly. This is faster and more secure than sending configuration files over email or messaging apps.',
1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('wg-in-cli-1', 'wg-step-client',
'Create a client configuration file with the client''s private key, VPN IP address, DNS server, and the server''s public key and endpoint.',
NULL,
'Set the DNS field to your server''s LAN IP if it runs a local DNS resolver, or to a public resolver like 1.1.1.1. This ensures DNS queries also go through the tunnel when using a full tunnel configuration.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('wg-in-cli-2', 'wg-step-client',
'Generate a QR code from a configuration file for easy mobile provisioning.',
'qrencode -t ansiutf8 < client.conf',
'Install qrencode with: sudo apt install qrencode. Display the QR code in the terminal and scan it with the WireGuard mobile app.',
NULL, 1);

-- ============================================================
-- STEP 6: Split Tunnelling and Routing
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('wg-step-routing', 'wireguard-vpn', 'split-tunnelling',
'Split Tunnelling and Routing',
'Not all traffic needs to go through the VPN. For home use, you typically only want to access your home LAN — internet traffic should go direct for speed. For an SME, you might route only traffic to internal servers through the VPN. Split tunnelling gives you this control, but misconfiguring it can leak traffic or break connectivity.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-rt-1', 'wg-step-routing',
'Split Tunnel vs Full Tunnel',
'A full tunnel (AllowedIPs = 0.0.0.0/0) sends all traffic through the VPN — maximum privacy but slower internet speeds and higher server bandwidth usage. A split tunnel (AllowedIPs = specific subnets) only sends traffic destined for specific networks through the VPN — faster internet but less private.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-rt-2', 'wg-step-routing',
'DNS Leaks',
'With a split tunnel, DNS queries may bypass the VPN and go to your local DNS resolver, revealing which internal hostnames you are accessing. To prevent DNS leaks, configure the VPN client to use a DNS server that is reachable only through the tunnel.',
1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('wg-in-rt-1', 'wg-step-routing',
'Configure split tunnelling by setting AllowedIPs to only include your home/office LAN subnets and the VPN subnet. This keeps internet traffic fast while giving you secure access to internal resources.',
NULL,
'For an SME deployment, you might allow 10.0.0.0/24 (VPN subnet) and 192.168.1.0/24 (office LAN) but not 0.0.0.0/0. This means employees can access internal tools over VPN but their web browsing stays on their local connection.',
NULL, 0);

-- ============================================================
-- STEP 7: SME Deployment — Access Control
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('wg-step-sme', 'wireguard-vpn', 'sme-access-control',
'SME Deployment — Access Control and User Management',
'For a business VPN, you need more than just connectivity. You need to control which users can access which internal services, add and revoke users without restarting the VPN, and audit who is connected. This page covers firewall rules per peer, user provisioning scripts, and monitoring connected peers.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-sme-1', 'wg-step-sme',
'Per-Peer Firewall Rules',
'Since each WireGuard peer has a unique VPN IP, you can create iptables rules that restrict specific peers to specific internal services. For example, the accounting team might only access the ERP server, while developers access the Git server and staging environment. This enforces least-privilege at the network level.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-sme-2', 'wg-step-sme',
'Peer Revocation',
'To revoke a user''s VPN access, remove their [Peer] section from the server config and reload WireGuard. Unlike certificate-based VPNs, there is no revocation list to manage. The user''s key simply stops being accepted. For large deployments, a management script automates this.',
1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('wg-in-sme-1', 'wg-step-sme',
'You will write a user management script that adds a new VPN user: generates their key pair, assigns the next available VPN IP, adds their peer to the server config, generates a client config file, and produces a QR code — all in one command.',
NULL,
'Store a registry of assigned IPs and public keys so the script can prevent conflicts and support revocation. A simple CSV or JSON file works well for small deployments.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('wg-in-sme-2', 'wg-step-sme',
'Monitor connected peers and their last handshake time. Peers that have not performed a handshake in over 2 minutes are likely disconnected.',
'sudo wg show',
'The output shows each peer''s public key, endpoint IP, latest handshake time, and data transferred. Use this for auditing and troubleshooting.',
NULL, 1);

-- ============================================================
-- STEP 8: Troubleshooting and Security Best Practices
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('wg-step-security', 'wireguard-vpn', 'troubleshooting-security',
'Troubleshooting and Security Best Practices',
'WireGuard is silent by design — when something is wrong, it simply does not work, with no error messages. This makes troubleshooting different from other VPNs. You will learn systematic debugging techniques and security best practices to keep your VPN secure over time.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-sec-1', 'wg-step-security',
'Silent Drops',
'WireGuard silently drops any packet that does not authenticate. This is a security feature (it makes the server invisible to port scanners) but also means misconfigured peers get no error feedback. If a tunnel is not working, the debugging process involves verifying keys, allowed IPs, endpoints, and firewall rules systematically.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('wg-ii-sec-2', 'wg-step-security',
'Key Rotation',
'While WireGuard''s session keys rotate automatically every 2 minutes, the long-term peer keys do not. For high-security environments, you should periodically rotate peer keys — especially when an employee leaves. A rotation script generates new keys, updates all affected configs, and distributes new client configs.',
1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('wg-in-sec-1', 'wg-step-security',
'Systematic troubleshooting checklist: verify both peers have each other''s correct public key, check that AllowedIPs match on both sides, confirm the endpoint is reachable, verify the firewall allows UDP on the WireGuard port, and check that IP forwarding is enabled.',
NULL,
'The most common mistake is mismatched keys — copying the wrong key to the wrong peer. Always double-check by comparing the output of wg show on both sides.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('wg-in-sec-2', 'wg-step-security',
'Restrict the WireGuard configuration file permissions so only root can read the private key, and integrate WireGuard with your firewall to limit access to the VPN port.',
'sudo chmod 600 /etc/wireguard/wg0.conf',
'Combine WireGuard with fail2ban by monitoring kernel logs for repeated handshake failures from the same IP, indicating a brute-force attempt against your VPN endpoint.',
NULL, 1);

-- ============================================================
-- Page entries
-- ============================================================
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required) VALUES
('wg-pe-intro',    'wireguard-vpn', 'DIRECT', 0, 'wg-step-intro',    NULL, NULL, NULL, NULL),
('wg-pe-how',      'wireguard-vpn', 'DIRECT', 1, 'wg-step-how',      NULL, NULL, NULL, NULL),
('wg-pe-keys',     'wireguard-vpn', 'DIRECT', 2, 'wg-step-keys',     NULL, NULL, NULL, NULL),
('wg-pe-server',   'wireguard-vpn', 'DIRECT', 3, 'wg-step-server',   NULL, NULL, NULL, NULL),
('wg-pe-client',   'wireguard-vpn', 'DIRECT', 4, 'wg-step-client',   NULL, NULL, NULL, NULL),
('wg-pe-routing',  'wireguard-vpn', 'DIRECT', 5, 'wg-step-routing',  NULL, NULL, NULL, NULL),
('wg-pe-sme',      'wireguard-vpn', 'DIRECT', 6, 'wg-step-sme',      NULL, NULL, NULL, NULL),
('wg-pe-security', 'wireguard-vpn', 'DIRECT', 7, 'wg-step-security', NULL, NULL, NULL, NULL);
