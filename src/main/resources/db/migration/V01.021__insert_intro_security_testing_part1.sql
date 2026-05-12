-- ============================================================
-- Introduction to Security Testing — Part 1
-- Certification record + Pages 1-4
-- ============================================================

INSERT INTO T_certification (id, title, description, coming_soon, sequence_order, created_at, updated_at)
VALUES ('intro-security-testing', 'Introduction to Security Testing',
'Security testing is not just running a scanner and hoping for the best. It is a discipline with ethics, law, people, and processes at its core. This certification introduces you to every dimension of security testing — what it is, who does it, how it is governed, and why it matters — no technical background required.',
FALSE, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ============================================================
-- PAGE 1: What Is Security Testing?
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-01', 'intro-security-testing', 'what-is-security-testing',
'What Is Security Testing?',
'In 2017, a credit agency called Equifax was breached. The personal data of 147 million people — names, Social Security numbers, birth dates, addresses — was stolen. The cause? A known vulnerability in a web framework that had a patch available for two months. Nobody had tested whether the patch had been applied. Security testing exists precisely to catch these moments before attackers do. It is the discipline of deliberately looking for weaknesses in systems, processes, and people so that they can be fixed before someone with bad intentions finds them first.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-01-1', 'ist-step-01', 'Vulnerability',
'A vulnerability is a weakness in a system that could be exploited to cause harm. It can exist in software (a bug in code), configuration (a server left with default passwords), process (no one checks whether patches are applied), or people (an employee who clicks every link in every email). Every system has vulnerabilities; the goal of security testing is to find them before attackers do.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-01-2', 'ist-step-01', 'Threat',
'A threat is any circumstance or event with the potential to harm a system. Threats can be external (a criminal hacking group, a nation-state actor) or internal (a disgruntled employee, an accidental misconfiguration). Not every threat becomes an attack, and not every attack succeeds — but understanding your threats helps you prioritise which vulnerabilities to fix first.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-01-3', 'ist-step-01', 'Risk',
'Risk is what happens when a threat meets a vulnerability. Formally: Risk = Likelihood × Impact. A vulnerability that is hard to exploit (low likelihood) or only affects a test server with no real data (low impact) is lower risk than one that is trivially exploited in a payment system. Security testing helps you understand and reduce risk.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-01-4', 'ist-step-01', 'Attack Surface',
'The attack surface is the sum of all points where an attacker could try to enter a system — every web page, API endpoint, login form, open network port, and employee inbox. The larger it is, the more there is to test and protect. Reducing the attack surface by turning off services you do not need is one of the most effective security measures available.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-01-5', 'ist-step-01', 'Security Testing vs Functional Testing',
'Functional testing asks: "Does the system do what it is supposed to do?" Security testing asks: "Can the system be made to do something it is NOT supposed to do?" A login form might pass every functional test yet still be vulnerable to SQL injection, where an attacker types a crafted value that tricks the database into bypassing authentication entirely.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-01-1', 'ist-step-01',
'Think of security testing as an adversarial mindset applied systematically. A functional tester asks "does it work?" A security tester asks "how can I break it, trick it, or abuse it?" Both are necessary — but they require very different ways of thinking.',
NULL, NULL, NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-01-2', 'ist-step-01',
'Here is how risk is built from threats and vulnerabilities:',
NULL, NULL,
'graph LR
    T[Threat Actor] -->|exploits| V[Vulnerability]
    V -->|creates| R[Risk]
    R -->|causes| I[Impact]
    ST[Security Testing] -->|finds and reduces| V
    CM[Controls] -->|reduce| R',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-01-3', 'ist-step-01',
'Security testing is not a one-off event. The Equifax breach happened because a patch was available but never verified as applied. Systems change, new vulnerabilities are discovered, and attackers constantly evolve. Security testing must be continuous and built into the way organisations operate.',
NULL,
'The term "security by design" means building security in from the start rather than adding it after the system is built. A door with a lock built into it is stronger than a padlock added to a door never designed to have one.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-01-4', 'ist-step-01',
'Not all security testing is the same. Testing a banking application requires a different approach, skill set, and level of care than testing a marketing website. The rest of this certification maps out all the dimensions.',
NULL, NULL, NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-01-1', 'ist-step-01', 'q01-1', 'What is the correct definition of "risk" in a security context?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-01-1a', 'ist-q-01-1', 'The number of vulnerabilities found during a test', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-01-1b', 'ist-q-01-1', 'The combination of the likelihood of a threat exploiting a vulnerability and the impact if it does', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-01-1c', 'ist-q-01-1', 'The cost of the security testing engagement', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-01-1d', 'ist-q-01-1', 'Any event that causes a system to crash', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-01-2', 'ist-step-01', 'q01-2', 'What is the key difference between security testing and functional testing?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-01-2a', 'ist-q-01-2', 'Security testing is done by a different team and is more expensive', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-01-2b', 'ist-q-01-2', 'Functional testing checks the system works as intended; security testing tries to make it do things it should not do', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-01-2c', 'ist-q-01-2', 'Security testing only applies to web applications', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-01-2d', 'ist-q-01-2', 'Functional testing is automated; security testing is always manual', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-01-3', 'ist-step-01', 'q01-3', 'What was the root cause of the 2017 Equifax breach?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-01-3a', 'ist-q-01-3', 'A zero-day vulnerability with no available patch', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-01-3b', 'ist-q-01-3', 'An employee was tricked into giving away their password', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-01-3c', 'ist-q-01-3', 'A known vulnerability with an available patch that was never verified as applied', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-01-3d', 'ist-q-01-3', 'Equifax stored passwords in plain text', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-01-4', 'ist-step-01', 'q01-4', 'Which best describes the "attack surface" of a system?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-01-4a', 'ist-q-01-4', 'The number of users who have admin access', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-01-4b', 'ist-q-01-4', 'The total number of servers in a network', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-01-4c', 'ist-q-01-4', 'Every point where an attacker could potentially enter or interact with a system', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-01-4d', 'ist-q-01-4', 'The geographic area covered by the company''s network', FALSE, 3);

