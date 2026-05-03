# TODO

These TODOs are to be resolved by the developer, NOT THE LLM.

## Before Each Release

- upgrade all and check security issues in github
- update docs to describe the changes

## Today


- [ ] - Update SECURITY_DESIGN.md with project-specific information
- [ ] - Update SECURITY.md with project-specific information
- [ ] - Update CONTRIBUTING.md with project-specific information
- [ ] - Create favicon, store it in root as zip and put it in `src/main/webui/public`
- [ ] - Update `.windsurf` configuration
- [ ] - Replace `src/main/webui/src/app/demo` with project-specific components
- [ ] - delete the top of this file that talks about the git hook
- [ ] add a new oauth client to your oauth authorization server like abstrauth
- [ ] - delete this TODO list

## FIXME

- **SECURITY_DESIGN.md**: File not found at `docs/security/SECURITY_DESIGN.md` — needs to be created or the link in README.md needs updating.
- **SECURITY.md / CONTRIBUTING.md**: These files exist but may need project-specific review. They did not contain any TODO markers.
- **Favicon**: A custom favicon needs to be created and placed in `src/main/webui/public`.
- **`.windsurf` configuration**: The `.windsurf/rules/` files may need project-specific updates (no TODOs found currently).
- **Demo components**: The demo entity, service, resource, and Angular components are still present and functional. Replace them with certification-specific components when ready.
- **OAuth client**: A new OAuth client `abstratium-abstracertification` needs to be registered in abstrauth.
- **e2e-tests/pages/TODO.page.ts**: This file should be deleted — a replacement `certification.page.ts` has been created.

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




## Tomorrow


## Later (not yet necessary for initial release)


