-- ============================================================
-- Introduction to Security Testing — Part 5
-- Page 17: Becoming a Freelance Security Tester
-- ============================================================

-- ============================================================
-- PAGE 17: Becoming a Freelance Security Tester
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-17', 'intro-security-testing', 'freelance-security-tester',
'Becoming a Freelance Security Tester',
'The security testing industry offers significant opportunities for independent professionals. Freelance penetration testers enjoy flexibility, variety in work, and often higher day rates than employed consultants. However, going independent requires more than technical skill — it demands business acumen, legal awareness, and professional discipline. This page outlines what it takes to become a successful freelance security tester and provides a practical checklist for conducting professional penetration tests from the independent practitioner''s perspective.',
TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-17-1', 'ist-step-17', 'Building Your Credentials',
'Before clients will trust you with their systems, you need demonstrable expertise. The industry-standard starting point is OSCP (Offensive Security Certified Professional), which proves you can actually exploit vulnerabilities under exam conditions. For UK and European markets, CREST certifications (CRT, CCT) provide professional credibility and are often required by enterprise clients. Specialised certifications like OSWE (web), OSEP (advanced exploitation), or CEH can differentiate you. But certifications alone are not enough — a portfolio of responsible disclosure findings, bug bounty track records, or open-source security tools demonstrates genuine capability.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-17-2', 'ist-step-17', 'Legal and Business Foundations',
'Operating as a freelance security tester requires proper business structure. You need professional liability insurance (errors and omissions insurance) that specifically covers penetration testing activities — standard business policies often exclude security testing. A limited company structure protects personal assets if something goes wrong. Written contracts are essential: they define scope, liability limitations, indemnification clauses, and data handling obligations. Consider registering with industry bodies like CREST or joining professional networks that can vouch for your credibility.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-17-3', 'ist-step-17', 'Finding Clients and Building Reputation',
'Most freelance security testers find work through: direct relationships with CISOs they have worked with before, referrals from existing clients, security consultancies who need overflow capacity, or bug bounty platforms for initial reputation building. Specialising helps — becoming known as the person who tests financial APIs, healthcare systems, or cloud infrastructure. Speaking at security meetups, publishing responsible disclosure write-ups (appropriately anonymised), and contributing to open-source security tools all build visibility. Reputation takes years to build and one mistake to destroy.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-17-4', 'ist-step-17', 'Managing Engagements Professionally',
'Professional freelance testers maintain rigorous standards: encrypted storage for all client data, secure communication channels, detailed time tracking, and systematic methodology following PTES or OWASP guidelines. They issue formal proposals before work begins, maintain change logs if scope shifts, and deliver reports that are both technically accurate and business-appropriate. The best freelancers also provide retesting services, remediation guidance, and ongoing security advisory relationships that turn single engagements into recurring revenue.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-17-1', 'ist-step-17',
'Here is a practical checklist that freelance security testers use to ensure every engagement is conducted professionally and safely:',
NULL, NULL,
'graph TD
    Pre["Pre-Engagement Phase"] --> Auth["Obtain written authorisation signed by authorised client representative"]
    Pre --> Scope["Confirm and document scope: IP ranges, domains, excluded systems"]
    Pre --> RoE["Review Rules of Engagement: allowed hours, testing methods, emergency contacts"]
    Pre --> Legal["Verify your insurance covers this engagement type"]
    Auth --> Prep["Preparation Phase"]
    Scope --> Prep
    RoE --> Prep
    Legal --> Prep
    Prep --> Tools["Prepare testing environment: isolated VM, encrypted storage, VPN if required"]
    Prep --> Notify["Notify client that testing will begin at agreed time"]
    Tools --> Test["Testing Phase"]
    Notify --> Test
    Test --> Recon["Conduct reconnaissance and enumeration"]
    Recon --> Exploit["Attempt exploitation with minimal necessary impact"]
    Exploit --> Doc["Document findings with screenshots, commands, timestamps"]
    Doc --> Post["Post-Exploitation: assess impact, lateral movement if authorised"]
    Post --> Clean["Clean-Up Phase"]
    Clean --> Remove["Remove all test artefacts: accounts, files, backdoors"]
    Remove --> Verify["Verify systems are in original state"]
    Verify --> Report["Reporting Phase"]
    Report --> Exec["Write executive summary for management"]
    Exec --> Tech["Write technical annex with detailed findings and remediation"]
    Tech --> Deliver["Deliver report via secure, encrypted channel only"]
    Deliver --> Debrief["Conduct verbal debrief with stakeholders"]
    Debrief --> Retest["Offer retesting after client remediates"]
    Retest --> Data["Data Management Phase"]
    Data --> Secure["Securely delete all client data from your systems"]
    Secure --> Retain["Retain only anonymised methodology notes if needed"]
    Retain --> Invoice["Final Phase"]
    Invoice --> Bill["Submit invoice with detailed time records"]
    Bill --> Follow["Follow up for feedback and potential retest"]
    Follow --> Archive["Archive engagement records securely per retention policy"]', 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-17-2', 'ist-step-17',