-- ============================================================
-- PAGE 2: The Security Testing Landscape
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-02', 'intro-security-testing', 'security-testing-landscape',
'The Security Testing Landscape',
'Ask five different people what "security testing" means and you will get five different answers. One says it is running a vulnerability scanner. Another says it is hiring a hacker to break in. A third talks about reviewing code. They are all correct — security testing is an umbrella for a whole family of disciplines. Before you can work in this field, manage a team, or commission work, you need to know the map.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-02-1', 'ist-step-02', 'Penetration Testing',
'Penetration testing is a structured, authorised simulation of a real attack. A skilled tester attempts to find and exploit vulnerabilities in a target using the same techniques an attacker would — but with permission, a defined scope, and a professional report at the end. Think of it as a fire drill for your security defences.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-02-2', 'ist-step-02', 'Vulnerability Scanning',
'A vulnerability scan is an automated check of a system against a database of known weaknesses. Tools send probes to the target and compare findings against thousands of known vulnerability signatures. Scans are fast and cheap but only find what they know to look for, and they produce false positives that need human review.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-02-3', 'ist-step-02', 'Red Team / Blue Team / Purple Team',
'The red team attacks (simulates the adversary), the blue team defends (the security operations team). A red team exercise is more realistic than a pen test — it may run for weeks, use physical intrusion and social engineering, and the blue team does not know it is happening. A purple team exercise is a collaboration where red and blue share findings in real time to maximise learning for both sides.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-02-4', 'ist-step-02', 'Threat Modelling',
'Threat modelling is a structured way of thinking about what could go wrong with a system before it is built or tested. The team asks: what are we building, what could go wrong, and what are we going to do about it? Popular frameworks include STRIDE. Threat modelling is ideally done during design — far cheaper to fix a design flaw on a whiteboard than in production code.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-02-5', 'ist-step-02', 'Bug Bounty Programme',
'A bug bounty programme invites independent security researchers worldwide to find vulnerabilities in a company''s systems, in exchange for a financial reward. Companies like Google, Microsoft, and Facebook pay out millions every year via platforms like HackerOne or Bugcrowd. For mature organisations, bug bounties are a cost-effective way to get thousands of testers looking at their systems continuously.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-02-1', 'ist-step-02',
'Here is how the main security testing approaches relate to each other in terms of scope, depth, and how much the defender knows:',
NULL, NULL,
'graph TD
    VulnScan["Vulnerability Scanning\nAutomated, broad, shallow\nDefender is aware"]
    PenTest["Penetration Testing\nManual, focused, deep\nDefender may be aware"]
    RedTeam["Red Team Exercise\nFully adversarial, long-duration\nDefender NOT aware"]
    BugBounty["Bug Bounty\nCrowd-sourced, continuous"]
    ThreatModel["Threat Modelling\nDone during design\nNo live system needed"]
    ThreatModel -->|informs scope of| PenTest
    VulnScan -->|feeds findings into| PenTest
    PenTest -->|escalates to| RedTeam
    RedTeam -->|improves| BugBounty',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-02-2', 'ist-step-02',
