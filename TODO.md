# TODO

These TODOs are to be resolved by the developer, NOT THE LLM.

## Before Each Release

- upgrade all and check security issues in github
- update docs to describe the changes

## Today

- consolidate sql scripts
- simplify the overviews, they're too long
- make fonts friendlier
- certification on setting up and deploying abstrauth
- send email when feedback is submitted
- let users provide thumbs up for certification / show how many people have the certification
- RateLimitState needs a max size otherwise we will get a memory problem and it can remove ips after a timeout
- move core.IpAddressUtil into abstracore
- move core.RateLimiting into abstracore
- make wizard in core more abstract
- user needs to add the user to the right groups so that they can upload files to the server (var/www and etc/nginx)
- stripe integration
- create pdf for downloading
- badges
- track stats of how long a certification takes? that means updating cookie policy etc.
- become gdpr compliant, well need to store data first
- remove reference to pageant until we do the hardening certificate
- make many answers longer so that the right one isn't always the longest one!
- provide an instruction that allows the user to enter the hostname, not just it's ip address. add that to the ssh client page and refer to it on the nginx page.
- persistence for when answers are sent, IF the user is signed in
- fix budgets in angular.json -> 5.5 mb is WAY to big
- check we randomize the answers, not just the questions
- add copyright notices to the source files
- make abstracertification check things that are available online or get the user to paste things that it can verify that the user has actually done the work
- add links to other certifications on pages and at the end of a certification
  - show certification paths to becoming an abstratium professional
- create a markdown document in the docs folder to describe the certification modules that can be added to the webui/public folder which describes the way in which you can configure modules and their pages including all the options that exist. it should act as a specification for future engineers and LLMs.
- change lines like the following so that they use console.debug
  - `console.log('[DEBUG] choiceSelectionsChange:', selections);`
- move wizard which is in core back up to abstracore
- let user add notes
- let user supply feedback
- gamify the whole thing
- make LLM a paid feature, altho give a few cents of free credit to try it out. like X tokens and once they are used, they have to purchase something
- add i18n at a cost using an llm
- further modules
  - remote desktop on linux
  - security and hardening with optional remote internet access to the server.
    - fail2ban
    - disk encryption using abstravault
    - firewall
    - disable ping
    - ssh hardening including certificate based authentication
    - nginx rate limiting
    - etc.
  - wireguard vpn (peer to peer but as "client" and "server")
  - SSL with certbot from letsencrypt
    - including how to make it so that they are auto updated
  - move ai help to be part of the certification definition, not for the entire server. or "as well as"

- [ ] - Update SECURITY_DESIGN.md with project-specific information
- [ ] - Update SECURITY.md with project-specific information
- [ ] - Update `.windsurf` configuration

## FIXME

- **SECURITY_DESIGN.md**: File not found at `docs/security/SECURITY_DESIGN.md` — needs to be created or the link in README.md needs updating.
- **`.windsurf` configuration**: The `.windsurf/rules/` files may need project-specific updates (no TODOs found currently).
- **e2e-tests/pages/TODO.page.ts**: This file should be deleted — a replacement `certification.page.ts` has been created.




# TODO later after implementing your first feature

- remove all references to `demo` in the entire project
- remove all files with `demo` in their name
- add contact table (see migration script V01.014__) to GDPR management
- add user-certifications to GDPR management




## Tomorrow


## Later (not yet necessary for initial release)


