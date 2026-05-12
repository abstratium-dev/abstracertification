-- ============================================================
-- Introduction to Security Testing — Part 3
-- Pages 9-12
-- ============================================================

-- ============================================================
-- PAGE 9: The Testing Lifecycle
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-09', 'intro-security-testing', 'testing-lifecycle',
'The Testing Lifecycle',
'Every security engagement — whether a quick web app pen test or a six-month red team operation — follows a recognisable set of phases. Understanding these phases helps you manage, commission, or conduct security testing with confidence. This page walks through them without the technical detail — focusing on what happens at each stage, why it matters, and what the outputs are. Think of it as the bird''s-eye view of how security testing actually unfolds in the real world.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-09-1', 'ist-step-09', 'Reconnaissance',
'Reconnaissance (or "recon") is the first active phase of a test — gathering information about the target without yet attacking it. This mirrors what a real attacker would do before striking. Open-source intelligence (OSINT) is a major component: searching public records, LinkedIn profiles, job postings, DNS records, GitHub repositories, and social media for information that reveals the target''s technology stack, employee names, network ranges, and potential weaknesses. Good recon makes the rest of the test far more efficient.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-09-2', 'ist-step-09', 'Enumeration',
'Enumeration is the systematic process of identifying exactly what is running on the systems in scope — open ports, running services, software versions, operating system types, user accounts, and network shares. Where reconnaissance casts a wide net to gather public information, enumeration is targeted and precise. The output is a detailed map of the attack surface that guides the exploitation phase.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-09-3', 'ist-step-09', 'Exploitation',
'Exploitation is the phase where the tester attempts to take advantage of the vulnerabilities identified in enumeration. The goal is to confirm that a vulnerability is real and exploitable — not just theoretically possible. A tester might gain unauthorised read access to a file, bypass an authentication control, or execute code on a remote system. Each successful exploitation is documented with evidence: timestamps, screenshots, and proof-of-concept outputs.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-09-4', 'ist-step-09', 'Post-Exploitation',
'Post-exploitation examines what an attacker could do after gaining initial access. Can they move laterally to other systems? Can they escalate privileges to become an administrator? Can they access sensitive data, establish persistence (a backdoor that survives reboots), or exfiltrate information without triggering alerts? Post-exploitation is often where the most impactful findings emerge — a small initial foothold that leads to complete network compromise.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-09-5', 'ist-step-09', 'Clean-Up',
'After testing is complete, a professional tester removes all artefacts they have placed on systems — test accounts created, files uploaded, backdoors installed (even for testing purposes), and configuration changes made. Leaving these in place creates a real security risk. The clean-up phase should be documented: every change made during testing is listed, and its removal confirmed. This is both professional practice and contractual obligation.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-09-1', 'ist-step-09',
'Here is the full testing lifecycle, showing how each phase feeds into the next:',
NULL, NULL,
'graph LR
    A["Planning and Scoping\nDefine RoE, get authorisation"] --> B["Reconnaissance\nGather public information\nOSINT"]
    B --> C["Enumeration\nMap ports, services\nsoftware versions"]
    C --> D["Exploitation\nConfirm vulnerabilities\nare real and exploitable"]
    D --> E["Post-Exploitation\nLateral movement\nprivilege escalation"]
    E --> F["Clean-Up\nRemove all test artefacts"]
    F --> G["Reporting\nDocument findings\nwith evidence"]
    G --> H["Re-test\nVerify fixes worked"]',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-09-2', 'ist-step-09',
