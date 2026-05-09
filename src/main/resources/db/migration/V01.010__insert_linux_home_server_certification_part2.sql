-- Instructions for ssh-connect-windows step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b5c', 'a1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e', 'Download and install PuTTY from the official website. The installer includes PuTTY (SSH client) and PuTTYgen (key generator).', NULL, 'Go to https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html and download the 64-bit MSI installer. Run it and accept the defaults. This is the only official source — do not download PuTTY from third-party sites.', NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('a2b3c4d5-e6f7-4a8b-9c0d-1e2f3a4b5c6d', 'a1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e', 'Download and install WinSCP from the official website.', NULL, 'Go to https://winscp.net and download the installer. WinSCP is a graphical file transfer client that integrates with PuTTY. During installation, choose the ''Commander'' interface style for a dual-pane view (local left, server right).', NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('b3c4d5e6-f7a8-4b9c-0d1e-2f3a4b5c6d7e', 'a1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e', 'Before connecting for the first time, you should verify the server''s fingerprint. Run this command directly on the server (via physical access or console) to get its fingerprint:', 'ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub', 'A fingerprint looks like: SHA256:abc123... user@host. Note this value down — you will compare it against what PuTTY shows on first connection. This protects against man-in-the-middle attacks.', NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('c4d5e6f7-a8b9-4c0d-1e2f-3a4b5c6d7e8f', 'a1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e', 'Open PuTTY. In the ''Host Name'' field enter your server''s IP address, set the Port to 22 (or your custom SSH port), ensure Connection type is SSH, then click Open.', NULL, 'You can save this session: enter a name in the ''Saved Sessions'' field and click Save. Next time you can just double-click the saved session to connect.', NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('c4d5e6f7-a8b9-4c0d-1e2f-3a4b5c6d7e9f', 'a1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e', 'On first connection, PuTTY will show a security alert with the server''s fingerprint. Compare it carefully against the fingerprint you noted from the server. If they match, click Accept. If they do not match, click Cancel and investigate before proceeding.', NULL, 'Once accepted, PuTTY stores the fingerprint in the Windows registry. You will not be asked again unless the server key changes, which could indicate a security problem.', NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('e6f7a8b9-c0d1-4e2f-3a4b-5c6d7e8f9a0b', 'a1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e', 'Log in with your username and password when prompted. You now have an SSH session on the server.', NULL, 'You can also prepend your username to the host name in PuTTY''s Host Name field (e.g. your_user@192.168.1.100) so that PuTTY fills in the username automatically and you only need to enter your password.', NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('f7a8b9c0-d1e2-4f3a-4b5c-6d7e8f9a0b1c', 'a1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e', 'To transfer files, open WinSCP. In the Login dialog, set File protocol to SFTP, enter your server''s IP in Host name, set the Port, enter your username and password, then click Login.', NULL, 'On first connection WinSCP will also show the server fingerprint for verification. Accept it if it matches the value you noted from the server.', NULL, 6);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('a8b9c0d1-e2f3-4a4b-5c6d-7e8f9a0b1c2d', 'a1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e', 'In WinSCP, the left panel shows your local Windows files and the right panel shows the server. Drag and drop files between panels to transfer them. Right-click files for more options such as Edit, Permissions, and Delete.', NULL, 'WinSCP also has a built-in text editor: right-click any file on the server and choose Edit to open it directly without downloading first.', NULL, 7);