'An important distinction: a vulnerability scan tells you what *might* be vulnerable; a penetration test tells you what *is* vulnerable. A scan says "this service version has a known flaw." A pen test actually attempts to exploit that flaw and reports whether it succeeded.',
NULL,
'Many organisations confuse the two. A client who says "we had a pen test last year" sometimes means they ran an automated scan. Always clarify what was actually done.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-02-3', 'ist-step-02',
'Security testing also includes: source code review (reading the code for vulnerabilities before it runs), security architecture review (evaluating whether a system''s design is sound), social engineering tests (calling employees pretending to be IT support), and physical security tests (attempting to walk into buildings). All sit under the security testing umbrella.',
NULL, NULL, NULL, 2);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-02-1', 'ist-step-02', 'q02-1', 'What is the main difference between a vulnerability scan and a penetration test?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-02-1a', 'ist-q-02-1', 'A vulnerability scan is done by humans; a penetration test is automated', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-02-1b', 'ist-q-02-1', 'A vulnerability scan identifies potential weaknesses automatically; a penetration test manually attempts to exploit them to confirm they are real', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-02-1c', 'ist-q-02-1', 'A penetration test covers the whole organisation; a scan only covers web applications', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-02-1d', 'ist-q-02-1', 'There is no practical difference between the two', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-02-2', 'ist-step-02', 'q02-2', 'In a red team exercise, does the defending (blue) team know the attack is taking place?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-02-2a', 'ist-q-02-2', 'Yes, the blue team is fully briefed before the exercise starts', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-02-2b', 'ist-q-02-2', 'No — the blue team does not know when or how the red team will strike, making the exercise a realistic test of detection and response', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-02-2c', 'ist-q-02-2', 'Only senior management are told; the rest of the blue team is kept in the dark', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-02-2d', 'ist-q-02-2', 'The blue team is always aware in a red team exercise; it is only in purple team that they are kept in the dark', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-02-3', 'ist-step-02', 'q02-3', 'What does STRIDE stand for in threat modelling?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-02-3a', 'ist-q-02-3', 'Scanning, Testing, Risk, Identification, Detection, Exploitation', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-02-3b', 'ist-q-02-3', 'Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-02-3c', 'ist-q-02-3', 'System, Threat, Risk, Impact, Defence, Escalation', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-02-3d', 'ist-q-02-3', 'STRIDE is a penetration testing methodology, not a threat modelling framework', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-02-4', 'ist-step-02', 'q02-4', 'What is a bug bounty programme?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-02-4a', 'ist-q-02-4', 'An internal team paid a bonus for every bug they fix', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-02-4b', 'ist-q-02-4', 'A programme that pays external security researchers to find and responsibly disclose vulnerabilities in a company''s systems', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-02-4c', 'ist-q-02-4', 'A competition between development teams to write the most secure code', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-02-4d', 'ist-q-02-4', 'A legal framework protecting companies from being sued over security vulnerabilities', FALSE, 3);

