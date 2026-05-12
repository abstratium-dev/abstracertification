-- ============================================================
-- Introduction to Security Testing — Part 2
-- Pages 5-8
-- ============================================================

-- ============================================================
-- PAGE 5: Roles and Responsibilities
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-05', 'intro-security-testing', 'roles-and-responsibilities',
'Roles and Responsibilities',
'A security testing engagement involves more people than just the tester with the laptop. There is the client''s CISO who signed the contract, the project manager keeping the timeline on track, the developer who will receive the findings and have to fix them, the tester''s technical lead who reviews the methodology, and the legal team who approved the scope. Understanding who does what — and who is responsible when things go wrong — is essential whether you are managing a test, commissioning one, or starting a career in security.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-05-1', 'ist-step-05', 'CISO — Chief Information Security Officer',
'The CISO is the most senior security role in an organisation. They own the security strategy, manage risk, oversee compliance, and are accountable to the board when things go wrong. In a security testing context, the CISO typically authorises engagements, receives the executive summary of findings, and owns the decision about whether to accept or remediate risks. In smaller organisations this role may be combined with IT Director or handled by a virtual CISO (vCISO).',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-05-2', 'ist-step-05', 'Penetration Tester',
'The penetration tester conducts the test. Technical skills across networking, operating systems, web applications, and attack techniques are necessary — but equally important are communication skills, methodology, and professional judgement. A good pen tester does not just find vulnerabilities; they contextualise them, assess real-world impact, and write findings in a way both engineers can act on and executives can understand.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-05-3', 'ist-step-05', 'Security Champion',
'A security champion is a developer or engineer within a product team who takes on responsibility for security in their immediate area — not as a full-time security professional, but as a bridge between development and security. They attend security training, review code for obvious vulnerabilities, and raise security concerns in sprint planning. The security champion model is one of the most cost-effective ways to scale security across a large engineering organisation.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-05-4', 'ist-step-05', 'Client vs Vendor Responsibilities',
'In a security testing engagement, the client (organisation being tested) must provide accurate scope, grant access, designate an emergency contact, and remediate findings. The vendor (testing firm) must stay within scope, apply professional methodology, produce an accurate report, and maintain confidentiality. When something goes wrong, a clear understanding of who owns what prevents disputes and protects both parties.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-05-5', 'ist-step-05', 'DevSecOps Engineer',
'DevSecOps engineers sit at the intersection of development, operations, and security. Where traditional security testing was a gate at the end of delivery ("the pen test before go-live"), DevSecOps engineers build security checks into the development pipeline so vulnerabilities are caught as code is written. They own the SAST and DAST tools in the CI/CD pipeline and work closely with both developers and security testers.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-05-1', 'ist-step-05',
'Here is a typical security testing engagement showing how the roles interact:',
NULL, NULL,
'graph TD
    Board["Board / Executive\nAuthorises budget"] -->|authorises| CISO["CISO\nSigns engagement"]
    CISO -->|commissions| Vendor["Testing Firm"]
    CISO -->|briefs| PM["Internal Project Manager"]
    PM -->|coordinates| Dev["Development / IT Team"]
    Vendor -->|delivers findings to| CISO
    Vendor -->|managed by| TestLead["Lead Tester"]
    TestLead -->|manages| Testers["Penetration Testers"]
    Dev -->|remediates from| Report["Test Report"]
    SC["Security Champions"] -->|advise| Dev',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-05-2', 'ist-step-05',
