-- Insert Linux Home Server certification data
-- Certification
INSERT INTO T_certification (id, title, description, created_at, updated_at)
VALUES ('linux-home-server', 'Linux Home Server Setup', 'Build your own internet-connected server at home. Access it from anywhere in the world using your own domain name, connect securely via SSH, and protect it with a firewall so even if someone breaches your home network, their access is severely limited. No cloud provider, no monthly fees — just your hardware, your rules, full control.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Steps
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('step-intro', 'linux-home-server', 'intro', 'Welcome to Your Home Server Journey', 'Imagine having your own piece of the internet — a server that lives in your home, runs exactly what you want, and is accessible from anywhere in the world using your own domain name. This guide will walk you through building that reality: a secure Linux server that you can reach remotely via SSH, protected by a firewall so that even if someone gained access to your home network, they would be severely limited in what they can do. You will learn to install Ubuntu Server, configure Nginx as your web server, lock down access with UFW firewall, harden SSH for secure remote management, configure your router for external access, and set up dynamic DNS so your server is always reachable by name. By the end, you will have a production-ready server that is yours alone — no cloud provider, no monthly fees, full control.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('step-install-win', 'linux-home-server', 'install-linux-from-windows', 'Installing Linux — Starting from Windows (Rufus)', 'If your current machine runs Windows, Rufus is the easiest and most reliable tool for creating a bootable Linux USB drive. Rufus is free, fast, and handles UEFI/GPT setups automatically, which is important for modern hardware. It also verifies the ISO checksum to ensure the download is not corrupted.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('step-install-linux', 'linux-home-server', 'install-linux-from-linux', 'Installing Linux — Starting from Linux (dd)', 'If your current machine already runs Linux, the dd command is the most straightforward way to create a bootable USB drive. It copies the ISO image byte-by-byte to the device, producing a perfect bootable copy. No additional software is needed — dd is included in every Linux distribution.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('step-nginx', 'linux-home-server', 'install-nginx', 'Installing and Configuring Nginx', 'Nginx is a high-performance web server and reverse proxy. On your home server, it will serve web pages and can act as a gateway to other services you run. Nginx is known for its low memory footprint and ability to handle many concurrent connections, making it ideal for a home server with limited resources.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('step-ufw', 'linux-home-server', 'configure-ufw', 'Setting Up UFW (Uncomplicated Firewall)', 'A firewall is essential for securing your server. UFW (Uncomplicated Firewall) is a user-friendly front-end for iptables that makes it easy to manage firewall rules. Without a properly configured firewall, your server is exposed to every type of network attack. UFW lets you explicitly allow only the traffic you need, blocking everything else.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('step-sshd', 'linux-home-server', 'configure-sshd', 'Configuring the SSH Daemon (sshd)', 'SSH (Secure Shell) is the primary way you will remotely manage your server. Properly configuring sshd is critical for security. The default configuration works, but hardening it — disabling root login, changing the default port, and using key-based authentication — makes your server significantly more resistant to brute-force attacks and unauthorized access.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('step-portfwd', 'linux-home-server', 'port-forwarding', 'Setting Up Port Forwarding on Your Router', 'Your home server sits behind your router, which uses NAT (Network Address Translation) to share one public IP address among all devices on your network. By default, incoming connections from the internet cannot reach your server. Port forwarding tells your router to direct traffic on specific ports to your server''s internal IP address, making your services accessible from outside your local network.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('step-ddns', 'linux-home-server', 'dynamic-dns', 'Setting Up Dynamic DNS with No-IP', 'Most home internet connections have a dynamic IP address that changes periodically. This means the IP address you use to access your server from the internet may stop working after your ISP assigns you a new one. Dynamic DNS (DDNS) solves this by mapping a hostname (like myserver.ddns.net) to your current IP address and automatically updating it whenever it changes. No-IP is a popular free DDNS provider.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Info items for intro step
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('info-ssh', 'step-intro', 'SSH', 'Secure Shell (SSH) is a network protocol that lets you log in to and control a remote computer over an encrypted connection. Instead of sitting at the server physically, you type commands on your local machine and they are securely tunnelled to the server. Authentication can be done with a password or, more securely, with a cryptographic key pair.', 0);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('info-firewall', 'step-intro', 'Firewall & UFW', 'A firewall controls which network connections are allowed to reach your server. It acts as a gatekeeper — blocking uninvited traffic while letting through only the ports and protocols you explicitly permit. UFW (Uncomplicated Firewall) is a user-friendly front-end for Linux''s built-in iptables firewall, letting you write rules in plain English such as ''allow SSH on port 22'' rather than cryptic iptables syntax.', 1);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('info-dns', 'step-intro', 'DNS', 'Domain Name System (DNS) translates human-readable names (like myserver.ddns.net) into the numeric IP addresses that computers use to communicate. Without DNS you would have to remember and type your server''s raw IP address every time — and if your home ISP changes that address, every bookmark would break. Dynamic DNS (DDNS) services automatically update your hostname whenever your IP changes.', 2);

-- Instructions for intro step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-intro-1', 'step-intro', 'This is what you will build — a secure home network with your own internet-accessible server:', NULL, NULL, 'graph TB\n    subgraph Internet ["Internet"]\n        internetUser([Internet User])\n    end\n\n    subgraph HomeNetwork ["Home Network 192.168.1.x"]\n        desktopUser([Desktop User])\n        desktop[Desktop/Laptop<br/>Browse Web on :80/:443<br/>SSH Connect on :2222]\n        router[Router<br/>Port Forwarding<br/>:80 :443 :2222]\n        server[Linux Server<br/>Serve Websites on :80/:443<br/>Accept SSH on :2222<br/>UFW Firewall]\n    end\n\n    internetUser -->|Access Website| router\n    internetUser -->|SSH Remote Mgmt| router\n    router -->|Forward :80/:443| server\n    router -->|Forward :2222| server\n    desktopUser -->|Configure Server| desktop\n    desktop -->|SSH Admin on :2222| server\n    desktop -->|View Website on :80| server', 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-intro-2', 'step-intro', 'This certification is designed to be completed hands-on. You will need: a spare computer or Raspberry Pi to act as your server, a USB drive (4GB+), and access to your home router''s admin interface.', NULL, NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-intro-3', 'step-intro', 'The process is broken into logical steps. Each step explains WHY you are doing something, WHAT you need to do (with exact commands), and ends with a few questions to verify your understanding.', NULL, NULL, NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-intro-4', 'step-intro', 'Security is layered: the firewall blocks unwanted traffic at the network level, SSH key authentication prevents password-based attacks, and running as a non-root user limits damage if somehow compromised.', NULL, NULL, NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-intro-5', 'step-intro', 'Dynamic DNS solves the problem of changing home IP addresses. Instead of memorizing numbers like 203.0.113.45, you will access your server via a name like myserver.ddns.net — and it automatically stays updated when your ISP changes your IP.', NULL, NULL, NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-intro-6', 'step-intro', 'Click ''Next'' to begin with the first decision: how you will create your bootable USB installation media.', NULL, NULL, NULL, 5);

-- Instructions for install-windows step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-win-1', 'step-install-win', 'Download the Ubuntu Server ISO from the official website (https://ubuntu.com/download/server). Choose the latest LTS version for stability.', NULL, NULL, NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-win-2', 'step-install-win', 'Download Rufus from https://rufus.ie/. You can use the portable version — no installation required.', NULL, NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-win-3', 'step-install-win', 'Insert a USB drive (at least 4 GB) into your Windows machine. WARNING: All data on this USB drive will be erased.', NULL, NULL, NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-win-4', 'step-install-win', 'Open Rufus. It will automatically detect your USB drive. Under ''Boot selection'', click ''SELECT'' and browse to the Ubuntu Server ISO you downloaded.', NULL, NULL, NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-win-5', 'step-install-win', 'Leave the partition scheme as ''GPT'' and target system as ''UEFI (non CSM)'' for modern hardware. If your server uses legacy BIOS, choose ''MBR'' instead.', NULL, 'Most hardware from the last 10 years supports UEFI. Check your server''s BIOS settings if unsure.', NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-win-6', 'step-install-win', 'Click ''START''. Rufus may ask to download additional files — allow it. Confirm the warning about destroying data on the USB drive.', NULL, NULL, NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-win-7', 'step-install-win', 'Wait for Rufus to finish writing the ISO. When it shows ''READY'', close Rufus and safely eject the USB drive.', NULL, NULL, NULL, 6);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-win-8', 'step-install-win', 'Insert the USB drive into your home server and boot from it. You may need to change the boot order in your BIOS/UEFI settings (usually accessed by pressing F2, F12, DEL, or ESC during boot).', NULL, NULL, NULL, 7);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-win-9', 'step-install-win', 'Follow the Ubuntu Server installer. Choose your language, keyboard layout, and network configuration. For the disk setup, using the entire disk with LVM is recommended for flexibility.', NULL, NULL, NULL, 8);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-win-10', 'step-install-win', 'Create your user account and set a strong password. Enable OpenSSH server when prompted — we will configure it further later.', NULL, NULL, NULL, 9);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-win-11', 'step-install-win', 'After installation completes, remove the USB drive and reboot. Log in with the credentials you created.', NULL, NULL, NULL, 10);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-win-12', 'step-install-win', 'Update the system to ensure all packages are current.', 'sudo apt update && sudo apt upgrade -y', NULL, NULL, 11);

-- Instructions for install-linux step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-linux-1', 'step-install-linux', 'Download the Ubuntu Server ISO from the official website (https://ubuntu.com/download/server). Choose the latest LTS version for stability.', NULL, NULL, NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-linux-2', 'step-install-linux', 'Insert a USB drive (at least 4 GB) into your Linux machine. WARNING: All data on this USB drive will be erased.', NULL, NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-linux-3', 'step-install-linux', 'Identify your USB device. List all block devices and find your USB drive — it is typically /dev/sdb or /dev/sdc. Do NOT select your system disk.', 'lsblk', 'Look for the device that matches the size of your USB drive. Never use /dev/sda if that is your system disk.', NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-linux-4', 'step-install-linux', 'Unmount the USB drive if it was auto-mounted.', 'sudo umount /dev/sdX*', 'Replace /dev/sdX with your actual USB device (e.g. /dev/sdb).', NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-linux-5', 'step-install-linux', 'Write the ISO image to the USB drive using dd.', 'sudo dd if=ubuntu-24.04-live-server-amd64.iso of=/dev/sdX bs=4M status=progress conv=fsync', 'Replace /dev/sdX with your actual USB device. The conv=fsync ensures all data is flushed to the drive. This will take a few minutes.', NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-linux-6', 'step-install-linux', 'Verify the write completed successfully. The dd command will output the number of bytes written.', 'sync', NULL, NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-linux-7', 'step-install-linux', 'Safely remove the USB drive.', 'sudo eject /dev/sdX', NULL, NULL, 6);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-linux-8', 'step-install-linux', 'Insert the USB drive into your home server and boot from it. You may need to change the boot order in your BIOS/UEFI settings (usually accessed by pressing F2, F12, DEL, or ESC during boot).', NULL, NULL, NULL, 7);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-linux-9', 'step-install-linux', 'Follow the Ubuntu Server installer. Choose your language, keyboard layout, and network configuration. For the disk setup, using the entire disk with LVM is recommended for flexibility.', NULL, NULL, NULL, 8);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-linux-10', 'step-install-linux', 'Create your user account and set a strong password. Enable OpenSSH server when prompted — we will configure it further later.', NULL, NULL, NULL, 9);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-linux-11', 'step-install-linux', 'After installation completes, remove the USB drive and reboot. Log in with the credentials you created.', NULL, NULL, NULL, 10);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-linux-12', 'step-install-linux', 'Update the system to ensure all packages are current.', 'sudo apt update && sudo apt upgrade -y', NULL, NULL, 11);