-- ============================================================
-- PAGE 3: Ethics and Professional Conduct
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-03', 'intro-security-testing', 'ethics-and-conduct',
'Ethics and Professional Conduct',
'In 2021, a researcher discovered a critical vulnerability in a hospital''s patient monitoring system. He could have exploited it silently. Instead, he reported it to the hospital''s security team, who fixed it within days. Hundreds of patients may owe their safety to that decision. Security testing gives you knowledge and access that could cause enormous harm if misused. Ethics is not an optional add-on — it is the foundation. Without it, "security tester" and "criminal" are separated only by a piece of paper called authorisation.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-03-1', 'ist-step-03', 'Ethical Hacking',
'Ethical hacking is the practice of using the same tools, techniques, and mindset as a malicious attacker — but with explicit permission, a defined scope, and the goal of improving security. The word "ethical" means: you have authorisation, you stay within scope, you do not cause unnecessary damage, you report everything you find, and you keep what you learn confidential.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-03-2', 'ist-step-03', 'Responsible Disclosure',
'Responsible disclosure (also called coordinated vulnerability disclosure) is the practice of privately notifying a vendor about a vulnerability you have found, giving them a reasonable time to fix it (the standard is 90 days, popularised by Google''s Project Zero), and only then making it public. This gives organisations time to patch before the vulnerability is weaponised.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-03-3', 'ist-step-03', 'Do No Harm',
'In medicine: "primum non nocere" — first, do no harm. Security testing has an equivalent: minimise impact. A tester might prove a SQL injection vulnerability exists by extracting one row of data; there is no need to download the entire database to make the point. A tester who crashes a production server to prove a denial-of-service vulnerability caused real harm — even if unintentional.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-03-4', 'ist-step-03', 'Professional Codes of Conduct',
'Several professional bodies publish codes of conduct for security practitioners. (ISC)² requires its members to act ethically and in the public interest. EC-Council (CEH) and CREST have similar requirements. These codes exist because security professionals have capabilities that could cause significant harm — codes of conduct create accountability and set expectations that clients can rely on.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-03-1', 'ist-step-03',
'The line between an ethical hacker and a criminal is not skill — it is authorisation and intent. Many celebrated security researchers started by hacking systems they did not own as teenagers. Some were prosecuted. Others were hired. The difference often came down to whether they behaved responsibly when they found something.',
NULL,
'Kevin Mitnick, once the most wanted computer criminal in the United States, later became one of the world''s most respected security consultants. His story illustrates both sides of the line — and why staying on the right side matters.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-03-2', 'ist-step-03',
'Here is how responsible disclosure works in practice:',
NULL, NULL,
'graph LR
    D[Researcher Discovers Vulnerability] --> N[Privately Notifies Vendor]
    N --> W{Vendor Responds?}
    W -->|Yes| F[Vendor Fixes Vulnerability]
    F --> P[Public Disclosure after Fix]
    W -->|No response in 90 days| PF[Public Disclosure anyway]
    PF --> PP[Public can now protect themselves]',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-03-3', 'ist-step-03',