'One role often overlooked is the emergency contact — someone on the client side reachable at any hour during the test. If a tester accidentally takes down a production system, or discovers evidence of an active breach by a real attacker, someone must be reachable immediately. This person''s phone number should be on the rules of engagement document before the test starts.',
NULL,
'In 2019, a pen testing team discovered mid-engagement that a real attacker had already compromised the same server they were testing. They immediately called the emergency contact and stood down. The real breach was contained within hours because of the rapid escalation.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-05-3', 'ist-step-05',
'For someone starting in the industry, it is worth knowing that most security testers began as system administrators, developers, or network engineers. The helpdesk role you may already have is surprisingly good preparation — you understand how systems work in the real world, how users behave, and how things break. Security testing adds a layer of adversarial thinking on top of that foundation.',
NULL,
'Some of the best pen testers started in IT support. They knew exactly which tickets kept coming in, which systems were held together with duct tape, and which employees always forgot their passwords — insider knowledge that is invaluable when thinking like an attacker.',
NULL, 2);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-05-1', 'ist-step-05', 'q05-1', 'Who is ultimately accountable for an organisation''s overall security posture?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-05-1a', 'ist-q-05-1', 'The penetration testing vendor', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-05-1b', 'ist-q-05-1', 'The CISO (Chief Information Security Officer)', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-05-1c', 'ist-q-05-1', 'The lead penetration tester', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-05-1d', 'ist-q-05-1', 'The development team, since they write the code', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-05-2', 'ist-step-05', 'q05-2', 'What is the primary purpose of a security champion within a development team?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-05-2a', 'ist-q-05-2', 'To replace the need for external penetration testing', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-05-2b', 'ist-q-05-2', 'To act as a bridge between the development team and the security function, promoting security awareness and catching issues early', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-05-2c', 'ist-q-05-2', 'To conduct penetration tests on their own team''s systems', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-05-2d', 'ist-q-05-2', 'To manage GDPR compliance for the development team', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-05-3', 'ist-step-05', 'q05-3', 'Why is an emergency contact essential in a penetration testing engagement?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-05-3a', 'ist-q-05-3', 'So the tester can request additional time or resources', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-05-3b', 'ist-q-05-3', 'So there is someone reachable at any time who can make immediate decisions if a system is accidentally disrupted or a real breach is discovered', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-05-3c', 'ist-q-05-3', 'To provide the tester with additional credentials during the test', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-05-3d', 'ist-q-05-3', 'It is a legal requirement under GDPR', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-05-4', 'ist-step-05', 'q05-4', 'Which of the following is a responsibility of the CLIENT in a security testing engagement?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-05-4a', 'ist-q-05-4', 'Choosing which vulnerabilities to include in the final report', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-05-4b', 'ist-q-05-4', 'Providing accurate scope, granting access, and remediating findings after the test', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-05-4c', 'ist-q-05-4', 'Writing the penetration testing methodology used by the vendor', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-05-4d', 'ist-q-05-4', 'Maintaining confidentiality of the test report on behalf of the vendor', FALSE, 3);

-- ============================================================
-- PAGE 6: Organisational Security Programmes
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-06', 'intro-security-testing', 'organisational-security-programmes',
'Organisational Security Programmes',
'A single pen test is a snapshot. It tells you how secure your system was on the day the tester was looking at it. The next day, a developer pushes new code, an administrator changes a configuration, a new vulnerability is disclosed, or an employee opens a phishing email. Security is not a destination — it is a programme. Organisations that take security seriously build systematic programmes that make security a continuous, embedded part of how they operate, not a one-off exercise commissioned when someone asks for it.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-06-1', 'ist-step-06', 'Security Policy',
'A security policy is a formal document that defines an organisation''s security objectives, the rules everyone must follow, and who is responsible for what. Examples include an Acceptable Use Policy (what employees can and cannot do with company systems), a Password Policy, and an Incident Response Policy (what to do when something goes wrong). Policies are the foundation of a security programme — without them, security decisions are ad hoc and inconsistent.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-06-2', 'ist-step-06', 'Risk Register',
'A risk register is a living document that tracks every identified security risk, its likelihood, its potential impact, who owns it, and what is being done about it. Risks can be: mitigated (controls reduce the risk), accepted (tolerated because fixing it costs more than the potential harm), transferred (insured against), or avoided (the risky activity is stopped). A risk register makes risk management systematic rather than a matter of whoever shouts loudest.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-06-3', 'ist-step-06', 'Secure Development Lifecycle (SDL)',
'The Secure Development Lifecycle is a framework for embedding security into every phase of software development. Microsoft pioneered the SDL after a catastrophic series of Windows XP vulnerabilities in the early 2000s led Bill Gates to write his famous "Trustworthy Computing" memo. Microsoft halted all Windows Server development for two months to retrain every developer in secure coding. The SDL that emerged became an industry standard.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-06-4', 'ist-step-06', 'Shift-Left Security',
'Shift-left is the idea of moving security activities earlier in the development timeline. A vulnerability found during design costs almost nothing to fix. The same vulnerability found after deployment can cost thousands or millions. Shift-left means developers think about security as they code, not after the fact. It requires training, tools integrated into IDEs and build pipelines, and a culture where developers feel empowered to raise security concerns.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-06-1', 'ist-step-06',
'Here is how security testing fits within a broader organisational security programme:',
NULL, NULL,
'graph LR
    Policy["Security Policies"] --> SDL["Secure Development Lifecycle"]
    SDL --> TM["Threat Modelling\nDesign phase"]
    TM --> CR["Code Review\nBuild phase"]
    CR --> ST["Security Testing\nPre-release"]
    ST --> VM["Vulnerability Management\nPost-release"]
    VM --> IR["Incident Response\nIf breach occurs"]
    IR --> Policy
    RR["Risk Register"] -.->|informs all stages| SDL',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-06-2', 'ist-step-06',