'Reconnaissance is the phase that surprises most people new to security. A huge amount of information is publicly available about every organisation. In 2013, hackers compromised Target''s payment systems by finding the credentials of an HVAC contractor who had access to Target''s network — that contractor''s name appeared in a Target supplier portal indexed by Google. The attackers found it through OSINT without ever touching Target''s systems directly.',
NULL,
'OSINT stands for Open-Source Intelligence — information gathered entirely from public sources: websites, social media, public records, job advertisements, conference talks, GitHub commits, and more. Many organisations are shocked by how much an attacker can learn before making a single connection to their systems.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-09-3', 'ist-step-09',
'The re-test phase is often skipped by clients who are trying to save money — but it is essential. A finding is only closed when it has been confirmed as fixed. A developer may have partially patched a vulnerability in a way that prevents the specific exploit the tester used, but leaves the underlying issue in place. Re-testing confirms the fix is complete, not just cosmetic.',
NULL,
'Re-testing should be conducted by the same tester who found the original vulnerability. They know exactly what they did and can verify whether the fix genuinely addresses the root cause.',
NULL, 2);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-09-1', 'ist-step-09', 'q09-1', 'What is the purpose of the reconnaissance phase in a penetration test?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-09-1a', 'ist-q-09-1', 'To immediately attack the target and identify which systems are vulnerable', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-09-1b', 'ist-q-09-1', 'To gather information about the target from public sources before attempting any active testing', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-09-1c', 'ist-q-09-1', 'To map every open port on the target network', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-09-1d', 'ist-q-09-1', 'To write the initial sections of the test report', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-09-2', 'ist-step-09', 'q09-2', 'Why is the clean-up phase important after a penetration test?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-09-2a', 'ist-q-09-2', 'To remove log entries that might reveal the test took place', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-09-2b', 'ist-q-09-2', 'To remove all test artefacts (accounts, backdoors, files) left on systems during the test, which would otherwise create real security risks', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-09-2c', 'ist-q-09-2', 'To delete evidence of any vulnerabilities that could not be exploited', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-09-2d', 'ist-q-09-2', 'Clean-up is optional — most clients do not require it', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-09-3', 'ist-step-09', 'q09-3', 'What does "lateral movement" mean in the post-exploitation phase?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-09-3a', 'ist-q-09-3', 'Moving files from one directory to another on the compromised system', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-09-3b', 'ist-q-09-3', 'Using initial access on one system to gain access to other systems in the network', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-09-3c', 'ist-q-09-3', 'Moving to the next system on the scope list', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-09-3d', 'ist-q-09-3', 'Transferring the test report between team members', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-09-4', 'ist-step-09', 'q09-4', 'Why is re-testing important after a client has fixed a reported vulnerability?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-09-4a', 'ist-q-09-4', 'To give the testing firm additional billable hours', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-09-4b', 'ist-q-09-4', 'To confirm the fix actually works — a partial fix may block the specific exploit used but leave the underlying vulnerability in place', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-09-4c', 'ist-q-09-4', 'To look for new vulnerabilities introduced by the fix', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-09-4d', 'ist-q-09-4', 'Re-testing is not necessary if the developer confirms the fix in writing', FALSE, 3);

-- ============================================================
-- PAGE 10: Reporting and Communication
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-10', 'intro-security-testing', 'reporting-and-communication',
'Reporting and Communication',
'A penetration test that produces a bad report is nearly worthless. The most sophisticated technical work in the world counts for nothing if the findings cannot be understood, prioritised, and acted upon. The report is the primary deliverable — it is what the client paid for, what the board will see, and what the development team will use to fix things. Writing a good security testing report is a craft in its own right, and communicating findings effectively to different audiences is one of the most important skills a security professional can develop.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-10-1', 'ist-step-10', 'CVSS — Common Vulnerability Scoring System',
'CVSS is the industry-standard system for rating the severity of security vulnerabilities. It produces a numerical score from 0.0 to 10.0 based on factors such as how easy it is to exploit the vulnerability, whether it requires network access or physical access, whether authentication is needed, and what the impact would be on confidentiality, integrity, and availability. Scores map to ratings: Critical (9.0–10.0), High (7.0–8.9), Medium (4.0–6.9), Low (0.1–3.9), and Informational (0.0).',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-10-2', 'ist-step-10', 'Executive Summary',
'The executive summary is the first section of a pen test report and is written for a non-technical audience — typically the CISO, board members, and senior management. It should fit on one or two pages and cover: what was tested, what the overall security posture looks like, the most critical findings (without technical jargon), and the recommended priorities. A good executive summary can be read and understood by someone with no security background in under five minutes.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-10-3', 'ist-step-10', 'Technical Annex',
'The technical annex contains the detailed findings for engineers and administrators who will be doing the remediation work. Each finding should include: a title, CVSS score and rating, affected systems, a description of the vulnerability, step-by-step evidence (screenshots, commands used, outputs), the potential impact if exploited by a real attacker, and specific remediation recommendations. The technical annex is not a lecture — it is a working document for people who need to fix things.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-10-4', 'ist-step-10', 'Safe Distribution of Reports',
'A pen test report is one of the most sensitive documents an organisation will ever possess. It must be distributed only to named individuals with a business need, encrypted in transit (never sent as a plain email attachment), and stored securely with access logging. Some organisations require that the report be delivered in person or via an encrypted portal. Physical copies should be treated like classified documents — numbered, tracked, and destroyed when no longer needed.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-10-1', 'ist-step-10',
'A well-structured pen test report has distinct sections for different audiences:',
NULL, NULL,
'graph TD
    Report["Penetration Test Report"]
    Report --> ES["Executive Summary\nFor: CISO, Board\nLanguage: Business\nLength: 1-2 pages"]
    Report --> Scope["Scope and Methodology\nFor: Technical management\nWhat was tested and how"]
    Report --> Findings["Findings Summary\nFor: All\nRisk-rated table of all issues"]
    Report --> Tech["Technical Annex\nFor: Engineers\nStep-by-step evidence\nRemediation guidance"]
    Report --> Retest["Re-test Status\nFor: Project management\nWhat has been fixed"]',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-10-2', 'ist-step-10',
