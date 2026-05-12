-- ============================================================
-- Introduction to Security Testing — Part 4
-- Pages 13-16 + page entries
-- ============================================================

-- ============================================================
-- PAGE 13: Security Testing in Agile and DevSecOps
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-13', 'intro-security-testing', 'agile-and-devsecops',
'Security Testing in Agile and DevSecOps',
'In the old world of waterfall software delivery, the pen test happened at the end — a gate before go-live. Teams would spend six months building something, then send it to security testers, who would spend two weeks finding all the problems that would now be expensive to fix. In the modern world of agile sprints and continuous delivery, code ships every day. A pen test every six months cannot keep up. This page explains how security testing has evolved to match the pace of modern software development.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-13-1', 'ist-step-13', 'SAST — Static Application Security Testing',
'SAST tools analyse source code, bytecode, or binaries for security vulnerabilities without running the application. They are integrated into the developer''s IDE or the CI/CD pipeline and report issues as code is written or committed. Think of SAST as a spell-checker for security: it flags potential issues in real time, before the code ever runs. Common SAST tools include SonarQube, Semgrep, and Checkmarx. SAST catches things like hard-coded credentials, SQL injection patterns, and insecure cryptographic functions.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-13-2', 'ist-step-13', 'DAST — Dynamic Application Security Testing',
'DAST tools test a running application by sending it malicious inputs and observing how it responds — essentially an automated pen test. Where SAST reads code, DAST actually attacks the running system. DAST tools like OWASP ZAP and Burp Suite''s automated scanner can be integrated into CI/CD pipelines to run against a staging environment on every deployment. DAST finds vulnerabilities that only appear at runtime, such as authentication bypasses and insecure session management.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-13-3', 'ist-step-13', 'SCA — Software Composition Analysis',
'SCA tools scan a project''s dependencies — the third-party libraries and frameworks it uses — for known vulnerabilities. The Log4Shell vulnerability of 2021 (one of the most critical ever found) affected millions of applications simply because they used a popular Java logging library called Log4j. SCA tools like Dependabot, Snyk, and OWASP Dependency-Check alert teams when a dependency has a published CVE, so they can update it before attackers exploit it.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-13-4', 'ist-step-13', 'Security User Stories',
'In agile development, user stories define features from the user''s perspective ("As a user, I want to reset my password so that I can regain access to my account"). Security user stories define security requirements the same way ("As a system, I must lock an account after five failed login attempts so that brute-force attacks are prevented"). Writing security requirements as user stories puts them in the same backlog as feature work, making them visible, estimable, and deliverable like any other requirement.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-13-1', 'ist-step-13',
'Here is how security testing fits into a modern CI/CD pipeline:',
NULL, NULL,
'graph LR
    Code["Developer\nwrites code"] --> SAST["SAST\nScans code\nin IDE / on commit"]
    SAST --> Build["Build\nCI pipeline"]
    Build --> SCA["SCA\nChecks dependencies\nfor known CVEs"]
    SCA --> Deploy["Deploy to\nStaging"]
    Deploy --> DAST["DAST\nAttacks running\napplication"]
    DAST --> Review["Security Gate\nPass or fail?"]
    Review -->|Pass| Prod["Deploy to\nProduction"]
    Review -->|Fail| Fix["Developer\nfixes finding"]
    Fix --> Code',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-13-2', 'ist-step-13',
