-- Continue: Instructions for nginx step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-nginx-1', 'step-nginx', 'Install Nginx from the Ubuntu package repository.', 'sudo apt install nginx -y', NULL, NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-nginx-2', 'step-nginx', 'Start the Nginx service and enable it to start automatically on boot.', 'sudo systemctl start nginx\nsudo systemctl enable nginx', NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-nginx-3', 'step-nginx', 'Verify that Nginx is running.', 'sudo systemctl status nginx', 'You should see ''active (running)'' in the output.', NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-nginx-4', 'step-nginx', 'Test that Nginx is serving the default page by visiting your server''s IP address in a web browser on the same network. You can find your server''s IP with:', 'ip addr show', NULL, NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-nginx-5', 'step-nginx', 'The default Nginx configuration file is located at /etc/nginx/sites-available/default. Review it to understand the basic structure.', 'cat /etc/nginx/sites-available/default', NULL, NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-nginx-6', 'step-nginx', 'To create your own site, create a new configuration file. For example:', 'sudo nano /etc/nginx/sites-available/mysite', 'A basic server block listens on port 80 and serves files from /var/www/mysite.', NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-nginx-7', 'step-nginx', 'Enable the site by creating a symbolic link and test the configuration.', 'sudo ln -s /etc/nginx/sites-available/mysite /etc/nginx/sites-enabled/\nsudo nginx -t\nsudo systemctl reload nginx', NULL, NULL, 6);

-- Instructions for ufw step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ufw-1', 'step-ufw', 'UFW is usually pre-installed on Ubuntu. Verify it is available.', 'sudo ufw status', 'If it shows ''inactive'', that''s expected — we haven''t enabled it yet.', NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ufw-2', 'step-ufw', 'Before enabling UFW, allow SSH connections so you don''t lock yourself out of the server.', 'sudo ufw allow OpenSSH', NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ufw-3', 'step-ufw', 'Allow HTTP and HTTPS traffic for Nginx.', 'sudo ufw allow ''Nginx Full''', NULL, NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ufw-4', 'step-ufw', 'Enable UFW.', 'sudo ufw enable', 'You will be asked to confirm. Type ''y'' and press Enter. Make sure you have allowed SSH first!', NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ufw-5', 'step-ufw', 'Verify the firewall rules.', 'sudo ufw status verbose', NULL, NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ufw-6', 'step-ufw', 'If you need to allow additional ports in the future, use the allow command.', 'sudo ufw allow 8080/tcp', 'This example allows TCP traffic on port 8080. Adjust as needed for your services.', NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ufw-7', 'step-ufw', 'To deny a specific port or remove a rule:', 'sudo ufw deny 3306\nsudo ufw delete allow 8080/tcp', NULL, NULL, 6);

-- Instructions for sshd step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-sshd-1', 'step-sshd', 'Verify that OpenSSH server is installed and running.', 'sudo systemctl status sshd', NULL, NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-sshd-2', 'step-sshd', 'Open the SSH configuration file for editing.', 'sudo nano /etc/ssh/sshd_config', NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-sshd-3', 'step-sshd', 'Disable root login by finding the ''PermitRootLogin'' line and setting it to ''no''.', 'PermitRootLogin no', 'This prevents anyone from logging in directly as root via SSH.', NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-sshd-4', 'step-sshd', 'Optionally, change the default SSH port from 22 to a non-standard port (e.g. 2222) to reduce automated scanning.', 'Port 2222', 'If you change the port, remember to update your UFW rules and port forwarding accordingly.', NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-sshd-5', 'step-sshd', 'Enable key-based authentication (it''s usually enabled by default, but verify).', 'PubkeyAuthentication yes', NULL, NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-sshd-6', 'step-sshd', 'Generate an SSH key pair on your local machine (not the server) if you don''t have one.', 'ssh-keygen -t ed25519 -C "your_email@example.com"', 'Press Enter to accept the default file location. Set a passphrase for extra security.', NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-sshd-7', 'step-sshd', 'Copy your public key to the server.', 'ssh-copy-id -i ~/.ssh/id_ed25519.pub your_user@your_server_ip', NULL, NULL, 6);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-sshd-8', 'step-sshd', 'Once key-based login works, disable password authentication for maximum security.', 'PasswordAuthentication no', 'Only do this after confirming you can log in with your SSH key!', NULL, 7);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-sshd-9', 'step-sshd', 'Restart the SSH service to apply changes.', 'sudo systemctl restart sshd', NULL, NULL, 8);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-sshd-10', 'step-sshd', 'If you changed the SSH port, update UFW.', 'sudo ufw allow 2222/tcp\nsudo ufw delete allow OpenSSH', NULL, NULL, 9);

-- Instructions for port forwarding step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-port-1', 'step-portfwd', 'Find your server''s local IP address. This is the address you will forward traffic to.', 'ip addr show | grep ''inet ''', 'Look for the address on your primary network interface (e.g. 192.168.1.x or 10.0.0.x). Ignore the 127.0.0.1 loopback address.', NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-port-2', 'step-portfwd', 'Consider assigning a static IP to your server so the address doesn''t change. Edit the Netplan configuration:', 'sudo nano /etc/netplan/01-netcfg.yaml', 'Set a static address outside your router''s DHCP range to avoid conflicts.', NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-port-3', 'step-portfwd', 'Apply the Netplan configuration.', 'sudo netplan apply', NULL, NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-port-4', 'step-portfwd', 'Access your router''s admin interface. This is usually at 192.168.1.1 or 192.168.0.1 in your web browser. Log in with your router''s admin credentials.', NULL, NULL, NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-port-5', 'step-portfwd', 'Navigate to the Port Forwarding section. This is often found under ''Advanced'', ''NAT'', or ''Firewall'' settings depending on your router model.', NULL, NULL, NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-port-6', 'step-portfwd', 'Create port forwarding rules for the services you want to expose. Forward external port 80 (HTTP) to your server''s internal IP on port 80, and external port 443 (HTTPS) to port 443.', NULL, NULL, NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-port-7', 'step-portfwd', 'If you changed your SSH port, forward that port as well (e.g. external port 2222 to internal port 2222).', NULL, 'Only forward SSH if you genuinely need remote access from outside your network. It increases your attack surface.', NULL, 6);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-port-8', 'step-portfwd', 'Save the router configuration and test from outside your network (e.g., using your mobile phone on cellular data) by navigating to your public IP address.', 'curl ifconfig.me', 'Run this on your server to find your public IP address.', NULL, 7);