'The Microsoft SDL story is worth knowing. After Windows XP launched in 2001 with a catastrophic number of vulnerabilities — enabling worms like Blaster and Sasser to infect millions of machines — Bill Gates sent an internal memo declaring "Trustworthy Computing" the company''s top priority. The SDL that emerged became an industry standard. It is a powerful reminder that security programmes are often born from painful failures.',
NULL,
'The Blaster worm that exploited Windows XP vulnerabilities in 2003 cost businesses an estimated $320 million and caused significant reputational damage to Microsoft. Pain like that tends to change cultures permanently.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-06-3', 'ist-step-06',
'For someone starting in the industry, understanding that security testing sits inside a larger programme is essential context. When a client commissions a pen test, it is not the first or last thing they should be doing — it is one checkpoint in an ongoing programme. Your job as a tester is to support that programme, not be a substitute for it.',
NULL, NULL, NULL, 2);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-06-1', 'ist-step-06', 'q06-1', 'What is the purpose of a risk register?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-06-1a', 'ist-q-06-1', 'A list of all vulnerabilities found in the latest pen test', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-06-1b', 'ist-q-06-1', 'A living document that tracks identified risks, their likelihood and impact, ownership, and what is being done about them', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-06-1c', 'ist-q-06-1', 'A register of all employees who have access to sensitive systems', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-06-1d', 'ist-q-06-1', 'A legal document listing the organisation''s data protection obligations', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-06-2', 'ist-step-06', 'q06-2', 'What event prompted Microsoft to create the Secure Development Lifecycle?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-06-2a', 'ist-q-06-2', 'A major financial fraud committed by a Microsoft employee', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-06-2b', 'ist-q-06-2', 'The catastrophic vulnerabilities in Windows XP exploited by worms like Blaster, which led to Bill Gates'' "Trustworthy Computing" memo', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-06-2c', 'ist-q-06-2', 'A regulatory requirement from the US government', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-06-2d', 'ist-q-06-2', 'Competition from Linux, which was considered more secure at the time', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-06-3', 'ist-step-06', 'q06-3', 'What does "shift-left" mean in the context of security?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-06-3a', 'ist-q-06-3', 'Moving security responsibilities from the vendor to the client', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-06-3b', 'ist-q-06-3', 'Moving security activities earlier in the development timeline so vulnerabilities are caught during design and coding rather than after deployment', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-06-3c', 'ist-q-06-3', 'Shifting budget from security operations to security testing', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-06-3d', 'ist-q-06-3', 'Replacing human testers with automated tools', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-06-4', 'ist-step-06', 'q06-4', 'Which of the following is NOT a standard way of handling a risk on a risk register?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-06-4a', 'ist-q-06-4', 'Mitigate (reduce the risk with controls)', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-06-4b', 'ist-q-06-4', 'Accept (tolerate the risk)', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-06-4c', 'ist-q-06-4', 'Escalate (refer it to a higher authority who has more budget)', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-06-4d', 'ist-q-06-4', 'Transfer (insure against the risk)', FALSE, 3);