'Log4Shell, discovered in December 2021, is the perfect illustration of why SCA matters. The Log4j library was used in millions of applications — from Minecraft to enterprise software to government systems. A single line of specially crafted text could cause any application using Log4j to execute arbitrary code from the internet. Within 72 hours of disclosure, attackers worldwide were scanning for vulnerable systems. Organisations with SCA tooling in place knew within hours which of their applications were affected. Those without it were scrambling for weeks.',
NULL,
'Log4Shell (CVE-2021-44228) received the maximum CVSS score of 10.0 and is considered one of the most dangerous vulnerabilities ever disclosed. It affected an estimated 3 billion devices worldwide. The vulnerability had existed in the code for eight years before it was discovered.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-13-3', 'ist-step-13',
'Even in a DevSecOps world, automated tools do not replace human pen testers. SAST, DAST, and SCA are excellent at finding known patterns and classes of vulnerability — but they miss logic flaws, business context issues, and novel attack techniques that require human creativity to discover. The right model is: automation catches the common and repeatable issues continuously, human testers focus their time on the complex, contextual, and creative work that machines cannot do.',
NULL, NULL, NULL, 2);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-13-1', 'ist-step-13', 'q13-1', 'What does SAST test?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-13-1a', 'ist-q-13-1', 'A running application by sending it malicious inputs', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-13-1b', 'ist-q-13-1', 'Source code or binaries for security vulnerabilities without running the application', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-13-1c', 'ist-q-13-1', 'Third-party library dependencies for known vulnerabilities', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-13-1d', 'ist-q-13-1', 'Network infrastructure for open ports and services', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-13-2', 'ist-step-13', 'q13-2', 'What type of tool would have most directly helped organisations identify exposure to the Log4Shell vulnerability?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-13-2a', 'ist-q-13-2', 'DAST — by attacking their running applications', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-13-2b', 'ist-q-13-2', 'SCA — by scanning their dependency list for the vulnerable Log4j library', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-13-2c', 'ist-q-13-2', 'SAST — by reviewing their source code for insecure patterns', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-13-2d', 'ist-q-13-2', 'A manual penetration test of their web applications', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-13-3', 'ist-step-13', 'q13-3', 'Do automated security tools (SAST, DAST, SCA) replace the need for human penetration testers?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-13-3a', 'ist-q-13-3', 'Yes — modern tools are comprehensive enough that manual testing is no longer necessary', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-13-3b', 'ist-q-13-3', 'No — automated tools catch known patterns continuously, but human testers are needed for logic flaws, business context issues, and novel attack techniques machines cannot replicate', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-13-3c', 'ist-q-13-3', 'Only for large enterprises — small organisations can rely solely on automated tools', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-13-3d', 'ist-q-13-3', 'Yes, but only when using enterprise-grade tools like Checkmarx or Veracode', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-13-4', 'ist-step-13', 'q13-4', 'What is the benefit of writing security requirements as user stories in agile development?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-13-4a', 'ist-q-13-4', 'It makes the security requirements longer and more detailed', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-13-4b', 'ist-q-13-4', 'It puts security requirements in the same backlog as feature work, making them visible, estimable, and deliverable like any other requirement', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-13-4c', 'ist-q-13-4', 'It means the security team does not need to attend sprint planning meetings', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-13-4d', 'ist-q-13-4', 'User stories are a legal requirement under GDPR for security controls', FALSE, 3);

-- ============================================================
-- PAGE 14: Cloud and Third-Party Considerations
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-14', 'intro-security-testing', 'cloud-and-third-party',
'Cloud and Third-Party Considerations',
'Ten years ago, most organisations ran their own hardware in their own data centres. Testing was relatively straightforward: the servers were yours, you could do what you liked with them. Today, applications run on AWS, Azure, or Google Cloud. Code is served via CDN providers. Authentication is delegated to Okta or Azure AD. Payment is handled by Stripe or Adyen. The organisation''s "system" is a patchwork of services owned by dozens of companies across the globe. Testing that system requires understanding a completely different set of rules.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-14-1', 'ist-step-14', 'Shared Responsibility Model',
'In cloud computing, security responsibility is shared between the cloud provider and the customer. The provider secures the underlying infrastructure (physical hardware, hypervisors, network backbone). The customer secures everything they build on top of it: their applications, their data, their access controls, their network configuration. Misunderstanding this model is one of the most common causes of cloud security incidents. "AWS is secure" does not mean "my application on AWS is secure."',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-14-2', 'ist-step-14', 'Cloud Penetration Testing Rules',
'Cloud providers have specific terms of service governing what testing is permitted on their platforms. AWS, Azure, and GCP all publish penetration testing policies. Generally: testing your own resources is permitted without prior approval, but certain activities (DDoS simulation, port flooding, DNS zone walking) require pre-approval. Testing resources owned by other customers is never permitted — that is just hacking. Violating a cloud provider''s testing policy can result in account termination.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-14-3', 'ist-step-14', 'Supply Chain Security',
'Supply chain attacks target the tools and services that organisations use rather than the organisations themselves. The SolarWinds attack of 2020 is the defining example: attackers compromised the software build process at SolarWinds and inserted malicious code into a legitimate software update. The update was then installed by 18,000 SolarWinds customers — including US government agencies. Testing supply chain security means assessing the security of vendors, open-source dependencies, and build pipelines, not just the final application.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-14-4', 'ist-step-14', 'Third-Party Risk Management',
'When an organisation uses a third-party service, they inherit its security risk. If a payment processor is breached, the organisation''s customers lose their card data. If a HR SaaS provider is compromised, employee personal data leaks. Third-party risk management is the process of assessing, monitoring, and managing the security posture of suppliers and partners. Security questionnaires, vendor audits, contractual security requirements, and requiring ISO 27001 certification from suppliers are all tools in this process.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-14-1', 'ist-step-14',
'Here is how the shared responsibility model divides security between the cloud provider and the customer:',
NULL, NULL,
'graph TD
    subgraph Provider ["Cloud Provider Responsibility"]
        Phys["Physical security\nof data centres"]
        HW["Hardware\n(servers, networking, storage)"]
        Hyper["Hypervisor\nand virtualisation"]
        NetInfra["Core network\ninfrastructure"]
    end
    subgraph Customer ["Customer Responsibility"]
        Data["Data\nencryption and classification"]
        IAM["Identity and Access\nManagement (IAM)"]
        AppCode["Application code\nand configuration"]
        NetConfig["Network configuration\n(security groups, VPCs)"]
        OS["Operating system patching\n(IaaS only)"]
    end',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-14-2', 'ist-step-14',