'CVSS scores provide a consistent baseline, but context matters enormously. A Critical-rated vulnerability in an isolated internal test system with no sensitive data is less urgent than a Medium-rated vulnerability in the login page of a system that holds 10 million customer records. Good testers always provide a business risk assessment alongside the CVSS score — translating what the vulnerability means in the specific context of the organisation.',
NULL,
'A common mistake in security reports is treating every Critical finding as equally urgent. A skilled communicator helps the client understand which findings to fix first based on the combination of CVSS score, exploitability in their specific environment, and the value of the data at risk.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-10-3', 'ist-step-10',
'The debrief meeting — a verbal walkthrough of findings with key stakeholders — is as important as the written report. It allows the client to ask questions, understand nuance, and get immediate guidance on priorities. Many clients read the executive summary, attend the debrief, and then hand the technical annex to their engineering team. The debrief is often the only direct conversation the CISO has with the testing team.',
NULL,
'Delivery of a pen test report without a debrief is a missed opportunity. The questions clients ask in a debrief reveal what they actually need to understand — and often surface follow-up work that would not have been apparent from the written report alone.',
NULL, 2);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-10-1', 'ist-step-10', 'q10-1', 'What does a CVSS score of 9.5 indicate?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-10-1a', 'ist-q-10-1', 'A medium-severity vulnerability requiring attention within 30 days', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-10-1b', 'ist-q-10-1', 'A Critical vulnerability — the highest severity band — requiring immediate priority attention', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-10-1c', 'ist-q-10-1', 'The vulnerability affects 9.5% of systems tested', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-10-1d', 'ist-q-10-1', 'The vulnerability has been exploited in 9.5% of real-world attacks', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-10-2', 'ist-step-10', 'q10-2', 'What is the purpose of the executive summary in a pen test report?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-10-2a', 'ist-q-10-2', 'To provide step-by-step technical evidence for each vulnerability found', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-10-2b', 'ist-q-10-2', 'To give non-technical senior management a clear, jargon-free overview of findings and priorities without requiring security expertise to understand', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-10-2c', 'ist-q-10-2', 'To list the testing tools and techniques used during the engagement', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-10-2d', 'ist-q-10-2', 'To provide legal cover for the testing firm', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-10-3', 'ist-step-10', 'q10-3', 'A Critical vulnerability is found in an isolated test server with no sensitive data. A Medium vulnerability is found in the customer login page of a system holding 10 million records. Which should be fixed first?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-10-3a', 'ist-q-10-3', 'The Critical one — CVSS score is the only factor that matters', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-10-3b', 'ist-q-10-3', 'The Medium one on the customer login page — business context and data at risk make it higher priority despite the lower CVSS score', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-10-3c', 'ist-q-10-3', 'Both must be fixed simultaneously — all findings are equally urgent', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-10-3d', 'ist-q-10-3', 'Neither needs to be fixed immediately since neither has been exploited yet', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-10-4', 'ist-step-10', 'q10-4', 'How should a pen test report be distributed to the client?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-10-4a', 'ist-q-10-4', 'As a plain email attachment to all stakeholders so everyone has access', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-10-4b', 'ist-q-10-4', 'Encrypted in transit, only to named individuals with a business need, stored securely with access logging', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-10-4c', 'ist-q-10-4', 'Posted to a public-facing company portal so the board can access it remotely', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-10-4d', 'ist-q-10-4', 'Distribution method does not matter as long as the report is password-protected', FALSE, 3);