-- ============================================================
-- PAGE 7: Standards, Frameworks, and Certifications
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-07', 'intro-security-testing', 'standards-frameworks-certifications',
'Standards, Frameworks, and Certifications',
'Imagine a hospital hiring a surgeon. They would not just take the candidate''s word for it — they would want to know where they trained, what qualifications they hold, and whether they follow recognised clinical practices. Security testing is no different. Clients need confidence that testers know what they are doing, that their methodology is sound, and that their findings can be trusted. The answer is a rich ecosystem of standards, frameworks, and professional certifications. This page maps that ecosystem.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-07-1', 'ist-step-07', 'OWASP',
'The Open Worldwide Application Security Project (OWASP) is a non-profit foundation that produces free, open resources for improving web application security. Its most famous output is the OWASP Top 10 — a regularly updated list of the most critical web application security risks. Every web pen tester knows it, and most compliance frameworks reference it. OWASP also publishes the WSTG (Web Security Testing Guide), a comprehensive methodology for web application assessments.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-07-2', 'ist-step-07', 'PTES — Penetration Testing Execution Standard',
'PTES is a community-developed framework that defines a standard methodology for penetration testing, covering seven phases: pre-engagement interactions, intelligence gathering, threat modelling, vulnerability analysis, exploitation, post-exploitation, and reporting. It is not a certification or a compliance framework — it is a practical guide for testers that allows clients to compare quality across different vendors.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-07-3', 'ist-step-07', 'ISO 27001',
'ISO 27001 is the international standard for information security management systems (ISMS). An organisation that achieves ISO 27001 certification has demonstrated a systematic approach to managing information security risk. Security testing is explicitly required by ISO 27001. For clients, asking whether their testing vendor holds ISO 27001 is one quality indicator; for testers, understanding the standard helps them understand the context in which their work sits.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-07-4', 'ist-step-07', 'OSCP — Offensive Security Certified Professional',
'OSCP is one of the most respected technical certifications in penetration testing. It is awarded by Offensive Security after a gruelling 24-hour hands-on exam in which candidates must compromise a set of machines in a laboratory environment with no internet access. Unlike multiple-choice certifications, OSCP proves practical skill. It is widely regarded as the entry-level gold standard for offensive security practitioners.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-07-5', 'ist-step-07', 'CREST',
'CREST is a not-for-profit accreditation body that certifies both testing companies and individual testers. In the UK, many government and financial sector organisations require their pen testing vendors to hold CREST accreditation. CREST examinations test both technical knowledge and professional conduct. CREST-accredited companies are regularly audited to ensure they maintain quality standards.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-07-1', 'ist-step-07',
'Here is how the main standards and certifications relate to each other:',
NULL, NULL,
'graph TD
    ISO["ISO 27001\nOrganisational standard\nwhat to achieve"]
    OWASP["OWASP\nWeb application guidance\nhow to test it"]
    PTES["PTES\nPen test methodology\nhow to structure the work"]
    NIST["NIST SP 800-115\nUS government guidance"]
    OSCP["OSCP\nIndividual certification\npractical skill"]
    CREST["CREST\nCompany and individual\naccreditation"]
    CEH["CEH\nEntry-level knowledge\ncertification"]
    ISO -->|requires security testing structured by| PTES
    PTES -->|used alongside| OWASP
    PTES -->|used alongside| NIST
    OSCP -->|proves skills for| PTES
    CREST -->|accredits firms using| PTES',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-07-2', 'ist-step-07',