'The SolarWinds attack is the most instructive supply chain attack in history. Attackers (later attributed to a Russian intelligence service) spent months inside SolarWinds'' development environment, making small changes to ensure their backdoor was included in signed, legitimate software updates. The update passed all standard security checks because it was signed by the real SolarWinds certificate. The lesson: the integrity of your software''s entire build and distribution chain is part of your attack surface.',
NULL,
'The backdoor in SolarWinds'' Orion software was present in updates distributed between March and June 2020 — but was not discovered until December 2020, nine months later. During that time, attackers had silent access to the networks of thousands of organisations including the US Treasury, Department of Homeland Security, and NATO.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-14-3', 'ist-step-14',
'When conducting or commissioning a cloud security test, always verify: which cloud accounts and regions are in scope, which cloud provider''s testing policies apply, whether any multi-tenant services are involved (shared infrastructure where other customers'' data could be affected), and whether the test includes infrastructure-as-code review (checking whether Terraform or CloudFormation templates are correctly configured before they are deployed).',
NULL, NULL, NULL, 2);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-14-1', 'ist-step-14', 'q14-1', 'In the cloud shared responsibility model, who is responsible for securing the data stored in a cloud application?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-14-1a', 'ist-q-14-1', 'The cloud provider — they are responsible for everything on their platform', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-14-1b', 'ist-q-14-1', 'The customer — the cloud provider secures the underlying infrastructure, but the customer is responsible for their data and applications', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-14-1c', 'ist-q-14-1', 'Responsibility is shared equally 50/50 for all layers', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-14-1d', 'ist-q-14-1', 'Neither — the internet service provider is responsible for data security', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-14-2', 'ist-step-14', 'q14-2', 'What made the SolarWinds attack so difficult to detect?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-14-2a', 'ist-q-14-2', 'The attackers used a zero-day vulnerability in Windows that had no patch', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-14-2b', 'ist-q-14-2', 'The malicious code was embedded in a legitimate, digitally signed software update that passed normal security checks', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-14-2c', 'ist-q-14-2', 'SolarWinds used encryption that prevented antivirus tools from scanning the update', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-14-2d', 'ist-q-14-2', 'The attack exploited cloud infrastructure that is outside the customer''s responsibility boundary', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-14-3', 'ist-step-14', 'q14-3', 'Can a penetration tester legally test cloud infrastructure belonging to other customers on the same cloud platform?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-14-3a', 'ist-q-14-3', 'Yes, if they have general authorisation from the cloud provider to test the platform', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-14-3b', 'ist-q-14-3', 'No — testing resources owned by other customers is never permitted; that is simply hacking', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-14-3c', 'ist-q-14-3', 'Yes, but only if the test is limited to port scanning and does not involve exploitation', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-14-3d', 'ist-q-14-3', 'Only if the other customers are in the same organisation', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-14-4', 'ist-step-14', 'q14-4', 'What is the primary purpose of third-party risk management?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-14-4a', 'ist-q-14-4', 'To reduce the cost of procurement by choosing cheaper suppliers', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-14-4b', 'ist-q-14-4', 'To assess, monitor, and manage the security posture of suppliers and partners whose breaches could harm the organisation''s data and customers', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-14-4c', 'ist-q-14-4', 'To ensure third parties comply with the organisation''s software development standards', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-14-4d', 'ist-q-14-4', 'A legal requirement under the Computer Misuse Act', FALSE, 3);

