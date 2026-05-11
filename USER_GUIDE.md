# User Manual

## Installation

It is intended that this component be run using docker.
It supports MySql and will soon also support postgresql and MS SQL Server.

You need to add a database/schema and a user to the database manually.

### Create the Database, User and Grant Permissions

#### MySQL

This component requires a MySQL database. Create a database and user with the following steps:

1. **Connect to MySQL** as root or admin user:

(change `<password>` to your password)
(change `<abstracertification>` to the project name)

```bash
docker run -it --rm --network abstratium mysql mysql -h abstratium-mysql --port 3306 -u root -p<password>

DROP USER IF EXISTS 'abstracertification'@'%';

CREATE USER 'abstracertification'@'%' IDENTIFIED BY '<password>';

DROP DATABASE IF EXISTS abstracertification;

CREATE DATABASE abstracertification CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL PRIVILEGES ON abstracertification.* TO abstracertification@'%'; -- on own database

FLUSH PRIVILEGES;

EXIT;
```

This project will automatically create all necessary tables and any initial data when it first connects to the database.

New versions will update the database as needed.

### Generate Environment Variables

1. **Generate Cookie Encryption Secret** (32+ characters recommended):
   ```bash
   openssl rand -base64 32
   ```
   Use this output for `COOKIE_ENCRYPTION_SECRET`.

2. **Generate CSRF Token Signature Key** (64+ characters recommended):
   ```bash
   openssl rand -base64 64 | tr -d '\n'
   ```
   Use this output for `CSRF_TOKEN_SIGNATURE_KEY`.

3. **Generate Anthropic Claude API Key**:
   - Visit https://console.anthropic.com/
   - Create an account or sign in
   - Navigate to API Keys section
   - Generate a new API key
   - Use this output for `ANTHROPIC_API_KEY`

### Pull and Run the Docker Container

1. **Pull the latest image** from GitHub Container Registry:
   ```bash
   docker pull ghcr.io/abstratium-dev/abstracertification:latest
   ```

2. **Run the container**:

