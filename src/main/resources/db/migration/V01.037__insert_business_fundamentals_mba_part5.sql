-- ============================================================
-- Business Fundamentals for New Entrepreneurs — Part 5
-- Page 25: CxO Roles, Board of Directors, and When to Introduce Them
-- Inserted after Page 21 (Growth and Scaling)
-- Also shifts existing page entries 22-24 to 22-24 (sequence_order bump)
-- ============================================================

-- Shift existing page entries to make room at sequence_order 21
-- Update in reverse order to avoid unique (certification_id, sequence_order) constraint violations
UPDATE T_page_entry SET sequence_order = 24 WHERE id = 'mba-pe-24';
UPDATE T_page_entry SET sequence_order = 23 WHERE id = 'mba-pe-23';
UPDATE T_page_entry SET sequence_order = 22 WHERE id = 'mba-pe-22';

-- ============================================================
-- PAGE 25: CxO Roles, the Board of Directors, and When Small Sàrls Need Them
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-25', 'business-fundamentals-mba', 'cxo-roles-and-board',
'CxO Roles, the Board, and When Your Sàrl Needs Them',
'Imagine you just watched a Netflix documentary about Apple, and Jony Ive is called the "Chief Design Officer." Then you read a news article about a data breach and the "CISO resigns." Then a friend''s startup gets VC funding and suddenly they have a "Board of Directors." You think: what are all these titles? And will I ever need them? The short answer: probably not next week, but sooner than you think. Every thriving company eventually needs to specialise its leadership. This page demystifies the C-suite, the Board, and tells you exactly when a small Swiss Sàrl should start introducing these structures — and in what order.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-25-1', 'mba-step-25', 'CEO — Chief Executive Officer',
'The top executive (Directeur Général / Geschäftsführer) responsible for the overall strategy, direction, and day-to-day leadership of the company. In a small Sàrl, this is almost always you — the founder. The CEO reports to the Board of Directors. In Switzerland, the GmbH/Sàrl law requires at least one gérant (managing director), which is the legal equivalent.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-25-2', 'mba-step-25', 'CFO — Chief Financial Officer',
'Responsible for financial planning, reporting, cash flow management, and investor relations (Directeur Financier / Finanzchef). In a small Sàrl, your Treuhand (fiduciary) covers much of this function. When revenue exceeds CHF 1–2 million and financial decisions become complex, hiring a part-time or full-time CFO — or promoting a financial manager — starts to make sense.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-25-3', 'mba-step-25', 'CTO — Chief Technology Officer',
'Leads technical strategy and engineering (Directeur Technique / Technikchef). Critical in technology-driven companies. In a small software Sàrl, the founder-developer often holds this role informally. When you have an engineering team, formalising a CTO helps separate "building the product" from "running the business."',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-25-4', 'mba-step-25', 'CMO — Chief Marketing Officer',
'Owns brand, customer acquisition, communications, and growth strategy (Directeur Marketing / Marketingchef). Most small Sàrls handle marketing informally at first — the founder does it, or hires a freelancer. When marketing spend exceeds CHF 100,000/year or you enter new markets, a dedicated CMO becomes valuable. This role often emerges from a senior marketing hire who grows into the position.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-25-5', 'mba-step-25', 'COO — Chief Operating Officer',
'Manages the day-to-day execution of the company''s strategy — processes, people, logistics, efficiency (Directeur des Opérations / Betriebsleiter). Often the second hire after the CEO has too much to manage alone. If you find yourself spending 80% of your time on operations, a COO frees you for strategy and client work.',
4);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-25-6', 'mba-step-25', 'CISO — Chief Information Security Officer',
'Responsible for protecting the company''s data, systems, and digital assets (Responsable de la Sécurité des Systèmes d''Information — RSSI / Informationssicherheitsbeauftragter). This role gained enormous importance after GDPR (2018) and the Swiss nDSG (revised Data Protection Act, 2023). For most Sàrls, a full-time CISO is not needed until 20+ employees. Before that, assign a "data protection responsible" (required under nDSG) — often the CEO or a trusted technical employee.',
5);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-25-7', 'mba-step-25', 'Board of Directors',
'A governing body (Conseil d''Administration / Verwaltungsrat) that oversees management on behalf of shareholders. In Switzerland, an AG is legally required to have a Verwaltungsrat. A GmbH/Sàrl has gérants (managing directors) instead, but can optionally create an advisory board (Beirat / conseil consultatif) for strategic guidance. The Board hires and fires the CEO, approves major strategy, and ensures legal compliance. In startups with investors, the Board often includes investor representatives who hold real power.',
6);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-25-1', 'mba-step-25',
'The typical corporate hierarchy — from a one-person Sàrl to a scaled company — looks like this. Notice how it grows vertically over time:',
NULL, NULL,
'graph TD
    A[Shareholders<br/>Actionnaires / Gesellschafter] --> B[Board of Directors<br/>Conseil d''Administration<br/>Verwaltungsrat]
    B --> C[CEO<br/>Directeur Général<br/>Geschäftsführer]
    C --> D[CFO<br/>Directeur Financier]
    C --> E[CTO<br/>Directeur Technique]
    C --> F[CMO<br/>Directeur Marketing]
    C --> G[COO<br/>Directeur des Opérations]
    C --> H[CISO<br/>Responsable Sécurité<br/>RSSI]
    D --> I[Finance Team]
    E --> J[Engineering Team]
    F --> K[Marketing Team]
    G --> L[Operations Team]
    H --> M[IT / Security Team]
    style A fill:#e1f5ff
    style B fill:#fff4e1
    style C fill:#f0ffe1',