-- ============================================================
-- PAGE 15: Social Engineering and the Human Element
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-15', 'intro-security-testing', 'social-engineering',
'Social Engineering and the Human Element',
'In 2020, a 17-year-old teenager in Florida hacked the Twitter accounts of Barack Obama, Joe Biden, Elon Musk, and Bill Gates simultaneously — not by exploiting a technical vulnerability, but by calling Twitter employees on the phone, pretending to be from the internal IT team, and convincing them to give him access to internal tools. The technical security of Twitter''s systems was irrelevant. The weakest link was a person who had been manipulated. This is social engineering, and it is one of the most effective attack techniques in existence — precisely because it bypasses all your expensive technical defences.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-15-1', 'ist-step-15', 'Phishing',
'Phishing is the practice of sending fraudulent communications (typically emails) that appear to come from a trusted source, with the goal of tricking the recipient into revealing credentials, clicking a malicious link, or opening a malware-laden attachment. Spear phishing is a targeted variant — the attacker researches their victim and crafts a highly personalised message that is much harder to detect. In 2021, 83% of organisations reported experiencing a phishing attack.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-15-2', 'ist-step-15', 'Vishing and Pretexting',
'Vishing (voice phishing) is the phone-call equivalent of phishing — calling someone and pretending to be IT support, a bank, or a regulator to extract information or credentials. Pretexting is the creation of a fabricated scenario (a "pretext") to manipulate someone — for example, calling the helpdesk pretending to be a stranded executive who needs their password reset urgently. Both exploit human psychology: authority, urgency, and trust.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-15-3', 'ist-step-15', 'Physical Social Engineering',
'Physical social engineering involves manipulating people in person. Tailgating (following an authorised person through a secure door), impersonating a courier or maintenance worker, or leaving USB drives in a car park (knowing curious employees will plug them in) are all real attack techniques used by both criminals and red teams. Physical security testing can include attempting to walk into buildings, plant rogue devices on networks, or access server rooms.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-15-4', 'ist-step-15', 'Security Awareness Training',
'Security awareness training is the primary defence against social engineering. It teaches employees to recognise phishing emails, be sceptical of unexpected requests for credentials, verify identities before sharing information, and report suspicious contacts. Effective training uses simulated phishing campaigns — sending employees fake phishing emails and providing immediate training when they click the link. Studies show this significantly reduces susceptibility over time.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-15-1', 'ist-step-15',
'Social engineering attacks exploit predictable human responses. Understanding the psychological triggers attackers use helps both defenders and testers:',
NULL, NULL,
'graph TD
    Trigger["Psychological Triggers\nused in Social Engineering"]
    Trigger --> Auth["Authority\n''I am calling from IT Security''"]
    Trigger --> Urg["Urgency\n''Your account will be locked\nin 10 minutes''"]
    Trigger --> Fear["Fear\n''We have detected a breach\non your account''"]
    Trigger --> Trust["Trust / Familiarity\n''Hi, it is Mike from the\nLondon office''"]
    Trigger --> Scarcity["Scarcity\n''This is your last chance\nto secure your account''"]
    Trigger --> Social["Social Proof\n''Everyone on the team has\nalready done this''"]',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-15-2', 'ist-step-15',