_Replace all `TODO_...` values with the values generated above.

   ```bash
   docker run -d \
     --name abstracertification \
     --network your-network \
     -p 127.0.0.1:41085:8085 \
     -p 127.0.0.1:9007:9007 \
     -e QUARKUS_DATASOURCE_JDBC_URL="jdbc:mysql://your-mysql-host:3306/abstracertification" \
     -e QUARKUS_DATASOURCE_USERNAME="abstracertification" \
     -e QUARKUS_DATASOURCE_PASSWORD="YOUR_SECURE_PASSWORD" \
     -e COOKIE_ENCRYPTION_SECRET="YOUR_COOKIE_ENCRYPTION_SECRET" \
     -e CSRF_TOKEN_SIGNATURE_KEY="YOUR_CSRF_TOKEN_SIGNATURE_KEY" \
     -e ABSTRATIUM_CLIENT_ID="abstratium-abstracertification" \
     -e ABSTRATIUM_CLIENT_SECRET="YOUR_OIDC_CLIENT_SECRET" \
     -e ANTHROPIC_API_KEY="YOUR_ANTHROPIC_API_KEY" \
     -e MAIL_HOST="YOUR_SMTP_HOST" \
     -e MAIL_PORT="587" \
     -e MAIL_TLS="true" \
     -e MAIL_USERNAME="YOUR_SMTP_USERNAME" \
     -e MAIL_PASSWORD="YOUR_SMTP_PASSWORD" \
     -e MAIL_FROM="noreply@yourdomain.com" \
     -e CONTACT_MAIL_TO="contact@yourdomain.com" \
     ghcr.io/abstratium-dev/abstracertification:latest
   ```

   **Required Environment Variables:**
   - `QUARKUS_DATASOURCE_JDBC_URL`: Database connection URL (format: `jdbc:mysql://<host>:<port>/<database>`)
   - `QUARKUS_DATASOURCE_USERNAME`: Database username
   - `QUARKUS_DATASOURCE_PASSWORD`: Database password (use strong, unique password)
   - `COOKIE_ENCRYPTION_SECRET`: Cookie encryption secret (min 32 chars, generate with `openssl rand -base64 32`)
   - `CSRF_TOKEN_SIGNATURE_KEY`: CSRF token signature key (min 32 chars, generate with `openssl rand -base64 64 | tr -d '\n'`)
   - `ABSTRATIUM_CLIENT_SECRET`: OAuth2 client secret from authentication server
   - `ANTHROPIC_API_KEY`: Anthropic Claude API key for AI chat functionality (get from https://console.anthropic.com/)
   - `MAIL_HOST`: SMTP server hostname (e.g. `smtp.sendgrid.net`)
   - `MAIL_PORT`: SMTP server port (default: `587`)
   - `MAIL_TLS`: Enable TLS for SMTP connection (`true` or `false`, default: `true`)
   - `MAIL_USERNAME`: SMTP authentication username
   - `MAIL_PASSWORD`: SMTP authentication password
   - `MAIL_FROM`: Sender email address for outgoing notifications (default: `noreply@abstratium.dev`)
   - `CONTACT_MAIL_TO`: Recipient email address for contact form submissions (default: `contact@abstratium.dev`)
   
   **Optional Environment Variables:**
   - `DEPLOYMENT_ENV`: Deployment environment name (default: `dev`)

3. **Verify the container is running**:
   ```bash
   docker ps
   docker logs abstracertification
   curl http://localhost:41085/m/health
   curl http://localhost:41085/m/info
   ```

4. **Access the application**:
   - Main application: http://localhost:41085
   - Management interface: http://localhost:9007/m/info

### Prerequisites

Before installation, ensure you have:

- **Docker** installed and running
- **MySQL 8.0+** database server
- **Network connectivity** between Docker container and MySQL
- **OpenSSL** for generating JWT keys
- **GitHub account** (if pulling from GitHub Container Registry)
- **nginx** or similar for reverse proxying and terminating TLS

## Initial Onboarding

TODO

## Account and Role Management

This component requires that users can authenticate using an oauth authorization server. That requires that an administrator signs into something like `abstratium-abstrauth` first, to create the oauth2 client. The callback url should be `http://localhost:8085/oauth/callback` and one for the production environment, also ending in `/oauth/callback`. Use the `client_id` and `client_secret` that it provides, to set the values of the environment variables above, so that users can sign in.

## AI Chat Functionality

This application includes an AI-powered chat assistant that uses Anthropic's Claude API to help users with certification content.

### Features

- **Context-Aware Assistance**: The AI assistant has access to the current certification content, including instructions, key concepts, and learning objectives
- **Smart Constraints**: The assistant is configured to not directly answer assessment questions, but can provide hints and explanations
- **Streaming Responses**: Chat responses are streamed in real-time for better user experience
- **Session Management**: Chat sessions are managed client-side with UUID-based session identifiers

### Usage

1. **Chat Interface**: A chat window is available above the question/answer section on each certification page
2. **Session Persistence**: Chat history is stored client-side and sent with each new message to maintain context
3. **API Endpoint**: The chat functionality is available at `/public/certifications/{id}/chat`

### API Usage

```bash
curl -X POST http://localhost:41085/public/certifications/{certification-id}/chat \
  -H "Content-Type: application/json" \
  -d '{
    "message": "Can you explain this concept better?",
    "certificationId": "linux-home-server",
    "pageId": "step-1",
    "sessionId": "uuid-v4-generated-by-client",
    "history": [
      {"role": "user", "content": "Previous question"},
      {"role": "assistant", "content": "Previous answer"}
    ]
  }'
```

### Configuration

The AI chat functionality requires:

- `ANTHROPIC_API_KEY`: Your Anthropic Claude API key
- The chat uses Claude 3.5 Sonnet model by default
- Responses are configured with 0.7 temperature for balanced creativity
- Maximum token limit is set to 4000 tokens per response

## TODO

TODO describe other functionality here.

## Monitoring and Health Checks

This project provides several endpoints for monitoring:

- **Health Check**: `http://localhost:9007/m/health`
  - Returns application health status
  - Includes database connectivity check

- **Info Endpoint**: `http://localhost:9007/m/info`
  - Returns build information, version, and configuration
  - Useful for verifying deployment

## Troubleshooting

### Container won't start

1. Check Docker logs: `docker logs abstracertification`
2. Verify environment variables are set correctly
3. Ensure database is accessible from container
4. Check network connectivity: `docker network inspect your-network`

### Database connection errors

1. Verify MySQL is running: `mysql -u abstracertification -p -h your-mysql-host`
2. Check firewall rules allow connection on port 3306
3. Verify database user has correct permissions
4. Check JDBC URL format is correct

### JWT token errors

1. Verify keys are correctly base64-encoded
2. Ensure public key matches private key
3. Check key length is at least 2048 bits
4. Verify no extra whitespace in environment variables

## Security Best Practices

1. **Never use default/test keys in production**
2. **Store secrets in secure secret management systems** (e.g., HashiCorp Vault, AWS Secrets Manager)
3. **Use strong, unique passwords** for database and admin accounts
4. **Enable HTTPS** in production (configure reverse proxy)
5. **Regularly update** the Docker image to get security patches
6. **Monitor logs** for suspicious activity
7. **Backup database regularly**
8. **Limit network access** to database and management interface
9. **Rotate JWT keys periodically** (requires user re-authentication)

### Additional Resources

- TODO e.g. [RFC 7636 - PKCE](https://datatracker.ietf.org/doc/html/rfc7636)