'The pen test checklist above is not just good practice — it is risk management. A freelancer without the backing of a large consultancy firm bears personal liability if something goes wrong. Following a systematic checklist demonstrates due diligence and provides documentation if disputes arise. The checklist also ensures consistent quality: every engagement follows the same professional standards regardless of client size or pressure to deliver quickly.',
NULL,
'Many experienced freelancers maintain their own customised checklists based on years of lessons learned. The checklist provided here is a starting point — adapt it to your specialisation, client types, and regulatory environment.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-17-3', 'ist-step-17',
'Key items in the checklist deserve special emphasis. First, written authorisation must come from someone with actual authority — a junior IT administrator cannot legally authorise testing of production systems. Second, the emergency contact must be reachable 24/7 during testing; disasters do not respect business hours. Third, clean-up is non-negotiable: leaving a test account with admin privileges is creating a vulnerability. Fourth, report delivery must be encrypted — sending a pen test report as a plain email attachment is a serious professional failing.',
NULL, NULL, NULL, 2);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-17-1', 'ist-step-17', 'q17-1', 'Which certification is most widely recognised as the entry-level gold standard for practical penetration testing skills?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-17-1a', 'ist-q-17-1', 'CISSP — Certified Information Systems Security Professional', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-17-1b', 'ist-q-17-1', 'OSCP — Offensive Security Certified Professional', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-17-1c', 'ist-q-17-1', 'CompTIA A+ — Computer Technician certification', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-17-1d', 'ist-q-17-1', 'ISO 27001 Lead Auditor', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-17-2', 'ist-step-17', 'q17-2', 'What type of insurance is essential for a freelance penetration tester?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-17-2a', 'ist-q-17-2', 'Motor vehicle insurance for travel to client sites', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-17-2b', 'ist-q-17-2', 'Professional liability insurance covering security testing activities', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-17-2c', 'ist-q-17-2', 'Health insurance only', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-17-2d', 'ist-q-17-2', 'Cyber insurance that covers the tester''s own computer', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-17-3', 'ist-step-17', 'q17-3', 'Why is maintaining a systematic checklist important for freelance security testers?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-17-3a', 'ist-q-17-3', 'It allows testers to complete engagements faster and take on more clients', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-17-3b', 'ist-q-17-3', 'It ensures consistent quality, demonstrates due diligence, and provides documentation if disputes arise — critical for independent practitioners without corporate backing', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-17-3c', 'ist-q-17-3', 'Clients require checklists to be submitted as deliverables', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-17-3d', 'ist-q-17-3', 'Checklists are required for tax purposes in most jurisdictions', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-17-4', 'ist-step-17', 'q17-4', 'Which of the following is a critical element of the clean-up phase in a penetration test?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-17-4a', 'ist-q-17-4', 'Leaving test accounts in place for future testing sessions', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-17-4b', 'ist-q-17-4', 'Removing all test artefacts including accounts, files, and backdoors, and verifying systems are in their original state', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-17-4c', 'ist-q-17-4', 'Keeping test data for future reference in case the client has questions', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-17-4d', 'ist-q-17-4', 'Clean-up is the client''s responsibility, not the tester''s', FALSE, 3);

-- ============================================================
-- Page entry (DIRECT, one per step, in order)
-- ============================================================
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, choice_label, choice_description, min_required, max_required) VALUES
('ist-pe-17', 'intro-security-testing', 'DIRECT', 16, 'ist-step-17', NULL, NULL, NULL, NULL);