'The ethics of social engineering tests require careful attention. Unlike technical testing where systems cannot feel embarrassed or distressed, social engineering tests target people. Employees who are deceived and "fail" a phishing simulation may feel humiliated. Good programmes focus on positive reinforcement and immediate education, not shame. Tests should have clear authorisation from senior management, defined boundaries (for example, no pretexting that involves personal matters), and a defined process for distressed employees.',
NULL,
'One organisation ran a phishing simulation on the day a company-wide redundancy announcement was being made. The phishing email subject line was "Urgent: Your employment status." Several employees in real distress clicked the link believing it was genuine bad news. The simulation caused significant emotional harm and was a serious mismanagement of the programme.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-15-3', 'ist-step-15',
'For a helpdesk professional, social engineering awareness is directly relevant right now. Helpdesk staff are prime targets for vishing attacks because their job is to help people and they have the access to reset passwords and unlock accounts. The single most important protection is verifying identity before taking any action — using a callback to a known number, verifying a staff ID through a separate system, or following a defined identity verification process that is not dependent on information the caller provides.',
NULL,
'A classic vishing attack targeting helpdesks: "Hi, I am the CEO. I am in an important meeting in Tokyo and I have been locked out of my email. I need you to reset my password right now." The urgency, authority, and time pressure are all calculated to override the normal verification instinct.',
NULL, 2);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-15-1', 'ist-step-15', 'q15-1', 'How did the 2020 Twitter hack compromise accounts of major public figures like Barack Obama?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-15-1a', 'ist-q-15-1', 'By exploiting a critical zero-day vulnerability in Twitter''s application code', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-15-1b', 'ist-q-15-1', 'By calling Twitter employees and socially engineering them into granting access to internal admin tools', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-15-1c', 'ist-q-15-1', 'By breaking the encryption on the accounts'' two-factor authentication', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-15-1d', 'ist-q-15-1', 'By purchasing stolen credentials from a dark web marketplace', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-15-2', 'ist-step-15', 'q15-2', 'What is "spear phishing"?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-15-2a', 'ist-q-15-2', 'A phishing attack that specifically targets email servers', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-15-2b', 'ist-q-15-2', 'A targeted phishing attack where the attacker researches the victim and crafts a highly personalised message that is much harder to detect than generic phishing', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-15-2c', 'ist-q-15-2', 'Phishing that uses phone calls rather than email', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-15-2d', 'ist-q-15-2', 'An automated phishing campaign that sends thousands of emails simultaneously', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-15-3', 'ist-step-15', 'q15-3', 'A caller claims to be the CEO locked out of their email and demands an immediate password reset. What is the correct helpdesk response?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-15-3a', 'ist-q-15-3', 'Reset the password immediately — the CEO is the most important person in the company', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-15-3b', 'ist-q-15-3', 'Verify the caller''s identity through an independent method (callback to a known number, manager verification) before taking any action, regardless of claimed seniority', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-15-3c', 'ist-q-15-3', 'Ask the caller for their staff ID number over the phone — if they know it, reset the password', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-15-3d', 'ist-q-15-3', 'Escalate immediately to the CISO and do nothing until they approve', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-15-4', 'ist-step-15', 'q15-4', 'Why should social engineering simulations focus on positive reinforcement rather than shaming employees who "fail"?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-15-4a', 'ist-q-15-4', 'Because legal regulations prevent disciplinary action for security failures', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-15-4b', 'ist-q-15-4', 'Because shaming creates a culture of fear where employees hide mistakes rather than reporting them — reporting is the most valuable security behaviour to encourage', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-15-4c', 'ist-q-15-4', 'Because employees who are shamed will simply avoid using email', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-15-4d', 'ist-q-15-4', 'There is no reason — shame is an effective motivator and should be used', FALSE, 3);