-- ============================================================
-- PAGE 11: Working with Sensitive Information
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-11', 'intro-security-testing', 'sensitive-information',
'Working with Sensitive Information',
'During a pen test of a healthcare company, a tester querying a database to confirm a SQL injection vulnerability found themselves looking at 50,000 patient records — names, diagnoses, medications. They had not been looking for this. They had not been asked to access it. But it was there, and they had seen it. What do they do now? This is not a hypothetical — it happens regularly. Security testers routinely encounter deeply sensitive information as a side effect of doing their job. How you handle that information defines your professionalism and your legal standing.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-11-1', 'ist-step-11', 'Data Minimisation',
'Data minimisation means collecting, accessing, and retaining only the minimum amount of data necessary to achieve the testing objective. A tester confirming a SQL injection vulnerability does not need to download the entire database — they need to extract one row of dummy data or a schema entry to prove the vulnerability exists. Extracting more data than necessary creates legal liability, ethical problems, and security risks if that data is later compromised on the tester''s systems.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-11-2', 'ist-step-11', 'Personally Identifiable Information (PII)',
'PII is any information that can be used to identify a specific individual: names, addresses, phone numbers, email addresses, national insurance numbers, medical records, financial data. Under GDPR, PII has a specific legal status — it cannot be collected without lawful basis, must be stored securely, cannot be retained longer than necessary, and any breach must be reported to regulators within 72 hours. A tester who accidentally accesses PII must treat it with the same care as a data controller.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-11-3', 'ist-step-11', 'Secure Deletion',
'At the end of an engagement, all data collected during the test — screenshots, log files, database extracts, credentials, configuration files — must be securely deleted from all systems where it was stored, including laptops, USB drives, cloud storage, and collaboration tools. Standard deletion (putting a file in the recycling bin) is not sufficient — the data remains on the disk until overwritten. Secure deletion tools overwrite the data multiple times, making recovery extremely difficult.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-11-4', 'ist-step-11', 'Chain of Custody',
'Chain of custody is the documented, unbroken record of who has had access to evidence or sensitive data at every point in time. In security testing, this matters when evidence might be used in legal proceedings (for example, if a breach discovered during a test leads to prosecution). Chain of custody documentation shows that evidence has not been tampered with, is authentic, and can be relied upon by lawyers and courts.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-11-1', 'ist-step-11',
'Here is how to handle an accidental encounter with sensitive data during a test:',
NULL, NULL,
'graph TD
    A["Tester accidentally encounters sensitive data\n(PII, medical records, financial data, credentials)"] --> B["Stop accessing the data immediately\nDo not download or copy it"]
    B --> C["Take a minimal screenshot as evidence\nthat the vulnerability exists"]
    C --> D["Notify the client contact immediately\ndo not wait for the report"]
    D --> E["Document the discovery:\ntime, what was seen, what action was taken"]
    E --> F["Assess whether GDPR notification\nrequirements apply"]
    F --> G["Include in report with appropriate\nsensitivity classification"]',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-11-2', 'ist-step-11',
