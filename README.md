# abstracertification

**abstracertification** is a site containing certifications which engineers can achieve on their way to learning about how abstratium develops and deploys software.

⚠️ **IMPORTANT**: Avoid modifying the `/core` directory in your project forks. Keep your custom logic in `/app` or specific feature packages to minimize merge conflicts during updates.

## 🏗️ Project Structure

src/main/java/...: Core logic, security filters, and Abstrauth integration.

src/main/webui: The Angular application (managed by Quinoa).

docker/: Standardized deployment configurations.

scripts/: Automation for syncing with Abstracore.

## 🚀 Development Mode

Run the following command to start Quarkus in Dev Mode with the Angular live-reload server:

```bash
./mvnw quarkus:dev
```
Backend: http://localhost:8085

Frontend: Automatically proxied by Quinoa

Dev UI: http://localhost:8085/q/dev

------------------------

## Security

🔒 **Found a security vulnerability?** Please read our [Security Policy](SECURITY.md) for responsible disclosure guidelines.

For information about the security implementation and features, see [SECURITY_DESIGN.md](docs/security/SECURITY_DESIGN.md).

## Documentation

- [User Guide](USER_GUIDE.md)
- [Database](docs/DATABASE.md)
- [Native Image Build](docs/NATIVE_IMAGE_BUILD.md)
- [Other documentation](docs)

## Running the Application

See [User Guide](USER_GUIDE.md)

## Development and Testing

See [Development and Testing](docs/DEVELOPMENT_AND_TESTING.md)

## TODO

See [TODO.md](TODO.md)


## Aesthetics

### favicon

https://favicon.io/favicon-generator/ - text based

Text: a
Background: rounded
Font Family: Leckerli One
Font Variant: Regular 400 Normal
Font Size: 110
Font Color: #FFFFFF
Background Color: #5c6bc0

----

# Things to do when creating a new project

- [ ] - Search for TODO and fix
- [ ] - Search for core and fix, e.g. in `pom.xml`
- [ ] - Update README.md with project-specific information
- [ ] - Update USER_GUIDE.md with project-specific information
- [ ] - Update DATABASE.md with project-specific information
- [ ] - Update NATIVE_IMAGE_BUILD.md with project-specific information
- [ ] - Update SECURITY_DESIGN.md with project-specific information
- [ ] - Update TODO.md with project-specific information
- [ ] - Update SECURITY.md with project-specific information
- [ ] - Update CONTRIBUTING.md with project-specific information
- [ ] - Create favicon, store it in root as zip and put it in `src/main/webui/public`
- [ ] - Update `.windsurf` configuration
- [ ] - Replace `src/main/webui/src/app/demo` with project-specific components
- [ ] - Update application.properties with abstradex-specific values
- [ ] - Update Angular configuration files (angular.json, package.json, index.html)
- [ ] - Update Java source files (Roles.java, ConfigInfoContributor.java)
- [ ] - Update database migration files
- [ ] - Update script files (build-docker-image.sh, push-docker-image.sh, clear-test-db.sh)
- [ ] - Update e2e-tests configuration
- [ ] - Update documentation files (QUARKUS.md, DEVELOPMENT_AND_TESTING.md, AUTHENTICATION_FLOW.md)
- [ ] - delete the top of this file that talks about the git hook
- [ ] add a new oauth client to your oauth authorization server like abstrauth
- [ ] - delete this TODO list

# Second Prompt for LLM

Remember to replace XXXXXX with the name of the entity that you want to replace. Like "partner".

```
Using the description at the top of the @README.md file, replace the @Demo.java entity, @DemoService.java , @DemoResource.java  and all the related stuff in the @src/main/webui  folder like @demo.component.ts , etc.  with a new CRUD service for the XXXXXX entity.

That Entity should have the following properties:

- name
- description
- website
- phone
- email
- address
- city
- state
- zip
- country
```

# TODO later after implementing your first feature

- [ ] remove all references to `demo` in the entire project
- [ ] remove all files with `demo` in their name
