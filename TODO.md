# TODO

These TODOs are to be resolved by the developer, NOT THE LLM.

## Before Each Release

- upgrade all and check security issues in github
- update docs to describe the changes

## Today

- reduce claude costs. it says:

    You're not using prompt caching

    Add a cache_control block to your requests to reuse expensive context. Most orgs see input costs drop 50–90%.

    see   https://platform.claude.com/docs/en/build-with-claude/prompt-caching

- show message that this is a test env and that no certs can actually be purchased

- fix that refresh loses page history

- integrate toggles - update abstracore to provide caching and interpretation. it should use the id token to build a map and that map can be used. it can add ip address to that too so that later it could base the decision on geolocation.

- put Maxs feedback into certifications

- improve test coverage

- make fonts friendlier

- simplify the overviews, they're too long

- stripe integration

- create pdf for downloading

- badges so that users can add them to their website

- allow signing up in prod, but requires default roles - is that something we already implemented?

- abstrauth should do service token expiry, that is only half built

- fix bug that refresh ruins the url that was in the browser and returns the user to the home page

- add other necessary microservices - see abstrerp

- allow me to sign in
  - if admin then allow to view feedback and contact and enable/disable certifications

- add links to test and prod to README so that it is linked by search engines

- since users can sign up and pay at the end, we need a way to verify that they really did complete all the questions. localstorage should store an encrypted token for each page that was successfully completed, based on a unique ID that is generated for localstorage and supplied when checking the answers. that way the user cannot hack localstorage. the server verifies all of those tokens when the account is opened and stores the information in the users account

- let users provide thumbs up for certification / show how many people have the certification

- user needs to add the user to the right groups so that they can upload files to the server (var/www and etc/nginx)
- track stats of how long a certification takes? that means updating cookie policy etc.
- become gdpr compliant, we'll need to store user data first

- make many answers longer so that the right one isn't always the longest one!
- let signed in users add notes
- gamify the whole thing
- persistence for when answers are sent, IF the user is signed in
- fix budgets in angular.json -> 5.5 mb is WAY to big
- check we randomize the answers, not just the questions
- make abstracertification check things that are available online or get the user to paste things that it can verify that the user has actually done the work
- add links to other certifications on pages and at the end of a certification
  - show certification paths to becoming an abstratium professional
- change lines like the following so that they use console.debug
  - `console.log('[DEBUG] choiceSelectionsChange:', selections);`

- implement stuff for "For Organizations"

- move ai help to be part of the certification definition, not for the entire server. or "as well as"
- make LLM a paid feature, altho give a few cents of free credit to try it out. like X tokens and once they are used, they have to purchase something
- add i18n at a cost using an llm

- RateLimitState needs a max size otherwise we will get a memory problem and it can remove ips after a timeout
- move core.IpAddressUtil into abstracore
- move core.RateLimiting into abstracore
- make wizard in core more abstract
- move wizard which is in core back up to abstracore

- further modules
  - remote desktop on linux
  - security and hardening with optional remote internet access to the server.
    - fail2ban
    - disk encryption using abstravault
    - firewall
    - disable ping
    - ssh hardening including certificate based authentication
    - nginx rate limiting
    - pageant (windows only)
    - etc.
  - wireguard vpn (peer to peer but as "client" and "server")
  - SSL with certbot from letsencrypt
    - including how to make it so that they are auto updated
  - certification on setting up and deploying abstrauth
  - setting up a secure samba server for file sharing
  - use abstravault or a kdg to secure the drive



- **`.windsurf` configuration**: The `.windsurf/rules/` files may need project-specific updates (no TODOs found currently).
- **e2e-tests/pages/TODO.page.ts**: This file should be deleted — a replacement `certification.page.ts` has been created.




# TODO later after implementing your first feature

- add contact table (see migration script V01.014__) to GDPR management
- add user-certifications to GDPR management




## Tomorrow


## Later (not yet necessary for initial release)


