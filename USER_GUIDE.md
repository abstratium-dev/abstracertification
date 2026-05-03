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

### Generate TODO

TODO any env vars that need generating are to be described here.

1. **Generate TODO** (32+ characters recommended):
   ```bash
   openssl rand -base64 32
   ```
   Use this output for `TODO_ENV_VAR_NAME`.

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
     ghcr.io/abstratium-dev/abstracertification:latest
   ```

   **Required Environment Variables:**
   - `QUARKUS_DATASOURCE_JDBC_URL`: Database connection URL (format: `jdbc:mysql://<host>:<port>/<database>`)
   - `QUARKUS_DATASOURCE_USERNAME`: Database username
   - `QUARKUS_DATASOURCE_PASSWORD`: Database password (use strong, unique password)
   - `COOKIE_ENCRYPTION_SECRET`: Cookie encryption secret (min 32 chars, generate with `openssl rand -base64 32`)
   - `CSRF_TOKEN_SIGNATURE_KEY`: CSRF token signature key (min 32 chars, generate with `openssl rand -base64 64 | tr -d '\n'`)
   
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