-- Instructions for dynamic DNS step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ddns-1', 'step-ddns', 'Create a free account at https://www.noip.com/. After registering, create a hostname (e.g. myserver.ddns.net) from the No-IP dashboard.', NULL, NULL, NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ddns-2', 'step-ddns', 'Install the No-IP Dynamic Update Client (DUC) on your server. First, download it.', 'cd /usr/local/src\nsudo wget https://www.noip.com/client/linux/noip-duc-linux.tar.gz\nsudo tar xzf noip-duc-linux.tar.gz', NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ddns-3', 'step-ddns', 'Build and install the client.', 'cd noip-2.1.9-1\nsudo make\nsudo make install', 'During installation, you''ll be prompted for your No-IP email and password, and asked to choose which hostname to update.', NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ddns-4', 'step-ddns', 'Start the No-IP client.', 'sudo /usr/local/bin/noip2', NULL, NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ddns-5', 'step-ddns', 'Create a systemd service so the No-IP client starts automatically on boot. Create the service file:', 'sudo nano /etc/systemd/system/noip2.service', NULL, NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ddns-6', 'step-ddns', 'Add the following content to the service file:', '[Unit]\nDescription=No-IP Dynamic DNS Update Client\nAfter=network.target\n\n[Service]\nType=forking\nExecStart=/usr/local/bin/noip2\nRestart=on-failure\n\n[Install]\nWantedBy=multi-user.target', NULL, NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ddns-7', 'step-ddns', 'Enable and start the service.', 'sudo systemctl daemon-reload\nsudo systemctl enable noip2\nsudo systemctl start noip2', NULL, NULL, 6);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ddns-8', 'step-ddns', 'Verify the service is running.', 'sudo systemctl status noip2', 'You should see ''active (running)''. The client will now automatically update your No-IP hostname with your current public IP.', NULL, 7);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ddns-9', 'step-ddns', 'Test your setup by accessing your server using your No-IP hostname from outside your network.', 'curl http://myserver.ddns.net', 'Replace myserver.ddns.net with your actual hostname. You should see the Nginx default page.', NULL, 8);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('instr-ddns-10', 'step-ddns', 'Optionally, update your Nginx server configuration to use your hostname.', 'server_name myserver.ddns.net;', 'Add this to your Nginx server block and reload Nginx.', NULL, 9);