'Professionalism means protecting the confidentiality of what you find. A pen test report contains a detailed map of an organisation''s weaknesses. If that report leaks — through careless email, an unencrypted laptop left on a train, or a disgruntled contractor — the attacker gets all the work done for them. Treating findings as confidential is an ethical and contractual obligation.',
NULL,
'In 2020, a pen test report for a major UK retailer leaked on a security forum, detailing open vulnerabilities not yet fixed. The reputational damage to the testing firm was severe.',
NULL, 2);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-03-1', 'ist-step-03', 'q03-1', 'What is the standard responsible disclosure timeline popularised by Google''s Project Zero?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-03-1a', 'ist-q-03-1', '30 days', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-03-1b', 'ist-q-03-1', '90 days', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-03-1c', 'ist-q-03-1', '6 months', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-03-1d', 'ist-q-03-1', 'There is no standard timeline — researchers can disclose immediately', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-03-2', 'ist-step-03', 'q03-2', 'What is the "do no harm" principle in security testing?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-03-2a', 'ist-q-03-2', 'Testers must never exploit any vulnerability, only report them', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-03-2b', 'ist-q-03-2', 'Testers should use the minimum level of exploitation necessary to confirm a finding, avoiding unnecessary damage to systems or data', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-03-2c', 'ist-q-03-2', 'Testers are not responsible for damage caused during a test because they have authorisation', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-03-2d', 'ist-q-03-2', '"Do no harm" only applies to tests on healthcare systems', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-03-3', 'ist-step-03', 'q03-3', 'What single thing most separates an ethical hacker from a criminal hacker?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-03-3a', 'ist-q-03-3', 'The tools they use', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-03-3b', 'ist-q-03-3', 'Their level of technical skill', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-03-3c', 'ist-q-03-3', 'Explicit authorisation from the owner of the system being tested', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-03-3d', 'ist-q-03-3', 'Whether they disclose their findings publicly', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-03-4', 'ist-step-03', 'q03-4', 'Why must pen test reports be treated as highly confidential?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-03-4a', 'ist-q-03-4', 'Because clients pay a lot of money for them and do not want competitors to see the cost', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-03-4b', 'ist-q-03-4', 'Because they contain a detailed map of an organisation''s weaknesses — a leaked report hands attackers everything they need', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-03-4c', 'ist-q-03-4', 'To comply with GDPR, since reports contain personal data', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-03-4d', 'ist-q-03-4', 'There is no particular reason — confidentiality is just a client preference', FALSE, 3);

