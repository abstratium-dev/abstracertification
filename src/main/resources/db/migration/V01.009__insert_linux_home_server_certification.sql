-- Insert Linux Home Server certification data
-- Certification
INSERT INTO T_certification (id, title, description, created_at, updated_at)
VALUES ('linux-home-server', 'Linux Home Server Setup', 'Build your own internet-connected server at home. Access it from anywhere in the world using your own domain name, connect securely via SSH, and protect it with a firewall so even if someone breaches your home network, their access is severely limited. No cloud provider, no monthly fees — just your hardware, your rules, full control.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Steps
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('9b67ca79-603b-4d2d-8bdb-af8bef07b388', 'linux-home-server', 'intro', 'Welcome to Your Home Server Journey', 'Imagine having your own piece of the internet — a server that lives in your home, runs exactly what you want, and is accessible from anywhere in the world using your own domain name. This guide will walk you through building that reality: a secure Linux server that you can reach remotely via SSH, protected by a firewall so that even if someone gained access to your home network, they would be severely limited in what they can do. You will learn to install Ubuntu Server, add SSH for secure remote management, configure Nginx as your web server, lock down access with UFW firewall, configure your router for external access, and set up dynamic DNS so your server is always reachable by name. By the end, you will have a production-ready server that is yours alone — no cloud provider, no monthly fees, full control.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('dab542a6-77df-4032-b273-d9f7fa027993', 'linux-home-server', 'install-linux-from-windows', 'Installing Linux — Starting from Windows (Rufus)', 'If your current machine runs Windows, Rufus is the easiest and most reliable tool for creating a bootable Linux USB drive. Rufus is free, fast, and handles UEFI/GPT setups automatically, which is important for modern hardware. It also verifies the ISO checksum to ensure the download is not corrupted.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 'linux-home-server', 'install-linux-from-linux', 'Installing Linux — Starting from Linux (dd)', 'If your current machine already runs Linux, the dd command is the most straightforward way to create a bootable USB drive. It copies the ISO image byte-by-byte to the device, producing a perfect bootable copy. No additional software is needed — dd is included in every Linux distribution.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('a1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e', 'linux-home-server', 'ssh-connect-windows', 'Connecting to the Server from Windows — PuTTY & WinSCP', 'Now that you have configured the SSH daemon on the server, you need to connect to it from your Windows machine. PuTTY is a well-established, free SSH client for Windows. WinSCP is a graphical file transfer client that integrates with PuTTY and lets you browse, upload, and download files over SFTP using a familiar drag-and-drop interface.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('b2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', 'linux-home-server', 'ssh-connect-linux', 'Connecting to the Server Using SSH — From Linux', 'Now that you have configured the SSH daemon on the server, you need to connect to it from your local machine. On Linux, the OpenSSH client is typically pre-installed or available via your package manager. You will also learn to use SCP (Secure Copy Protocol) to transfer files between your local machine and the server — essential for deploying configuration files, web content, and backups.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('4b4023e4-e123-42fe-8fb9-154cb11d2833', 'linux-home-server', 'install-nginx', 'Installing and Configuring Nginx', 'Nginx is a high-performance web server and reverse proxy. On your home server, it will serve web pages and can act as a gateway to other services you run. Nginx is known for its low memory footprint and ability to handle many concurrent connections, making it ideal for a home server with limited resources.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('05782de5-0676-48bc-825e-a126969086bb', 'linux-home-server', 'configure-ufw', 'Setting Up UFW (Uncomplicated Firewall)', 'A firewall is essential for securing your server. UFW (Uncomplicated Firewall) is a user-friendly front-end for iptables that makes it easy to manage firewall rules. Without a properly configured firewall, your server is exposed to every type of network attack. UFW lets you explicitly allow only the traffic you need, blocking everything else.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ec4bcbdd-dabc-4c76-a967-470c14e8adc4', 'linux-home-server', 'configure-sshd', 'Configuring the SSH Daemon (sshd)', 'SSH (Secure Shell) is the primary way you will remotely manage your server. Properly configuring sshd is critical for security. The default configuration works, but hardening it — disabling root login, and changing the default port — makes your server more resistant to brute-force attacks and unauthorized access.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ff7f23e8-1c03-467a-a1da-7abfa901bacf', 'linux-home-server', 'port-forwarding', 'Setting Up Port Forwarding on Your Router', 'Your home server sits behind your router, which uses NAT (Network Address Translation) to share one public IP address among all devices on your network. By default, incoming connections from the internet cannot reach your server. Port forwarding tells your router to direct traffic on specific ports to your server''s internal IP address, making your services accessible from outside your local network.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('6d688465-40a8-4de1-b60c-7794b07492a5', 'linux-home-server', 'dynamic-dns', 'Setting Up Dynamic DNS with No-IP', 'Most home internet connections have a dynamic IP address that changes periodically. This means the IP address you use to access your server from the internet may stop working after your ISP assigns you a new one. Dynamic DNS (DDNS) solves this by mapping a hostname (like myserver.ddns.net) to your current IP address and automatically updating it whenever it changes. No-IP is a popular free DDNS provider.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Info items for intro step
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('2871f729-93c7-43c1-b1c9-a4d0bb24051e', '9b67ca79-603b-4d2d-8bdb-af8bef07b388', 'SSH', 'Secure Shell (SSH) is a network protocol that lets you log in to and control a remote computer over an encrypted connection. Instead of sitting at the server physically, you type commands on your local machine and they are securely tunnelled to the server. Authentication can be done with a password or, more securely, with a cryptographic key pair.', 0);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('98797eb4-fa2b-43f3-a0ca-00584e44fd05', '9b67ca79-603b-4d2d-8bdb-af8bef07b388', 'Firewall & UFW', 'A firewall controls which network connections are allowed to reach your server. It acts as a gatekeeper — blocking uninvited traffic while letting through only the ports and protocols you explicitly permit. UFW (Uncomplicated Firewall) is a user-friendly front-end for Linux''s built-in iptables firewall, letting you write rules in plain English such as ''allow SSH on port 22'' rather than cryptic iptables syntax.', 1);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('b7ddf1d8-0e86-4a0f-a716-e1f32a816ac0', '9b67ca79-603b-4d2d-8bdb-af8bef07b388', 'DNS', 'Domain Name System (DNS) translates human-readable names (like myserver.ddns.net) into the numeric IP addresses that computers use to communicate. Without DNS you would have to remember and type your server''s raw IP address every time — and if your home ISP changes that address, every bookmark would break. Dynamic DNS (DDNS) services automatically update your hostname whenever your IP changes.', 2);

-- Instructions for intro step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('2f07e676-af91-4263-be6a-7c2dc555317d', '9b67ca79-603b-4d2d-8bdb-af8bef07b388', 'This is what you will build — a secure home network with your own internet-accessible server:', NULL, 'WAN (Wide Area Network) is the public-facing side of your router — the IP address your Internet Service Provider assigns to you, visible from the internet. LAN (Local Area Network) is your private home network — devices on it get addresses in the 192.168.x.x range. When you access your server from outside your home, traffic arrives at the router''s WAN address and is forwarded to the server''s LAN address. When you access it from inside your home, you use the server''s LAN address directly.', 'graph TB\n    subgraph Internet ["Internet"]\n        internetUser([Internet User])\n    end\n\n    subgraph HomeNetwork ["Home Network"]\n        desktopUser([Desktop User])\n        desktop["Desktop/Laptop<br/>192.168.1.x<br/>Browse Web on port 80<br/>SSH Connect on port 2222"]\n        router["Router<br/>WAN: 203.0.113.45<br/>LAN: 192.168.1.1<br/>Port Forwarding: 80 and 2222"]\n        server["Linux Server<br/>192.168.1.y<br/>Serve Websites on port 80<br/>Accept SSH on port 2222<br/>UFW Firewall"]\n    end\n\n    internetUser -->|"Access Website (port 80)"| router\n    internetUser -->|"SSH Remote Mgmt (port 2222)"| router\n    router -->|"Forward port 80"| server\n    router -->|"Forward port 2222"| server\n    desktopUser --> desktop\n    desktop -->|"SSH Admin (port 2222)"| server\n    desktop -->|"View Website (port 80)"| server', 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('41e9326f-ffb4-4a4f-af98-f5ec998225c0', '9b67ca79-603b-4d2d-8bdb-af8bef07b388', 'This certification is designed to be completed hands-on. You will need: a spare computer or Raspberry Pi to act as your server, a USB drive (4GB+), and access to your home router''s admin interface.', NULL, NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('20f0b01a-08d3-4775-8a9b-dfeb28fd9b1a', '9b67ca79-603b-4d2d-8bdb-af8bef07b388', 'The process is broken into logical steps. Each step explains WHY you are doing something, WHAT you need to do (with exact commands), and ends with a few questions to verify your understanding.', NULL, NULL, NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('bd0e2c1c-a61d-4f20-9b35-48a33e3311cf', '9b67ca79-603b-4d2d-8bdb-af8bef07b388', 'Security is layered: the firewall blocks unwanted traffic at the network level, SSH prevents running as a non-root user to limit damage if somehow compromised.', NULL, NULL, NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('7deee750-3965-4503-b7ff-aaf61412094b', '9b67ca79-603b-4d2d-8bdb-af8bef07b388', 'Dynamic DNS solves the problem of changing home IP addresses. Instead of memorizing numbers like 203.0.113.45, you will access your server via a name like myserver.ddns.net — and it automatically stays updated when your ISP changes your IP.', NULL, NULL, NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('d41f4243-009d-4260-8de6-985dc912282f', '9b67ca79-603b-4d2d-8bdb-af8bef07b388', 'Click ''Next'' to begin with the first decision: how you will create your bootable USB installation media.', NULL, NULL, NULL, 5);

-- Instructions for install-windows step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('3e6fda91-6e8a-4b3a-9c1e-4a2b5c6d7e8f', 'dab542a6-77df-4032-b273-d9f7fa027993', 'Download the Ubuntu Server ISO from the official website (https://ubuntu.com/download/server). Choose the latest LTS version for stability.', NULL, NULL, NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('7a1b2c3d-4e5f-6a7b-8c9d-0e1f2a3b4c5d', 'dab542a6-77df-4032-b273-d9f7fa027993', 'Download Rufus from https://rufus.ie/. You can use the portable version — no installation required.', NULL, NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('8b2c3d4e-5f6a-7b8c-9d0e-1f2a3b4c5d6e', 'dab542a6-77df-4032-b273-d9f7fa027993', 'Insert a USB drive (at least 4 GB) into your Windows machine. WARNING: All data on this USB drive will be erased.', NULL, NULL, NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('9c3d4e5f-6a7b-8c9d-0e1f-2a3b4c5d6e7f', 'dab542a6-77df-4032-b273-d9f7fa027993', 'Open Rufus. It will automatically detect your USB drive. Under ''Boot selection'', click ''SELECT'' and browse to the Ubuntu Server ISO file you downloaded.', NULL, NULL, NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('0d4e5f6a-7b8c-9d0e-1f2a-3b4c5d6e7f8a', 'dab542a6-77df-4032-b273-d9f7fa027993', 'Leave the partition scheme as ''GPT'' and target system as ''UEFI (non CSM)'' for modern hardware. If your server uses legacy BIOS, choose ''MBR'' instead.', NULL, 'Most hardware from the last 10 years supports UEFI. Check your server''s BIOS settings if unsure.', NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('1e5f6a7b-8c9d-0e1f-2a3b-4c5d6e7f8a9b', 'dab542a6-77df-4032-b273-d9f7fa027993', 'Click ''START''. Rufus may ask to download additional files — allow it. Confirm the warning about destroying data on the USB drive.', NULL, NULL, NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('2f6a7b8c-9d0e-1f2a-3b4c-5d6e7f8a9b0c', 'dab542a6-77df-4032-b273-d9f7fa027993', 'Wait for Rufus to finish writing the ISO. When it shows ''READY'', close Rufus and safely eject the USB drive.', NULL, NULL, NULL, 6);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('3a7b8c9d-0e1f-2a3b-4c5d-6e7f8a9b0c1d', 'dab542a6-77df-4032-b273-d9f7fa027993', 'Insert the USB drive into your home server and boot from it. You may need to change the boot order in your BIOS/UEFI settings (usually accessed by pressing F2, F12, DEL, or ESC during boot).', NULL, NULL, NULL, 7);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('4b8c9d0e-1f2a-3b4c-5d6e-7f8a9b0c1d2e', 'dab542a6-77df-4032-b273-d9f7fa027993', 'Follow the Ubuntu Server installer. Choose your language, keyboard layout, and network configuration. For the disk setup, using the entire disk with LVM is recommended for flexibility.', NULL, NULL, NULL, 8);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('5c9d0e1f-2a3b-4c5d-6e7f-8a9b0c1d2e3f', 'dab542a6-77df-4032-b273-d9f7fa027993', 'Create your user account and set a strong password. Enable OpenSSH server when prompted — we will configure it further later.', NULL, NULL, NULL, 9);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('6d0e1f2a-3b4c-5d6e-7f8a-9b0c1d2e3f4a', 'dab542a6-77df-4032-b273-d9f7fa027993', 'After installation completes, remove the USB drive and reboot. Log in with the credentials you created.', NULL, NULL, NULL, 10);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('f601c899-95a9-416c-b173-741d9feeb95c', 'dab542a6-77df-4032-b273-d9f7fa027993', 'Update the system to ensure all packages are current.', 'sudo apt update && sudo apt upgrade -y', 'sudo runs the command as an administrator. apt is the package manager used on Ubuntu and Debian-based systems. update refreshes the local list of available packages and their versions from the internet — it does not install anything. upgrade then downloads and installs newer versions of all packages already installed on the system. -y automatically answers yes to any confirmation prompts so the process runs without interruption.', NULL, 11);

-- Instructions for install-linux step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ede577b0-43d3-4b87-8ff6-2370bd0f8306', 'f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 'Download the Ubuntu Server ISO from the official website (https://ubuntu.com/download/server). Choose the latest LTS version for stability.', NULL, NULL, NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('3bb8717d-1dde-41bf-a464-f80e14c01e37', 'f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 'Insert a USB drive (at least 4 GB) into your Linux machine. WARNING: All data on this USB drive will be erased.', NULL, NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('b24764db-430e-4dba-ae43-6076b74ad60b', 'f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 'Identify your USB device. CRITICAL: If you select the wrong device you could permanently destroy all your data or wipe your operating system! To safely identify the USB drive, run lsblk BEFORE inserting the USB drive and note the devices listed. Then insert the USB drive and run lsblk again — the new device that appears is your USB drive.', 'lsblk', 'Compare the output before and after inserting the USB drive. The device that newly appears is your USB drive — it is typically /dev/sdb or /dev/sdc. Never use /dev/sda if that is your system disk. Double-check the size matches your USB drive before proceeding.', NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('96f78fb8-b3c6-44a4-9455-701b10482c3d', 'f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 'Unmount the USB drive if it was auto-mounted.', 'sudo umount /dev/sdX*', 'Replace /dev/sdX with your actual USB device (e.g. /dev/sdb).', NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('b1bff31c-a791-4668-a6a1-76111763798c', 'f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 'Write the ISO image to the USB drive using dd.', 'sudo dd if=ubuntu-24.04-live-server-amd64.iso of=/dev/sdX bs=4M status=progress conv=fsync', 'Replace /dev/sdX with your actual USB device identifier (e.g. /dev/sdb). Replace ubuntu-24.04-live-server-amd64.iso with the actual ISO file name that you downloaded. Arguments: if= is the input file (the ISO image to write); of= is the output file (your USB device); bs=4M sets the block size to 4 megabytes for faster writing; status=progress shows live transfer progress; conv=fsync ensures all data is fully flushed to the physical drive before dd exits. This will take a few minutes.', NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('069829d5-816a-4552-9828-ed6bc07d053a', 'f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 'Verify the write completed successfully. The dd command will output the number of bytes written.', 'sync', NULL, NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('2a4b86de-febc-4028-8b25-6d86672e5398', 'f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 'Safely remove the USB drive.', 'sudo eject /dev/sdX', NULL, NULL, 6);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('bc444bb2-0733-4d80-8e83-e0e4cf58201b', 'f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 'Insert the USB drive into your home server and boot from it. You may need to change the boot order in your BIOS/UEFI settings (usually accessed by pressing F2, F12, DEL, or ESC during boot).', NULL, NULL, NULL, 7);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('99baa72a-2ba5-4aa6-a857-21bb54b2e14c', 'f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 'Follow the Ubuntu Server installer. Choose your language, keyboard layout, and network configuration. For the disk setup, using the entire disk with LVM is recommended for flexibility.', NULL, NULL, NULL, 8);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('b822a217-0469-412b-a0b2-18a5459e0310', 'f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 'Create your user account and set a strong password. Enable OpenSSH server when prompted — we will configure it further later.', NULL, NULL, NULL, 9);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('63859fa1-aafe-4ba8-90d0-8086f9441e3e', 'f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 'After installation completes, remove the USB drive and reboot. Log in with the credentials you created.', NULL, NULL, NULL, 10);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('00f6169e-b617-4dea-b6c8-7af3a6bad46b', 'f6676877-8b20-4558-9b3b-91c6ffa7e1d6', 'Update the system to ensure all packages are current.', 'sudo apt update && sudo apt upgrade -y', 'sudo runs the command as an administrator. apt is the package manager used on Ubuntu and Debian-based systems. update refreshes the local list of available packages and their versions from the internet — it does not install anything. upgrade then downloads and installs newer versions of all packages already installed on the system. -y automatically answers yes to any confirmation prompts so the process runs without interruption.', NULL, 11);
