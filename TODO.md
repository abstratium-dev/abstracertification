# TODO

These TODOs are to be resolved by the developer, NOT THE LLM.

## Before Each Release

- upgrade all and check security issues in github
- update docs to describe the changes

## Today

- remove "mba" from publicly used id of business fundamentals cert, using a NEW script.
- add a disclaimer directly to that cert

- advertise that it is AI based, if it is such.

- add a classification field, and group by classification. IT, Business, etc.

- put Maxs feedback into certifications

- improve test coverage

- simplify the overviews, they're too long

- stripe integration

- create pdf for downloading

- badges so that users can add them to their website

- allow signing up in prod, but requires default roles - is that something we already implemented?

- abstrauth should do service token expiry, that is only half built -> in fact, totally redesign that, so its not client based but account based for service accounts

- add other necessary microservices - see abstrerp

- allow me to sign in
  - if admin then allow to view feedback and contact and enable/disable certifications

- add links to test and prod to README so that it is linked by search engines

- since users can sign up and pay at the end, we need a way to verify that they really did complete all the questions. localstorage should store an encrypted token for each page that was successfully completed, based on a unique ID that is generated for localstorage and supplied when checking the answers. that way the user cannot hack localstorage. the server verifies all of those tokens when the account is opened and stores the information in the users account

- let users provide thumbs up for certification / show how many people have the certification

- track stats of how long a certification takes? that means updating cookie policy etc.
- become more gdpr compliant, we'll need to store user data first

- make many answers longer so that the right one isn't always the longest one!
- let signed in users add notes
- gamify the whole thing
- persistence for when answers are sent, IF the user is signed in
- fix budgets in angular.json -> 5.5 mb is WAY to big
- reduce mermaid bundle size — see `docs/ephemeral-and-volatile-and-temporary-but-interesting/MERMAID_LAZY_LOAD.md`
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
  - raspberrypi as print server
  - update cert on business fundamentals so that it doesn't suggest using other services, but suggests using abstratium services
  - business server
    - user needs to add the user to the right groups so that they can upload files to the server (var/www and etc/nginx)
  - remote desktop on linux
  - virtual box and run windsurf inside to avoid LLM breaking out
  - docker and installing some abstratium services to play around, including mysql, grafana, etc.
  - security and hardening with optional remote internet access to the server.
  - hackable server for making an ethical hacking certification fun to do
  - wireguard vpn (peer to peer but as "client" and "server")
  - SSL with certbot from letsencrypt
    - including how to make it so that they are auto updated
  - certification on setting up and deploying abstrauth
  - setting up a secure samba server for file sharing
  - use abstravault or a kdg to secure the drive

- TODO MAKE CHECK_ANSWER_DISTRIBUTION.PY AND CHECK_TERM_LENGTHS.PY GENERAL FOR ALL SCRIPTS!!
- prompts for certification generation.

  - read the following sql files which define a certification: @V01.021__insert_intro_security_testing_part1.sql@V01.022__insert_intro_security_testing_part2.sql@V01.023__insert_intro_security_testing_part3.sql@V01.024__insert_intro_security_testing_part4.sql 

  see @DATABASE.md  which describes the data model.

  now create a new markdown document, similar to @BUSINESS_FUNDAMENTALS_CERTIFICATION_OUTLINE.md , but focused solely on a new certification which covers a professional backup process that small businesses who use linux should implement.

  it needs to also cover theory like 3-2-1 backup, as well as how a company can classify documents to decide on their backup strategy and retention periods.

  - check all of the answers. ensure that in only 25% of the cases, the correct answer is the longest (number of characters). in 50% of cases the correct answer should be longer than two other answers, etc. basically the length should be random and totally unrelated to the correctness. use the python program `scripts/check_answer_distribution.py` to measure distribution.

  - ensure the length of the key concepts are ok for the database. see `scripts/check_term_lengths.py`

  - write the certification so that a young person aged 18-25 will find it interesting and want to continue learning and working. Add anecdotes, stories and facts to support this style of learning.

  - mermaid diagrams should be laid out vertically rather than horizontally.

  - use mermaid diagrams where they support the text and make it easier to understand, and not just because you want to add a picture to each page.



- **`.windsurf` configuration**: The `.windsurf/rules/` files may need project-specific updates (no TODOs found currently).
- **e2e-tests/pages/TODO.page.ts**: This file should be deleted — a replacement `certification.page.ts` has been created.




# TODO later after implementing your first feature

- add contact table (see migration script V01.014__) to GDPR management
- add user-certifications to GDPR management




## Tomorrow


## Later (not yet necessary for initial release)