-- ============================================================
-- PAGE 4: Legal Frameworks and Authorisation
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('ist-step-04', 'intro-security-testing', 'legal-frameworks',
'Legal Frameworks and Authorisation',
'In 2013, a British security researcher ran a port scan against a company''s systems to help them understand their exposure — without written permission. He was prosecuted under the Computer Misuse Act and received a suspended sentence. He had good intentions. He was skilled. He was still a criminal under the law. This is the reality of security testing: the same actions that are professional and valued with authorisation become criminal without it.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-04-1', 'ist-step-04', 'Computer Misuse Act 1990 (UK)',
'The Computer Misuse Act makes it a criminal offence in the UK to access a computer without authorisation — even just reading files — and to modify computer material without authorisation. Crucially, intent does not matter: the act of unauthorised access is itself the crime. Penalties range from fines to 10 years imprisonment. This is why written authorisation is essential.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-04-2', 'ist-step-04', 'Computer Fraud and Abuse Act (CFAA, USA)',
'The CFAA is the US federal law covering computer crime. It has been controversially applied against security researchers acting in good faith. The CFAA makes it illegal to access a protected computer without authorisation or in excess of authorisation. "In excess of authorisation" matters for pen testers: going outside agreed scope could be a crime even with a signed contract.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-04-3', 'ist-step-04', 'GDPR and Data Protection',
'GDPR applies when security testing might involve accessing personal data. During a pen test, a tester might encounter databases containing real customer records. Even if the access is authorised for security testing purposes, the tester becomes a data processor and must handle that data lawfully — not retaining it longer than necessary, not exfiltrating it, and reporting any accidental exposure.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('ist-ii-04-4', 'ist-step-04', 'Written Authorisation and Scope',
'Authorisation should always be in writing, signed by someone with authority (typically a director or CISO), and clearly define scope — exactly which systems, IP addresses, and actions are permitted. Verbal authorisation is not sufficient. The statement of work or rules of engagement document is the tester''s legal protection. If a test goes wrong, the first thing lawyers and police ask for is this document.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-04-1', 'ist-step-04',
'The authorisation chain matters. A company can authorise a pen test of their application — but if it is hosted on a cloud provider''s servers, the physical infrastructure belongs to the cloud provider. Testing those without the cloud provider''s permission could violate their terms of service and possibly the law.',
NULL,
'Major cloud providers have specific policies for security testing on their platforms. AWS does not require prior approval for most testing on your own resources, but prohibits activities like DDoS simulation without pre-approval.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-04-2', 'ist-step-04',
'Here is the hierarchy of authorisation that must be in place before any test begins:',
NULL, NULL,
'graph TD
    Board["Board / Senior Management\nUltimate authority"] --> CISO["CISO / IT Director\nSigns engagement"]
    CISO --> SOW["Statement of Work\nDefines scope and rules"]
    SOW --> Tester["Tester\nCan now lawfully proceed"]
    SOW --> ThirdParty["Third-Party Owners\nCloud providers, ISPs\nMust also give permission"]',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('ist-in-04-3', 'ist-step-04',
'Going out of scope — even accidentally — is a serious event. If a tester discovers a vulnerability in a system not listed in scope, they must stop, document what they found, and notify the client immediately. They must not exploit it. The client can then decide whether to bring that system into scope with proper authorisation.',
NULL,
'Real example: a tester working on a retail company''s website noticed the checkout was hosted by a third-party payment processor not in scope. They immediately flagged it. The client contacted the payment processor, who found a critical vulnerability in their own test.',
NULL, 2);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-04-1', 'ist-step-04', 'q04-1', 'Under the UK Computer Misuse Act, is it a crime to access a computer without authorisation even if you do not cause any damage?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-04-1a', 'ist-q-04-1', 'No — damage must be proven for it to be a crime', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-04-1b', 'ist-q-04-1', 'Yes — the act of unauthorised access itself is a criminal offence, regardless of damage or intent', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-04-1c', 'ist-q-04-1', 'Only if the computer belongs to a government organisation', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-04-1d', 'ist-q-04-1', 'Only if the access is repeated more than three times', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-04-2', 'ist-step-04', 'q04-2', 'A tester discovers a vulnerability in a third-party payment system connected to the target but not in scope. What should they do?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-04-2a', 'ist-q-04-2', 'Exploit it to assess severity, then include it in the report', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-04-2b', 'ist-q-04-2', 'Ignore it — not in scope means not the tester''s responsibility', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-04-2c', 'ist-q-04-2', 'Stop, document what was found, and immediately notify the client so they can decide whether to bring it in scope with proper authorisation', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-04-2d', 'ist-q-04-2', 'Contact the third party directly without telling the client', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-04-3', 'ist-step-04', 'q04-3', 'Why is verbal authorisation for a penetration test not sufficient?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-04-3a', 'ist-q-04-3', 'It is sufficient if both parties agree and a witness is present', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-04-3b', 'ist-q-04-3', 'Written authorisation is the tester''s legal protection — without it, there is no proof of consent if something goes wrong', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-04-3c', 'ist-q-04-3', 'Verbal authorisation is fine for small organisations but not large enterprises', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-04-3d', 'ist-q-04-3', 'Because GDPR requires all agreements to be in writing', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('ist-q-04-4', 'ist-step-04', 'q04-4', 'Why must a pen tester be aware of GDPR even if they are not a data protection officer?', 3);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-04-4a', 'ist-q-04-4', 'They do not need to — GDPR only applies to the client organisation', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-04-4b', 'ist-q-04-4', 'During a test they may encounter personal data, making them a data processor with legal obligations around handling and disposal', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-04-4c', 'ist-q-04-4', 'Only if the test specifically involves EU citizens'' data', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('ist-a-04-4d', 'ist-q-04-4', 'GDPR does not apply to security testing activities', FALSE, 3);