-- Instructions for ssh-connect-linux step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('d1e2f3a4-b5c6-4d7e-8f9a-0b1c2d3e4f5a', 'b2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', 'Check if the OpenSSH client is installed on your Linux machine:', 'ssh -V', 'If the command outputs a version number, you are ready. If it says ''command not found'', proceed to the next step.', NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('e2f3a4b5-c6d7-4e8f-9a0b-1c2d3e4f5a6b', 'b2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', 'If the OpenSSH client is not installed, install it using your package manager:', 'sudo apt install openssh-client -y', 'On Fedora/RHEL use: sudo dnf install openssh-clients. On Arch use: sudo pacman -S openssh.', NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('f3a4b5c6-d7e8-4f9a-0b1c-2d3e4f5a6b7c', 'b2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', 'Connect to your server via SSH:', 'ssh your_user@your_server_ip', 'Replace your_user with the username you created during installation and your_server_ip with the server''s local IP address (e.g. 192.168.1.100). If you changed the SSH port, add -p 2222.', NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('a4b5c6d7-e8f9-4a0b-1c2d-3e4f5a6b7c8d', 'b2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', 'The first time you connect, SSH will display the server''s fingerprint and ask you to verify it. Before typing ''yes'', you should first confirm this fingerprint matches what your server actually shows. To get the server''s fingerprint, run this command directly on the server (via physical access or a console):', 'ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub', 'A fingerprint looks like: SHA256:abc123... user@host. Compare this value to what SSH shows on your client. If they match, the connection is genuine. If they do not match, do not proceed — someone may be intercepting your connection. This protects against man-in-the-middle attacks. Once accepted, the fingerprint is stored in ~/.ssh/known_hosts and you will not be asked again for this server.', NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('a4b5c6d7-e8f9-4a0b-1c2d-3e4f5a6b7c9d', 'b2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', 'Once you have confirmed the fingerprint matches, type ''yes'' on your client and press Enter. You will then be prompted for your password.', NULL, NULL, NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('c6d7e8f9-a0b1-4c2d-3e4f-5a6b7c8d9e0f', 'b2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', 'SCP (Secure Copy Protocol) allows you to transfer files between your Linux machine and the server. It uses the same SSH connection for secure transfers.', NULL, NULL, NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('d7e8f9a0-b1c2-4d3e-4f5a-6b7c8d9e0f1a', 'b2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', 'Copy a file from your local machine to the server:', 'scp /path/to/local/file.txt your_user@your_server_ip:/home/your_user/', 'Replace the paths and credentials with your actual values. If you changed the SSH port, add -P 2222 (note: uppercase P for scp).', NULL, 6);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('e8f9a0b1-c2d3-4e4f-5a6b-7c8d9e0f1a2b', 'b2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', 'Copy a file from the server to your local machine:', 'scp your_user@your_server_ip:/home/your_user/file.txt /path/to/local/', NULL, NULL, 7);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('f9a0b1c2-d3e4-4f5a-6b7c-8d9e0f1a2b3c', 'b2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', 'Copy an entire directory recursively from your local machine to the server:', 'scp -r /path/to/local/folder your_user@your_server_ip:/home/your_user/', 'The -r flag copies directories and their contents recursively.', NULL, 8);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('a0b1c2d3-e4f5-4a6b-7c8d-9e0f1a2b3c4d', 'b2d3e4f5-a6b7-4c8d-9e0f-1a2b3c4d5e6f', 'To disconnect from the SSH session, type:', 'exit', NULL, NULL, 9);

-- Info items (key concepts) for nginx step
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('c1d2e3f4-a5b6-4c7d-8e9f-0a1b2c3d4e5f', '4b4023e4-e123-42fe-8fb9-154cb11d2833', 'Reverse Proxy', 'A reverse proxy is a server that sits in front of one or more backend services and forwards client requests to them. Unlike a forward proxy (which acts on behalf of a client), a reverse proxy acts on behalf of the server. Nginx is commonly used as a reverse proxy: instead of serving files directly, it can receive a request on port 80 or 443 and forward it to another process running locally (e.g. a Node.js app on port 3000). This lets you run multiple services on one machine, each on a different internal port, all accessible through standard HTTP/HTTPS.', 0);

-- Continue: Instructions for nginx step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('08a150b8-02f7-4130-9f3b-8733993a6a9a', '4b4023e4-e123-42fe-8fb9-154cb11d2833', 'Install Nginx on the server from the Ubuntu package repository.', 'sudo apt install nginx -y', NULL, NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('b5909829-3bc7-40b0-b1e9-6bab0c8d0350', '4b4023e4-e123-42fe-8fb9-154cb11d2833', 'Start the Nginx service and enable it to start automatically on boot.', 'sudo systemctl start nginx\nsudo systemctl enable nginx', NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('40b7b325-4929-4356-8ebd-594876546749', '4b4023e4-e123-42fe-8fb9-154cb11d2833', 'Verify that Nginx is running.', 'sudo systemctl status nginx', 'You should see ''active (running)'' in the output.', NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('cb3264b5-43b5-41a5-aa6d-5c74d5d1690a', '4b4023e4-e123-42fe-8fb9-154cb11d2833', 'Test that Nginx is serving the default page by visiting your server''s IP address in a web browser on the same network. You can find your server''s IP with:', 'ip addr show', NULL, NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('78db2054-40dc-41bb-bcad-751705a9170f', '4b4023e4-e123-42fe-8fb9-154cb11d2833', 'The default Nginx configuration file is located at /etc/nginx/sites-available/default. Review it to understand the basic structure.', 'cat /etc/nginx/sites-available/default', NULL, NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('d45af597-7113-43d4-a2ca-2f3ffa33f931', '4b4023e4-e123-42fe-8fb9-154cb11d2833', 'To create your own site, create a new configuration file. For example:', 'sudo nano /etc/nginx/sites-available/mysite', 'A basic server block listens on port 80 and serves files from /var/www/mysite.', NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('81bbd687-afca-4fb1-874f-3f40ae5d1faf', '4b4023e4-e123-42fe-8fb9-154cb11d2833', 'Enable the site by creating a symbolic link and test the configuration.', 'sudo ln -s /etc/nginx/sites-available/mysite /etc/nginx/sites-enabled/\nsudo nginx -t\nsudo systemctl reload nginx', NULL, NULL, 6);

-- Instructions for ufw step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('1f507dca-1254-4aa4-9753-f5fc2fe31fed', '05782de5-0676-48bc-825e-a126969086bb', 'UFW is usually pre-installed on Ubuntu. Verify it is available.', 'sudo ufw status', 'If it shows ''inactive'', that''s expected — we haven''t enabled it yet.', NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('494f36a8-abfd-406f-95b2-ac09ab2cdb19', '05782de5-0676-48bc-825e-a126969086bb', 'Before enabling UFW, allow SSH connections so you don''t lock yourself out of the server.', 'sudo ufw allow OpenSSH', NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('2df64541-83fe-485f-aa61-9cb175e2e5e5', '05782de5-0676-48bc-825e-a126969086bb', 'Allow HTTP and HTTPS traffic for Nginx.', 'sudo ufw allow ''Nginx Full''', NULL, NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('1aabd567-b317-4b5e-92bd-7db1eb69e673', '05782de5-0676-48bc-825e-a126969086bb', 'Enable UFW.', 'sudo ufw enable', 'You will be asked to confirm. Type ''y'' and press Enter. Make sure you have allowed SSH first!', NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ade85711-85d8-43b4-9c23-af049a2ce538', '05782de5-0676-48bc-825e-a126969086bb', 'Verify the firewall rules.', 'sudo ufw status verbose', NULL, NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('aa0856bb-d1dc-4756-a174-49087a4fac83', '05782de5-0676-48bc-825e-a126969086bb', 'If you need to allow additional ports in the future, use the allow command.', 'sudo ufw allow 8080/tcp', 'This example allows TCP traffic on port 8080. Adjust as needed for your services.', NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('3c3a7d32-2dea-4d10-8314-380536d0073e', '05782de5-0676-48bc-825e-a126969086bb', 'To deny a specific port or remove a rule:', 'sudo ufw deny 3306\nsudo ufw delete allow 8080/tcp', NULL, NULL, 6);

-- Info items (key concepts) for sshd step
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('a1f2e3d4-b5c6-4d7e-8f9a-0b1c2d3e4f5a', 'ec4bcbdd-dabc-4c76-a967-470c14e8adc4', 'sudo', 'sudo (short for "superuser do") allows a permitted user to run a command with elevated privileges — as if they were the root (administrator) user. On Ubuntu, most system administration commands require sudo. It provides a safety net by requiring your own password and logging what was run, rather than giving you a permanent root shell.', 0);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('b2a3f4e5-c6d7-4e8f-9a0b-1c2d3e4f5a6b', 'ec4bcbdd-dabc-4c76-a967-470c14e8adc4', 'systemctl', 'systemctl is the command-line tool for controlling systemd, the init system and service manager used by Ubuntu and most modern Linux distributions. It lets you start, stop, restart, enable (auto-start on boot), disable, and check the status of system services (also called units). For example: systemctl status sshd shows whether the SSH daemon is running.', 1);

-- Instructions for sshd step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('83587d58-2598-4647-90b5-442563d8e510', 'ec4bcbdd-dabc-4c76-a967-470c14e8adc4', 'Verify that OpenSSH server is installed and running on the server.', 'sudo systemctl status sshd', 'sudo runs the command with administrator privileges. systemctl is the tool for managing system services. status sshd queries the current state of the SSH daemon (sshd). You should see ''active (running)'' if it is installed and started.', NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('9c6f918d-8a6f-4b1d-8883-f7b8116b3bf3', 'ec4bcbdd-dabc-4c76-a967-470c14e8adc4', 'Open the SSH configuration file for editing.', 'sudo nano /etc/ssh/sshd_config', NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('9e08a3bc-9857-4cf4-a8fd-5e74a48e7c8c', 'ec4bcbdd-dabc-4c76-a967-470c14e8adc4', 'Disable root login by finding the ''PermitRootLogin'' line and setting it to ''no''.', 'PermitRootLogin no', 'This prevents anyone from logging in directly as root via SSH.', NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('56e309f5-a64f-43d2-945a-0cb3e1d5d826', 'ec4bcbdd-dabc-4c76-a967-470c14e8adc4', 'Optionally, change the default SSH port from 22 to a non-standard port (e.g. 2222) to reduce automated scanning.', 'Port 2222', 'If you change the port, remember to update your UFW rules and port forwarding accordingly.', NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('2be78221-e0b4-4f28-824a-b8d777dd484d', 'ec4bcbdd-dabc-4c76-a967-470c14e8adc4', 'Restart the SSH service to apply changes.', 'sudo systemctl restart sshd', NULL, NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ce9a1164-2705-4b59-a951-c7b8a352ac1d', 'ec4bcbdd-dabc-4c76-a967-470c14e8adc4', 'If you changed the SSH port, update UFW.', 'sudo ufw allow 2222/tcp
sudo ufw delete allow OpenSSH', NULL, NULL, 5);

-- Instructions for port forwarding step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('9599ad19-2f3c-415a-86c7-c9747eae6c9a', 'ff7f23e8-1c03-467a-a1da-7abfa901bacf', 'Find your server''s local IP address. This is the address you will forward traffic to.', 'ip addr show | grep ''inet ''', 'Look for the address on your primary network interface (e.g. 192.168.1.x or 10.0.0.x). Ignore the 127.0.0.1 loopback address.', NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('09907482-24e9-4c4e-9313-c2e7ac58c8b4', 'ff7f23e8-1c03-467a-a1da-7abfa901bacf', 'Consider assigning a static IP to your server so the address doesn''t change. Edit the Netplan configuration:', 'sudo nano /etc/netplan/01-netcfg.yaml', 'Set a static address outside your router''s DHCP range to avoid conflicts.', NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('d9f33c24-0394-416e-8186-f0dedc2a0af4', 'ff7f23e8-1c03-467a-a1da-7abfa901bacf', 'Apply the Netplan configuration.', 'sudo netplan apply', NULL, NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('5e855e5c-1617-4e05-888d-71b4cb36d534', 'ff7f23e8-1c03-467a-a1da-7abfa901bacf', 'Access your router''s admin interface. This is usually at 192.168.1.1 or 192.168.0.1 in your web browser. Log in with your router''s admin credentials.', NULL, NULL, NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('f29d859c-97d8-43e8-80d8-5e6b914a987a', 'ff7f23e8-1c03-467a-a1da-7abfa901bacf', 'Navigate to the Port Forwarding section. This is often found under ''Advanced'', ''NAT'', or ''Firewall'' settings depending on your router model.', NULL, NULL, NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('737b3448-ad3e-47ef-aa25-d8e605e91f83', 'ff7f23e8-1c03-467a-a1da-7abfa901bacf', 'Create port forwarding rules for the services you want to expose. Forward external port 80 (HTTP) to your server''s internal IP on port 80, and external port 443 (HTTPS) to port 443.', NULL, NULL, NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('fa176a1a-bf24-46c2-b2e3-e9f1c1c18450', 'ff7f23e8-1c03-467a-a1da-7abfa901bacf', 'If you changed your SSH port, forward that port as well (e.g. external port 2222 to internal port 2222).', NULL, 'Only forward SSH if you genuinely need remote access from outside your network. It increases your attack surface.', NULL, 6);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('0c0913ce-02cb-4770-a880-dc981391ebeb', 'ff7f23e8-1c03-467a-a1da-7abfa901bacf', 'Save the router configuration and test from outside your network (e.g., using your mobile phone on cellular data) by navigating to your public IP address.', 'curl ifconfig.me', 'Run this on your server to find your public IP address.', NULL, 7);

-- Instructions for dynamic DNS step
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('d6df5a62-8a13-49d0-bc85-c79a90a931bc', '6d688465-40a8-4de1-b60c-7794b07492a5', 'Create a free account at https://www.noip.com/. After registering, create a hostname (e.g. myserver.ddns.net) from the No-IP dashboard.', NULL, NULL, NULL, 0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('d469ea5c-ebd7-4176-9837-373ccdbd53e1', '6d688465-40a8-4de1-b60c-7794b07492a5', 'Install the No-IP Dynamic Update Client (DUC) on your server. First, download it.', 'cd /usr/local/src\nsudo wget https://www.noip.com/client/linux/noip-duc-linux.tar.gz\nsudo tar xzf noip-duc-linux.tar.gz', NULL, NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('463574fc-3ddd-4c43-8d2f-b867478d94a4', '6d688465-40a8-4de1-b60c-7794b07492a5', 'Build and install the client.', 'cd noip-2.1.9-1\nsudo make\nsudo make install', 'During installation, you''ll be prompted for your No-IP email and password, and asked to choose which hostname to update.', NULL, 2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('9e9d063c-74db-4fe7-a585-292006345205', '6d688465-40a8-4de1-b60c-7794b07492a5', 'Start the No-IP client.', 'sudo /usr/local/bin/noip2', NULL, NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('7364e71b-4510-43dc-a3fe-927c8f38b248', '6d688465-40a8-4de1-b60c-7794b07492a5', 'Create a systemd service so the No-IP client starts automatically on boot. Create the service file:', 'sudo nano /etc/systemd/system/noip2.service', NULL, NULL, 4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('feb12177-b5e2-42de-beea-11d70d378110', '6d688465-40a8-4de1-b60c-7794b07492a5', 'Add the following content to the service file:', '[Unit]\nDescription=No-IP Dynamic DNS Update Client\nAfter=network.target\n\n[Service]\nType=forking\nExecStart=/usr/local/bin/noip2\nRestart=on-failure\n\n[Install]\nWantedBy=multi-user.target', NULL, NULL, 5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('693aeca5-4192-4388-8db5-d0fd7f152938', '6d688465-40a8-4de1-b60c-7794b07492a5', 'Enable and start the service.', 'sudo systemctl daemon-reload\nsudo systemctl enable noip2\nsudo systemctl start noip2', NULL, NULL, 6);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('c5f9bb17-761a-4b9c-925a-906b99aa3ce2', '6d688465-40a8-4de1-b60c-7794b07492a5', 'Verify the service is running.', 'sudo systemctl status noip2', 'You should see ''active (running)''. The client will now automatically update your No-IP hostname with your current public IP.', NULL, 7);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('90194ae6-ace5-465b-ae2c-12a494f1bf41', '6d688465-40a8-4de1-b60c-7794b07492a5', 'Test your setup by accessing your server using your No-IP hostname from outside your network.', 'curl http://myserver.ddns.net', 'Replace myserver.ddns.net with your actual hostname. You should see the Nginx default page.', NULL, 8);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('e0d233a1-5bfd-4156-8854-6f9892bd3155', '6d688465-40a8-4de1-b60c-7794b07492a5', 'Optionally, update your Nginx server configuration to use your hostname.', 'server_name myserver.ddns.net;', 'Add this to your Nginx server block and reload Nginx.', NULL, 9);