'The OWASP Top 10 2021 edition lists the most critical web application risks. Number one is Broken Access Control — meaning more systems have access control flaws than any other category. It rose from number five in 2017, reflecting the explosion of APIs and microservices where there are vastly more access control decisions to get right.',
NULL,
'The full 2021 OWASP Top 10: (1) Broken Access Control, (2) Cryptographic Failures, (3) Injection, (4) Insecure Design, (5) Security Misconfiguration, (6) Vulnerable and Outdated Components, (7) Identification and Authentication Failures, (8) Software and Data Integrity Failures, (9) Security Logging and Monitoring Failures, (10) Server-Side Request Forgery.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-07-3', 'ist-step-07',
'If you are thinking about a career in security testing, a realistic progression looks like: CompTIA Security+ (broad knowledge foundation) → CEH (ethical hacking concepts) → OSCP (practical skills, the real credibility milestone) → CREST CRT (UK professional accreditation). The OSCP is where most people say their career truly began, because it forces you to actually do the thing, not just read about it.',
NULL, NULL, NULL, 2);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-07-1', 'ist-step-07', 'q07-1', 'What is the OWASP Top 10?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-07-1a', 'ist-q-07-1', 'A list of the top ten security testing companies in the world', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-07-1b', 'ist-q-07-1', 'A regularly updated list of the most critical web application security risks, widely used as a testing standard', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-07-1c', 'ist-q-07-1', 'A certification exam with ten modules', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-07-1d', 'ist-q-07-1', 'A tool that automatically scans for the ten most common web vulnerabilities', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-07-2', 'ist-step-07', 'q07-2', 'Why is the OSCP certification considered particularly credible?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-07-2a', 'ist-q-07-2', 'It is the most expensive certification available', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-07-2b', 'ist-q-07-2', 'It requires a 24-hour practical exam where candidates must actually compromise machines in a lab, proving real hands-on skill', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-07-2c', 'ist-q-07-2', 'It is endorsed by ISO and legally required in most jurisdictions', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-07-2d', 'ist-q-07-2', 'It covers the widest range of topics of any security certification', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-07-3', 'ist-step-07', 'q07-3', 'What does ISO 27001 certify?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-07-3a', 'ist-q-07-3', 'That a company''s software has no known vulnerabilities', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-07-3b', 'ist-q-07-3', 'That an organisation has a systematic, audited approach to managing information security risk', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-07-3c', 'ist-q-07-3', 'That an individual has passed a security knowledge exam', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-07-3d', 'ist-q-07-3', 'Compliance with GDPR data protection requirements', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-07-4', 'ist-step-07', 'q07-4', 'What was the number one entry in the OWASP Top 10 2021 edition?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-07-4a', 'ist-q-07-4', 'SQL Injection', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-07-4b', 'ist-q-07-4', 'Cross-Site Scripting (XSS)', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-07-4c', 'ist-q-07-4', 'Broken Access Control', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-07-4d', 'ist-q-07-4', 'Security Misconfiguration', FALSE, 3);

-- ============================================================
-- PAGE 8: Scoping and Rules of Engagement
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-08', 'intro-security-testing', 'scoping-and-rules-of-engagement',
'Scoping and Rules of Engagement',
'In 2018, a pen testing team was given a contract to test a retailer''s e-commerce platform. The statement of work said "all systems at retail-example.com." The team discovered that checkout was processed by a payment gateway hosted at a completely different domain — a different company with no authorisation given. The lead tester made the right call: stopped immediately, called the client, and documented the finding. The rules of engagement are not bureaucracy — they are the guardrails that keep everyone safe and legal. Getting scope right before a test starts is the most important thing a tester can do.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-08-1', 'ist-step-08', 'Scope',
'Scope defines exactly what is and is not included in a security test — typically IP address ranges, domain names, web application URLs, physical locations, and specific services included. A tightly defined scope protects both parties: the client knows exactly what was tested, and the tester knows exactly what they are authorised to do. Scope creep (informally expanding scope during the test) is a risk that must be actively managed.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-08-2', 'ist-step-08', 'Rules of Engagement (RoE)',
'Rules of Engagement define the conditions under which a test is conducted: allowed hours (some tests only run outside business hours), forbidden actions (no denial-of-service attacks, no modification of production data), the emergency stop procedure, and contact details for both parties. The RoE document is signed before any testing begins. It is the playbook everyone refers back to when something unexpected happens.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-08-3', 'ist-step-08', 'Emergency Stop Procedure',
'An emergency stop is a pre-agreed signal that immediately halts all testing. It is triggered when a system is accidentally taken offline, real personal data is encountered unexpectedly, or evidence of an active real-world attack is discovered. The procedure should include a code word or phrase, the emergency contact''s direct phone number (not just email), and a clear expectation that all testing activity stops within minutes.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-08-4', 'ist-step-08', 'Accidental Discovery',
'During a test, a tester may encounter something outside scope — a connected system, a third-party service, or evidence that a real attacker is already present. The professional response: stop testing the affected area, preserve evidence (screenshots and logs), notify the client emergency contact immediately, and document everything. Continuing to test while a real attack is in progress could contaminate forensic evidence needed for prosecution.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-08-1', 'ist-step-08',
'A good rules of engagement document answers these questions before the first test begins:',
NULL, NULL,
'graph TD
    Q1["What systems are in scope?"]
    Q2["What systems are explicitly out of scope?"]
    Q3["What testing methods are permitted?"]
    Q4["What are the allowed hours?"]
    Q5["Who is the emergency contact?"]
    Q6["What is the emergency stop procedure?"]
    Q7["How are findings communicated during the test?"]
    Q8["How is the report delivered and stored?"]',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-08-2', 'ist-step-08',