0);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-25-2', 'mba-step-25',
'Real story: In 2004, a 26-year-old named Mark Zuckerberg launched Facebook from his Harvard dorm room. He was simultaneously CEO, CTO, CMO, CFO, and janitor. By 2008, Facebook had 150 employees and Sheryl Sandberg joined as COO. She freed Zuckerberg to focus on product and long-term vision while she ran the business. By 2012, they had a full C-suite and a Board including Marc Andreessen and Reed Hastings. The lesson: the right structure grows with the company. Forcing C-suite titles on a 3-person startup is theatre. Not having structure in a 50-person company is chaos.',
NULL,
'The Swiss equivalent: Digitec Galaxus, now Switzerland''s largest online retailer, started as a small Sàrl in 2001. It grew through careful management. Today it has a full executive team and advisory structures — but they were introduced when the company was ready for them, not before.',
NULL, 1);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-25-3', 'mba-step-25',
'When to introduce each role in a Swiss Sàrl — a realistic timeline:',
NULL, NULL,
'graph TD
    A[Phase 1: Solo Founder<br/>0-3 employees<br/>You do everything] --> B[Phase 2: First Hires<br/>4-10 employees<br/>COO equivalent needed<br/>Ops manager takes over daily tasks]
    B --> C[Phase 3: Growing Team<br/>11-25 employees<br/>Part-time CFO + Data Protection Responsible<br/>Consider advisory board]
    C --> D[Phase 4: Scaling<br/>26-50 employees<br/>Full-time CFO, formalise CTO or CMO<br/>Convert advisory board to real governance]
    D --> E[Phase 5: Mature SME<br/>50+ employees or external investors<br/>Full C-suite, CISO, formal Board<br/>Consider converting to AG]
    style A fill:#e1f5ff
    style B fill:#f0ffe1
    style C fill:#fff4e1
    style D fill:#ffe1f5
    style E fill:#f5f0ff',
2);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-25-4', 'mba-step-25',
'The CISO role and why it matters even for small companies: In June 2023, Switzerland''s revised Data Protection Act (nDSG — neues Datenschutzgesetz) came into force, harmonising Swiss law with EU GDPR. Key obligations for any business handling personal data: 1) Appoint a data protection responsible (Datenschutzverantwortlicher / responsable de la protection des données) — this is your mini-CISO; 2) Maintain a register of processing activities if you process sensitive data; 3) Report data breaches to the FDPIC (Federal Data Protection Commissioner) within 72 hours; 4) Implement appropriate technical and organisational security measures. You do NOT need a full-time CISO to comply — but someone must own this responsibility.',
NULL,
'True story: In 2021, a Zurich-based HR software startup with 8 employees suffered a data breach exposing 4,000 client employee records. They had no designated data protection responsible. The reputational damage cost them three enterprise clients. The fix would have cost CHF 500: a half-day training and a simple policy document. Cheap insurance.',
NULL, 3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-25-5', 'mba-step-25',
'The Board of Directors in a Sàrl context: A GmbH/Sàrl does not legally require a Board of Directors — that is only mandatory for AGs. However, there are two practical reasons you might want one anyway: 1) You bring in investors (angels, VCs) — they typically demand board representation as a condition of investment; 2) You want external accountability and senior mentorship — an advisory board (Beirat) can include experienced entrepreneurs, industry experts, and lawyers who challenge your thinking without full legal liability. Advisory board members are typically compensated with small equity or a modest annual fee (CHF 5,000–20,000/year for a serious advisor). A formal board member of an AG has fiduciary duties and personal liability — a much heavier commitment.',
NULL,
'Sofia, 28, raised CHF 400,000 in angel investment for her edtech Sàrl. Her three investors requested board seats. She converted to an AG, created a 5-person Board (2 founders, 3 investors), and hired a lawyer to draft board rules. Result: better governance, investor confidence, and strategic challenge she could not get alone.',
NULL, 4);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-25-1', 'mba-step-25', 'q25-1', 'In a Swiss GmbH/Sàrl, what is the legal equivalent of a CEO?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-25-1a', 'mba-q-25-1', 'The Verwaltungsrat', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-25-1b', 'mba-q-25-1', 'The gérant or managing director (Geschäftsführer)', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-25-1c', 'mba-q-25-1', 'The FDPIC', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-25-1d', 'mba-q-25-1', 'The actionnaire majoritaire who holds the largest share of equity in the company', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-25-2', 'mba-step-25', 'q25-2', 'Under the Swiss nDSG, what must a business do within 72 hours of a data breach?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-25-2a', 'mba-q-25-2', 'Hire a CISO immediately', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-25-2b', 'mba-q-25-2', 'Report the breach to the FDPIC (Federal Data Protection Commissioner)', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-25-2c', 'mba-q-25-2', 'Delete all affected personal data from company servers and backups to limit exposure', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-25-2d', 'mba-q-25-2', 'Pay a mandatory cantonal fine and submit a remediation plan to the cantonal trade register', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-25-3', 'mba-step-25', 'q25-3', 'At what stage should a growing Swiss Sàrl typically first consider an advisory board (Beirat)?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-25-3a', 'mba-q-25-3', 'Only after converting to an AG, since advisory boards are legally exclusive to joint-stock companies', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-25-3b', 'mba-q-25-3', 'Day one — every startup needs a board regardless of size', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-25-3c', 'mba-q-25-3', 'Around 11–25 employees or when raising outside investment', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-25-3d', 'mba-q-25-3', 'After the company has been operating profitably for at least ten consecutive years', FALSE, 3);

-- ============================================================
-- PAGE ENTRY for the new step — inserted at sequence_order 21
-- (between step 21 at sequence 20 and step 22 which is now at sequence 22)
-- ============================================================
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-25', 'business-fundamentals-mba', 'DIRECT', 21, 'mba-step-25', NULL, NULL);
