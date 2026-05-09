# TODO

These TODOs are to be resolved by the developer, NOT THE LLM.

## Before Each Release

- upgrade all and check security issues in github
- update docs to describe the changes

## Today

- make wizard in core more abstract
- persistence for when answers are sent, IF the user is signed in
- fix budgets in angular.json -> 5.5 mb is WAY to big
- check we randomize the answers, not just the questions
- add copyright notices to the source files
- make abstracertification check things that are available online or get the user to paste things that it can verify that the user has actually done the work
- create a markdown document in the docs folder to describe the certification modules that can be added to the webui/public folder which describes the way in which you can configure modules and their pages including all the options that exist. it should act as a specification for future engineers and LLMs.
- move wizard which is in core back up to abstracore
- let user add notes
- let user supply feedback
- gamify the whole thing
- add LLM support with a system message that is configured in the module. provide it with the current page content but no answers or questions. so that they can get help if they get stuck.
  - this is a paid feature, altho give a few cents of free credit to try it out. like X tokens and once they are used, they have to purchase something
- add i18n at a cost using an llm
- show all of the modules and some of their content which will encourage people to sign in
- remote desktop on linux
- further modules
  - security and hardening with optional remote internet access to the server.
    - fail2ban
    - disk encryption using abstravault
    - firewall
    - ssh hardening
    - nginx rate limiting
    - etc.
  - wireguard vpn (peer to peer but as "client" and "server")
  - SSL with certbot from letsencrypt
    - including how to make it so that they are auto updated


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