-- ============================================================
-- PAGE 16: Continuous Security and the Path Forward
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-16', 'intro-security-testing', 'continuous-security-and-path-forward',
'Continuous Security and the Path Forward',
'You have reached the final page of this certification. You now have a map of the entire security testing landscape: the what, the who, the how, the legal frameworks, the ethical foundations, the processes, and the tools. But knowing the map is just the beginning. Security is not a destination you arrive at — it is a practice you maintain. This page ties the threads together and looks ahead: how do organisations measure and improve over time, and what does a career in security testing look like for someone starting out today?',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-16-1', 'ist-step-16', 'Security Maturity Model',
'A security maturity model is a framework for measuring and improving an organisation''s security programme over time. The most widely used is CMMI-based, with five levels: (1) Initial — ad hoc and reactive, (2) Managed — basic processes in place, (3) Defined — standardised and documented processes, (4) Quantitatively Managed — processes measured and controlled, (5) Optimising — continuous improvement based on data. Most organisations operate at level 1 or 2. Reaching level 3 requires the policies, risk registers, and SDLs covered in this certification.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-16-2', 'ist-step-16', 'Threat Intelligence',
'Threat intelligence is information about current and emerging threats — the tactics, techniques, and procedures (TTPs) of active threat actors, newly disclosed vulnerabilities, indicators of compromise from recent breaches, and predictions about future attack trends. Organisations use threat intelligence feeds to stay ahead of attackers: if a new ransomware group is known to target the healthcare sector using a specific technique, healthcare security teams can proactively test and harden against that technique before they are attacked.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-16-3', 'ist-step-16', 'Security Posture',
'Security posture is a holistic assessment of an organisation''s overall security strength — not just the technical defences, but the policies, processes, people, and culture. A good security posture means: vulnerabilities are found and fixed quickly, employees behave securely, incidents are detected and responded to rapidly, and the security programme improves continuously. Security testing is one of the primary tools for measuring and improving security posture.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-16-4', 'ist-step-16', 'Career Paths in Security Testing',
'Security testing is one of the most in-demand career paths in technology. Entry points include: CompTIA Security+ for foundational knowledge, moving into a junior security analyst or junior pen tester role, then progressing through OSCP and CREST certifications. Adjacent paths include: security operations (SOC analyst, incident responder), application security engineering (building security into development), and management (security manager, CISO). The helpdesk experience you may already have is a genuine advantage — it gives you a real-world understanding of systems, users, and how things break.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-16-1', 'ist-step-16',
'Here is how a security maturity programme improves over time as each element from this certification is put in place:',
NULL, NULL,
'graph LR
    L1["Level 1: Initial\nAd hoc pen tests\nNo consistent process"]
    L2["Level 2: Managed\nRegular pen tests\nBasic policies in place\nRisk register started"]
    L3["Level 3: Defined\nSDL in place\nShift-left adopted\nVuln management process\nSecurity champions"]
    L4["Level 4: Quantitatively Managed\nMetrics tracked\nSLA compliance measured\nThreat intelligence feeds\nContinuous DAST/SAST"]
    L5["Level 5: Optimising\nContinuous improvement\nRed team exercises\nBug bounty programme\nSecurity deeply embedded"]
    L1 --> L2 --> L3 --> L4 --> L5',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-16-2', 'ist-step-16',