'Scoping is collaborative — not something the tester defines alone. The client must provide a full and accurate description of their environment. Hidden systems (a forgotten test server still on the network), undocumented integrations (a third-party API used by the mobile app), and inherited infrastructure (systems from an acquisition) are all scope risks. A pre-engagement discovery meeting where the tester asks probing questions is essential.',
NULL,
'A useful question to ask every client before a test: "Are there any systems that interact with the ones in scope that are NOT owned by your organisation?" This single question surfaces third-party risks the client may never have considered.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-08-3', 'ist-step-08',
'The difference between "in scope" and "fair game" matters. Just because a system is in scope does not mean every action against it is permitted. A production database server might be in scope for scanning and vulnerability identification but explicitly excluded from exploitation attempts that could corrupt live data. Scope tells you what to look at; rules of engagement tell you how far you can go.',
NULL, NULL, NULL, 2);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-08-1', 'ist-step-08', 'q08-1', 'What is the primary purpose of a Rules of Engagement document?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-08-1a', 'ist-q-08-1', 'To list the vulnerabilities the tester expects to find', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-08-1b', 'ist-q-08-1', 'To define the conditions, constraints, and emergency procedures for a security test before it begins', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-08-1c', 'ist-q-08-1', 'To provide legal protection to the client if the tester causes damage', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-08-1d', 'ist-q-08-1', 'To replace the need for a signed contract', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-08-2', 'ist-step-08', 'q08-2', 'A pen tester discovers evidence mid-test that a real attacker is currently active on the same server. What should they do?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-08-2a', 'ist-q-08-2', 'Continue testing to gather more information about the attacker''s techniques', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-08-2b', 'ist-q-08-2', 'Stop testing, preserve evidence, and immediately notify the client emergency contact', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-08-2c', 'ist-q-08-2', 'Attempt to remove the attacker from the system using the tester''s access', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-08-2d', 'ist-q-08-2', 'Note it and include it in the final report at the end of the engagement', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-08-3', 'ist-step-08', 'q08-3', 'Why should the client provide a full and accurate description of their environment during scoping?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-08-3a', 'ist-q-08-3', 'So the tester can invoice the correct amount', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-08-3b', 'ist-q-08-3', 'Because hidden systems and undocumented integrations could be tested without authorisation or missed entirely, creating legal and security risks', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-08-3c', 'ist-q-08-3', 'So the tester can choose which vulnerabilities to prioritise finding', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-08-3d', 'ist-q-08-3', 'It is not the client''s responsibility — the tester should discover the environment independently', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-08-4', 'ist-step-08', 'q08-4', 'A database server is listed in scope for a pen test. Does this mean the tester can attempt to exploit it in ways that might corrupt live data?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-08-4a', 'ist-q-08-4', 'Yes — being in scope means all actions against it are permitted', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-08-4b', 'ist-q-08-4', 'Not necessarily — scope defines what to look at, but rules of engagement define how far you can go; exploitation that risks corrupting live data may be explicitly excluded', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-08-4c', 'ist-q-08-4', 'Only if the test is a red team exercise, not a standard pen test', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-08-4d', 'ist-q-08-4', 'Yes, provided the tester backs up the data before testing', FALSE, 3);