'Test credentials — usernames and passwords used during the engagement — are themselves sensitive data. They must not be reused across engagements, must be stored in an encrypted password manager, and must be either changed or confirmed as deactivated at the end of the test. A set of working credentials for a production system left in an old project folder is a serious security incident waiting to happen.',
NULL,
'In 2022, a security firm was itself breached via a set of client credentials that had been stored in a plain-text file on a former employee''s laptop. The credentials had not been rotated after the engagement ended. This led to data being accessed at a client organisation two years after the test.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-11-3', 'ist-step-11',
'Non-disclosure agreements (NDAs) are standard in security testing engagements. They legally bind the testing team to keep all information about the client, their systems, their vulnerabilities, and their data confidential — typically for several years after the engagement ends. NDAs also cover former employees: a tester who leaves the firm cannot discuss client work at their new employer. Signing an NDA is not just a formality — it is a commitment with real legal consequences.',
NULL, NULL, NULL, 2);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-11-1', 'ist-step-11', 'q11-1', 'What does "data minimisation" mean in the context of security testing?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-11-1a', 'ist-q-11-1', 'Reducing the number of systems included in the test scope', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-11-1b', 'ist-q-11-1', 'Accessing and retaining only the minimum amount of data necessary to confirm a vulnerability exists, rather than extracting more than needed', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-11-1c', 'ist-q-11-1', 'Removing personal data from the test environment before testing begins', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-11-1d', 'ist-q-11-1', 'Minimising the size of the test report', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-11-2', 'ist-step-11', 'q11-2', 'A tester accidentally views 50,000 patient records while confirming a SQL injection vulnerability. What should they do immediately?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-11-2a', 'ist-q-11-2', 'Download the records to provide evidence of the vulnerability''s severity in the report', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-11-2b', 'ist-q-11-2', 'Stop accessing the data, take a minimal screenshot as evidence, and immediately notify the client contact', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-11-2c', 'ist-q-11-2', 'Continue the test and mention it in the report at the end', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-11-2d', 'ist-q-11-2', 'Delete the records to protect the patients'' privacy', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-11-3', 'ist-step-11', 'q11-3', 'Why is standard file deletion (putting it in the recycling bin) not sufficient for disposing of sensitive test data?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-11-3a', 'ist-q-11-3', 'Because the recycling bin does not free up disk space', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-11-3b', 'ist-q-11-3', 'Because standard deletion leaves data on the disk until it is overwritten — it can be recovered with forensic tools. Secure deletion overwrites the data multiple times.', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-11-3c', 'ist-q-11-3', 'Because files in the recycling bin are still visible to other users on the same network', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-11-3d', 'ist-q-11-3', 'Standard deletion is fine as long as the drive is encrypted', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-11-4', 'ist-step-11', 'q11-4', 'What is the purpose of a chain of custody in a security testing context?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-11-4a', 'ist-q-11-4', 'To track which team members worked on which parts of the test for billing purposes', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-11-4b', 'ist-q-11-4', 'To document who has had access to evidence at every point in time, ensuring it has not been tampered with and can be relied upon in legal proceedings', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-11-4c', 'ist-q-11-4', 'To ensure the client signs off on every finding before it is included in the report', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-11-4d', 'ist-q-11-4', 'It is a financial document showing the cost of the engagement', FALSE, 3);

-- ============================================================
-- PAGE 12: Vulnerability Management and Remediation
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-12', 'intro-security-testing', 'vulnerability-management',
'Vulnerability Management and Remediation',
'Finding a vulnerability is the beginning, not the end. After a pen test delivers its report, an organisation faces a pile of findings that must be triaged, assigned, tracked, fixed, and verified. Without a systematic process for doing this, findings sit in a spreadsheet for six months and nothing changes — which means the next pen test finds the same vulnerabilities. Vulnerability management is the discipline that turns security testing findings into real security improvements.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-12-1', 'ist-step-12', 'Vulnerability Management Lifecycle',
'The vulnerability management lifecycle is a repeating cycle: discover (find vulnerabilities through scanning, pen testing, or threat intelligence), prioritise (rank them by risk), remediate (fix them), verify (confirm the fix works), and report (update stakeholders on progress). It is a continuous process — new vulnerabilities emerge constantly as software changes and new CVEs are published, so the cycle never stops.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-12-2', 'ist-step-12', 'SLA and SLO for Remediation',
'Service Level Agreements (SLAs) and Service Level Objectives (SLOs) for vulnerability remediation define how quickly different severity findings must be addressed. A typical policy might require: Critical findings remediated within 24-48 hours, High within 7 days, Medium within 30 days, and Low within 90 days. Without defined timelines, remediation is "whenever someone gets around to it" — which in a busy engineering team often means never.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-12-3', 'ist-step-12', 'Risk Acceptance',
'Not every vulnerability can or will be fixed immediately. Risk acceptance is the formal process by which an organisation acknowledges a vulnerability, understands the risk it poses, and makes a documented decision to tolerate it — at least temporarily. Risk acceptance should be approved by an appropriate authority (usually the CISO or a risk committee), time-limited, and revisited regularly. It is not the same as ignoring a finding.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-12-4', 'ist-step-12', 'Residual Risk',
'Residual risk is the risk that remains after controls and remediations have been applied. No organisation achieves zero risk — the goal is to reduce risk to an acceptable level. Understanding residual risk is important for honest communication with senior management and boards: "We have fixed 40 out of 43 findings. The remaining three are accepted risks with compensating controls in place." This is far more useful than "we passed the pen test."',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-12-1', 'ist-step-12',
'Here is the vulnerability management lifecycle showing how findings flow from discovery to closure:',
NULL, NULL,
'graph LR
    D["Discover\nPen test, scan,\nbug bounty, CVE feed"] --> P["Prioritise\nCVSS + business context"]
    P --> A["Assign\nOwner, deadline (SLA)"]
    A --> R["Remediate\nDeveloper fixes it"]
    R --> V["Verify\nRe-test confirms fix"]
    V --> CL["Close\nUpdate risk register"]
    P -->|Cannot fix now| RA["Risk Accept\nFormal, time-limited,\napproved by CISO"]
    RA --> M["Monitor\nReview at next cycle"]',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-12-2', 'ist-step-12',