'The security field moves fast. Attackers share techniques, new vulnerabilities emerge every day, and the technology landscape changes constantly. Staying current is not optional — it is part of the job. The good news is that the community is genuinely collaborative: conferences like DEF CON and Black Hat are where researchers share discoveries, blogs like Krebs on Security and The Register''s security section cover current events, and certifications push you to keep learning.',
NULL,
'DEF CON, held annually in Las Vegas, started in 1993 with 100 attendees. Today it is the largest hacker conference in the world with over 30,000 attendees. It features a "villages" model where specialists run deep-dive sessions on hardware hacking, social engineering, lockpicking, car security, and dozens of other topics. Many attendees describe it as the most intense learning experience of their careers.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-16-3', 'ist-step-16',
'You have now covered the full landscape of security testing. You understand what it is, who does it, the ethics and law that govern it, the processes that structure it, the tools that automate parts of it, and the career that awaits those who pursue it. The next step is up to you: whether that is digging deeper into a technical area, pursuing a certification, or simply approaching your current role with the adversarial mindset that security testing demands — asking not just "does this work?" but "how could this be broken?"',
NULL, NULL, NULL, 2);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-16-1', 'ist-step-16', 'q16-1', 'What does it mean for an organisation to be at "Level 1" of a security maturity model?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-16-1a', 'ist-q-16-1', 'They have achieved the highest level of security certification', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-16-1b', 'ist-q-16-1', 'Their security is ad hoc and reactive — there are no consistent processes and security activity depends on individuals rather than a programme', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-16-1c', 'ist-q-16-1', 'They have completed their first penetration test', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-16-1d', 'ist-q-16-1', 'They only need to address one area of security to reach full compliance', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-16-2', 'ist-step-16', 'q16-2', 'What is threat intelligence and why is it valuable for security testing?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-16-2a', 'ist-q-16-2', 'A tool that automatically scans for threats in real time', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-16-2b', 'ist-q-16-2', 'Information about current and emerging threats — the techniques of active attackers and newly disclosed vulnerabilities — that allows organisations to test and harden proactively', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-16-2c', 'ist-q-16-2', 'A government database of all known cybercriminals', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-16-2d', 'ist-q-16-2', 'The output of a penetration test that is shared with peer organisations', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-16-3', 'ist-step-16', 'q16-3', 'Which of the following would indicate a strong security posture?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-16-3a', 'ist-q-16-3', 'The organisation has never had a security incident', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-16-3b', 'ist-q-16-3', 'Vulnerabilities are found and fixed quickly, employees behave securely, incidents are detected and responded to rapidly, and the security programme improves continuously', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-16-3c', 'ist-q-16-3', 'The organisation has purchased enterprise-grade security tools from multiple vendors', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-16-3d', 'ist-q-16-3', 'The CISO has a CISSP certification', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-16-4', 'ist-step-16', 'q16-4', 'How is helpdesk experience genuinely relevant to a career in security testing?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-16-4a', 'ist-q-16-4', 'It is not relevant — security testing requires completely different skills with no overlap', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-16-4b', 'ist-q-16-4', 'Helpdesk experience provides real-world understanding of how systems work, how users behave, and how things break — a practical foundation that technical knowledge builds on top of', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-16-4c', 'ist-q-16-4', 'Only relevant if the helpdesk role involved managing firewalls', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-16-4d', 'ist-q-16-4', 'Helpdesk experience qualifies someone directly for a senior pen tester role without further training', FALSE, 3);

-- ============================================================
-- Page entries (DIRECT, one per step, in order)
-- ============================================================
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required) VALUES
('ist-pe-01', 'intro-security-testing', 'DIRECT',  0, 'ist-step-01', NULL, NULL, NULL, NULL),
('ist-pe-02', 'intro-security-testing', 'DIRECT',  1, 'ist-step-02', NULL, NULL, NULL, NULL),
('ist-pe-03', 'intro-security-testing', 'DIRECT',  2, 'ist-step-03', NULL, NULL, NULL, NULL),
('ist-pe-04', 'intro-security-testing', 'DIRECT',  3, 'ist-step-04', NULL, NULL, NULL, NULL),
('ist-pe-05', 'intro-security-testing', 'DIRECT',  4, 'ist-step-05', NULL, NULL, NULL, NULL),
('ist-pe-06', 'intro-security-testing', 'DIRECT',  5, 'ist-step-06', NULL, NULL, NULL, NULL),
('ist-pe-07', 'intro-security-testing', 'DIRECT',  6, 'ist-step-07', NULL, NULL, NULL, NULL),
('ist-pe-08', 'intro-security-testing', 'DIRECT',  7, 'ist-step-08', NULL, NULL, NULL, NULL),
('ist-pe-09', 'intro-security-testing', 'DIRECT',  8, 'ist-step-09', NULL, NULL, NULL, NULL),
('ist-pe-10', 'intro-security-testing', 'DIRECT',  9, 'ist-step-10', NULL, NULL, NULL, NULL),
('ist-pe-11', 'intro-security-testing', 'DIRECT', 10, 'ist-step-11', NULL, NULL, NULL, NULL),
('ist-pe-12', 'intro-security-testing', 'DIRECT', 11, 'ist-step-12', NULL, NULL, NULL, NULL),
('ist-pe-13', 'intro-security-testing', 'DIRECT', 12, 'ist-step-13', NULL, NULL, NULL, NULL),
('ist-pe-14', 'intro-security-testing', 'DIRECT', 13, 'ist-step-14', NULL, NULL, NULL, NULL),
('ist-pe-15', 'intro-security-testing', 'DIRECT', 14, 'ist-step-15', NULL, NULL, NULL, NULL),
('ist-pe-16', 'intro-security-testing', 'DIRECT', 15, 'ist-step-16', NULL, NULL, NULL, NULL);