'A common failure mode is "vulnerability theatre" — an organisation goes through the motions of a pen test, gets a report, and puts it in a drawer. Nothing is fixed. The next year, they commission another pen test, get largely the same report, and put that one in a drawer too. This happens because there is no vulnerability management programme to actually drive remediation. The test produces findings; the programme turns findings into fixes.',
NULL,
'The UK''s National Cyber Security Centre (NCSC) found in its annual review that a significant proportion of breaches they investigated involved vulnerabilities that had been identified in security assessments months or years earlier — but never remediated. The testing was done. The fixing was not.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-12-3', 'ist-step-12',
'When a fix is deployed, the verification step is critical: the same tester who found the vulnerability should confirm it is no longer exploitable. A developer might fix the specific parameter that was exploited while leaving the underlying pattern vulnerable elsewhere in the same codebase. Proper verification catches these partial fixes before the vulnerability becomes a repeat finding in the next test.',
NULL, NULL, NULL, 2);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-12-1', 'ist-step-12', 'q12-1', 'What is the correct order of the vulnerability management lifecycle?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-12-1a', 'ist-q-12-1', 'Fix, test, discover, report', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-12-1b', 'ist-q-12-1', 'Discover, prioritise, remediate, verify, report — then repeat continuously', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-12-1c', 'ist-q-12-1', 'Test annually, fix Critical findings only, archive the rest', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-12-1d', 'ist-q-12-1', 'Report to the board, assign an owner, wait for budget approval, fix', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-12-2', 'ist-step-12', 'q12-2', 'A CISO decides not to fix a Medium vulnerability because the cost of remediation exceeds the risk it poses. What is this called?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-12-2a', 'ist-q-12-2', 'Vulnerability theatre', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-12-2b', 'ist-q-12-2', 'Risk acceptance — a formal, documented decision to tolerate the risk', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-12-2c', 'ist-q-12-2', 'Residual risk reduction', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-12-2d', 'ist-q-12-2', 'Negligence — all findings must be fixed regardless of cost', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-12-3', 'ist-step-12', 'q12-3', 'What is "residual risk"?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-12-3a', 'ist-q-12-3', 'Vulnerabilities that were not found during the pen test', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-12-3b', 'ist-q-12-3', 'The risk that remains after controls and remediations have been applied — no organisation achieves zero risk', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-12-3c', 'ist-q-12-3', 'Old vulnerabilities that are no longer relevant', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-12-3d', 'ist-q-12-3', 'The cost of remediating all outstanding findings', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-12-4', 'ist-step-12', 'q12-4', 'What is the danger of "vulnerability theatre"?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-12-4a', 'ist-q-12-4', 'The testing firm charges too much for the engagement', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-12-4b', 'ist-q-12-4', 'The organisation goes through the motions of commissioning a pen test but never remediates the findings, creating the appearance of security activity without actual improvement', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-12-4c', 'ist-q-12-4', 'Testers spend too much time on low-severity findings', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-12-4d', 'ist-q-12-4', 'The board is given too much detail in the executive summary', FALSE, 3);
