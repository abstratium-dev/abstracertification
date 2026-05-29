-- ============================================================
-- Business Fundamentals for New Entrepreneurs — Part 1
-- Certification record + Pages 1-6
-- ============================================================

INSERT INTO T_certification (id, title, description, coming_soon, ai_enabled, sequence_order, created_at, updated_at)
VALUES ('business-fundamentals-mba', 'Business Fundamentals for New Entrepreneurs',
'You have mastered your craft — whether as a chef, electrician, developer, or artist. Now you want to open your own business in Switzerland. This certification gives you the the overview and knowledge you need to run your company legally and successfully: Swiss company law, accounting obligations, tax requirements, employment rules, and the fundamentals of strategy, finance, marketing, and operations. Everything a Geschäftsführer needs to know, in language that makes sense.',
FALSE, TRUE, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ============================================================
-- PAGE 1: From Craftsman to Geschäftsführer
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-01', 'business-fundamentals-mba', 'from-craftsman-to-manager',
'From Craftsman to Geschäftsführer',
'Meet Marco. At 24, he was the best pastry chef in his apprenticeship class. By 26, he had opened his own bakery in Zurich. By 27, he was bankrupt. Why? Marco could make a perfect croissant blindfolded, but he could not read a balance sheet. He did not know he had to register for VAT. He paid his suppliers before understanding his cash flow. His story is terrifyingly common. This certification exists so you do not become Marco. Technical skill got you here. Business skill will keep you here.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-01-1', 'mba-step-01', 'Commercial Business',
'A business operation (Gewerbebetrieb / entreprise commerciale) that requires registration with the cantonal authorities. In Switzerland, any commercial activity conducted regularly with the intent to generate profit qualifies. This includes everything from a freelance graphic designer to a restaurant chain. The moment you start taking money for goods or services regularly, you likely need to register.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-01-2', 'mba-step-01', 'Managing Director',
'The person legally responsible (Geschäftsführer / gérant) for managing a business. In a sole proprietorship, that is you. In a GmbH/Sàrl, you might hire one or be one yourself. As managing director, you have specific legal duties under Swiss company law, including the duty to file for bankruptcy if the company becomes over-indebted.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-01-3', 'mba-step-01', 'Three Hats Theory',
'Every small business owner wears three hats: the Operator (doing the actual work), the Manager (organising people and processes), and the Owner (thinking strategy and taking financial risk). Most new entrepreneurs start as excellent Operators but struggle with the other two roles. This certification helps you develop all three.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-01-4', 'mba-step-01', 'Liability',
'In business, liability means you are legally responsible for debts, damages, and obligations. In a Swiss sole proprietorship, you have unlimited personal liability — your house, car, and savings are all at risk if the business fails. In a GmbH/Sàrl, liability is limited to the company assets (usually). Choosing the right structure is partly about controlling liability.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-01-1', 'mba-step-01',
'Here is the uncomfortable truth: being great at your craft is only 30% of running a successful business. The other 70% is accounting, law, marketing, sales, and managing people. A mediocre baker who understands business will outperform a brilliant baker who ignores it.',
NULL,
'This is not about dumbing down your craft. It is about adding new skills to your existing expertise. Think of it as levelling up your character in a video game.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-01-2', 'mba-step-01',
'The three hats you will wear look like this:',
NULL, NULL,
'graph TD
    O[Operator<br/>Doing the work<br/>The craft you mastered] --> M[Manager<br/>Organising, hiring,<br/>keeping accounts]
    M --> OW[Owner<br/>Strategy, risk,<br/>long-term thinking]
    OW --> O
    style O fill:#e1f5ff
    style M fill:#fff4e1
    style OW fill:#f0ffe1',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-01-3', 'mba-step-01',
'Sarah, a 25-year-old web developer, learned this the hard way. She started freelancing, charging 80 CHF per hour. After six months, she calculated her actual hourly rate: 22 CHF. Why? She had not accounted for non-billable time (proposals, admin), software costs, taxes, and the fact that she could only bill about 50% of her working hours. She raised her rate to 150 CHF and started saying no to bad clients. Her income doubled.',
NULL,
'Many young entrepreneurs undercharge because they calculate based on employee thinking ("what would I earn per hour as an employee?") rather than business owner thinking ("what does this hour need to cover?").',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-01-4', 'mba-step-01',
'This certification assumes you are smart and motivated but have never studied business. We will use real Swiss examples, explain the legal requirements clearly, and give you practical tools you can use immediately. No MBA jargon without explanation. No theory without application.',
NULL, NULL, NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-01-1', 'mba-step-01', 'q01-1', 'What percentage of running a successful business is technical craft skill, according to this page?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-01-1a', 'mba-q-01-1', '70%', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-01-1b', 'mba-q-01-1', '50%', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-01-1c', 'mba-q-01-1', '30%', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-01-1d', 'mba-q-01-1', '90%', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-01-2', 'mba-step-01', 'q01-2', 'In a Swiss sole proprietorship (Einzelunternehmen), what type of liability does the owner have?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-01-2a', 'mba-q-01-2', 'Limited liability — only the registered business capital and assets can be seized by creditors', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-01-2b', 'mba-q-01-2', 'Unlimited personal liability — the owner''s private assets are fully exposed', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-01-2c', 'mba-q-01-2', 'No liability — the business is a fully separate legal entity under Swiss law', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-01-2d', 'mba-q-01-2', 'Liability is shared equally among all family members', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-01-3', 'mba-step-01', 'q01-3', 'What happened to Marco, the pastry chef mentioned in the story?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-01-3a', 'mba-q-01-3', 'He became a millionaire by age 30', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-01-3b', 'mba-q-01-3', 'He went bankrupt because he mixed personal and business finances and ignored accounting', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-01-3c', 'mba-q-01-3', 'He sold his bakery and retired early at 28', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-01-3d', 'mba-q-01-3', 'He opened 10 locations across Switzerland', FALSE, 3);

-- ============================================================
-- PAGE 2: Choosing Your Business Structure
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-02', 'business-fundamentals-mba', 'choosing-business-structure',
'Choosing Your Business Structure',
'Imagine you are 22, a talented developer, and you want to start offering web development services. You have CHF 20,000 saved. Do you start as a sole proprietor (Einzelunternehmen) and keep things simple? Or do you form a GmbH (Sàrl in French) to protect your personal assets? This decision affects your taxes, your liability, your administrative burden, and how clients perceive you. Get it wrong and you will pay for it — literally.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-02-1', 'mba-step-02', 'Sole Proprietorship',
'The simplest business form (Einzelunternehmen / entreprise individuelle) in Switzerland. You are the business; the business is you. No separate legal entity, minimal setup costs (just register with the canton), but unlimited personal liability. Perfect for low-risk solo ventures when you are starting out. Taxed on your personal income tax return.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-02-2', 'mba-step-02', 'Limited Liability Company',
'A GmbH (Gesellschaft mit beschränkter Haftung / Sàrl — Société à responsabilité limitée) is a limited liability company requiring CHF 20,000 minimum capital. The company is a separate legal entity, protecting your personal assets (mostly). More administrative work, must file annual reports, but offers credibility and protection.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-02-3', 'mba-step-02', 'Public Limited Company',
'An AG (Aktiengesellschaft / SA — Société anonyme) is a public limited company requiring CHF 100,000 minimum capital (CHF 50,000 can be paid in initially). Used for larger ventures or when planning to bring in investors. Overkill for most solo entrepreneurs starting out.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-02-4', 'mba-step-02', 'Liability',
'Your legal responsibility (Haftung / responsabilité) for business debts and obligations. In a sole proprietorship, you have unlimited liability (unbeschränkte Haftung / responsabilité illimitée). In a GmbH/AG, liability is limited to the company assets, but beware: as managing director (Geschäftsführer / gérant), you can still be personally liable for certain obligations like unpaid social security or taxes.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-02-5', 'mba-step-02', 'Share Capital',
'The minimum capital (Stammkapital / capital social) you must deposit to form a GmbH or AG. For GmbH: CHF 20,000. For AG: CHF 100,000 (minimum CHF 50,000 paid in). This money belongs to the company, not you personally, and must be used for business purposes.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-02-1', 'mba-step-02',
'Here is a real scenario: Lisa, 23, wants to start a social media consulting business. Low upfront costs, working from home, low risk of being sued. She starts as Einzelunternehmen. Cost to set up: about CHF 200 for registration. If she fails, she can close it easily. If she succeeds, she can convert to GmbH later.',
NULL,
'Many entrepreneurs start simple and upgrade their structure as they grow. It is perfectly normal to begin as Einzelunternehmen and later form a GmbH when you have employees, significant revenue, or higher risk.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-02-2', 'mba-step-02',
'Now consider David, 24, who wants to start a construction company. High risk: accidents, property damage, big contracts. If he operates as Einzelunternehmen and a worker gets injured or a roof collapses, he could lose everything he owns. David should form a GmbH despite the higher setup costs.',
NULL,
'High-risk businesses (construction, food service with potential food poisoning claims, anything involving physical safety) generally warrant the protection of a GmbH even at startup.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-02-3', 'mba-step-02',
'The decision tree looks like this:',
NULL, NULL,
'graph TD
    A[Start Business] --> B{Risk Level?}
    B -->|Low Risk<br/>Consulting, Design,<br/>Writing| C[Einzelunternehmen]
    B -->|Medium Risk<br/>Retail, Food Service| D[Consider GmbH]
    B -->|High Risk<br/>Construction, Manufacturing| E[GmbH Recommended]
    C --> F{Revenue Growing?}
    F -->|Over CHF 100k/year| G[Consider GmbH later]
    F -->|Under CHF 100k/year| H[Stay Einzelunternehmen]
    style C fill:#e1f5ff
    style E fill:#ffe1e1',
2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-02-4', 'mba-step-02',
'Tax note: Einzelunternehmen profits are taxed as personal income, which can be advantageous at lower income levels (progressive tax rates) but expensive at high income levels. GmbH profits are taxed at corporate rates (often lower for retained earnings) plus tax on dividends when distributed. If you plan to reinvest profits in growth, GmbH can be tax-efficient.',
NULL,
'A common mistake: choosing a structure based only on liability without considering the tax implications. At CHF 150,000 profit per year, the tax difference can be thousands of francs.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-02-1', 'mba-step-02', 'q02-1', 'What is the minimum capital required to form a GmbH in Switzerland?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-02-1a', 'mba-q-02-1', 'CHF 5,000', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-02-1b', 'mba-q-02-1', 'CHF 20,000', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-02-1c', 'mba-q-02-1', 'CHF 50,000', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-02-1d', 'mba-q-02-1', 'CHF 100,000', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-02-2', 'mba-step-02', 'q02-2', 'Which business structure has unlimited personal liability?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-02-2a', 'mba-q-02-2', 'GmbH (Gesellschaft mit beschränkter Haftung)', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-02-2b', 'mba-q-02-2', 'AG (Aktiengesellschaft)', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-02-2c', 'mba-q-02-2', 'Sole proprietorship (Einzelunternehmen)', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-02-2d', 'mba-q-02-2', 'All of the above require CHF 20,000 minimum capital', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-02-3', 'mba-step-02', 'q02-3', 'Why might a high-risk business like construction warrant forming a GmbH even at startup?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-02-3a', 'mba-q-02-3', 'Because GmbHs pay lower taxes in the first three years under cantonal startup incentive schemes', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-02-3b', 'mba-q-02-3', 'Because it looks more professional to clients', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-02-3c', 'mba-q-02-3', 'To protect personal assets from liability claims', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-02-3d', 'mba-q-02-3', 'Because banks will only lend to GmbHs', FALSE, 3);

-- ============================================================
-- PAGE 3: Registering Your Business
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-03', 'business-fundamentals-mba', 'registering-business',
'Registering Your Business',
'Thomas, 21, started tutoring students in programming. He charged CHF 60 per hour, made CHF 2,000 in his first month, and thought he was set. Three months later, the cantonal tax office (Steueramt) sent him a letter demanding back taxes plus a fine for operating without registration. He also learned he should have registered with the social security system from day one. His "profit" was suddenly much smaller. Registration is not optional bureaucracy — it is the law, and ignoring it gets expensive fast.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-03-1', 'mba-step-03', 'Trade Licence',
'The permit (Gewerbebewilligung / autorisation de commerce) from your canton to operate a business. Most businesses need this, though some professions (like doctors or lawyers) have different regulatory paths. Apply at your canton''s economic affairs department. Cost varies by canton (CHF 100-500). Processing time: usually 2-4 weeks.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-03-2', 'mba-step-03', 'Commercial Register',
'The official registry (Handelsregister / Registre du commerce) of companies. Sole proprietorships only register if annual revenue exceeds CHF 100,000. GmbH and AG must register within 30 days of formation. Registration creates public transparency: anyone can see who owns and manages the company.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-03-3', 'mba-step-03', 'Old Age Insurance',
'The foundation of Swiss social security (AHV / AVS — assurance-vieillesse et survivants). Every person working in Switzerland must be registered. As a self-employed person, you pay both the employee and employer portions (approximately 10.6% of income up to a ceiling). The SVA/AC (Ausgleichskasse / Caisse de compensation) collects these contributions.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-03-4', 'mba-step-03', 'Enterprise ID',
'Switzerland''s business identification number (UID-Nummer / numéro IDE). Every registered business gets one. You will use it on invoices, tax filings, and official correspondence. It replaces the old VAT number for VAT purposes too.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-03-5', 'mba-step-03', 'Back Payment',
'What happens (Nachzahlung / paiement rétroactif) when you fail to register or pay on time. Swiss authorities are thorough. They will calculate what you owe from the start of your activity, add interest, and possibly impose fines. Back payments can destroy a young business. Do not risk it.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-03-1', 'mba-step-03',
'The registration sequence for an Einzelunternehmen in most cantons:',
NULL, NULL,
'graph TD
    A[Start Activity] --> B[Gewerbebewilligung<br/>from Canton]
    B --> C[AHV Registration<br/>with SVA/AC]
    C --> D[UID Number<br/>Assigned]
    D --> E[Bank Account<br/>Business or Personal]
    E --> F[First Invoice<br/>with UID Number]',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-03-2', 'mba-step-03',
'For a GmbH, the process is more complex and requires a notary (Notar/notaire):',
NULL, NULL,
'graph TD
    A[Founders Meeting] --> B[Notary Drafts<br/>Articles of Association]
    B --> C[Capital Deposit<br/>CHF 20,000 in Escrow]
    C --> D[Handelsregister Entry]
    D --> E[Gewerbebewilligung]
    E --> F[AHV Registration]
    F --> G[Bank Account<br/>in Company Name]',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-03-3', 'mba-step-03',
'A true story: Nina, 24, started a jewellery business on Etsy. She thought "online" meant "no need to register." Wrong. The Swiss tax authority data-matches income reports from payment processors. She received a friendly but firm letter asking about her "hobby." She registered, paid the back taxes, and learned that even small online businesses must follow the rules. The silver lining: once registered, she could deduct business expenses like materials and tools.',
NULL,
'Many young entrepreneurs think small online businesses "fly under the radar." They do not. Swiss tax authorities exchange data with platforms like Etsy, eBay, and PayPal.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-03-4', 'mba-step-03',
'Timeline tip: Start your registration process 4-6 weeks before you plan to launch. Some cantons are faster, others slower. You cannot legally invoice before you have your UID number (for larger transactions) and Gewerbebewilligung. Plan accordingly.',
NULL,
'Exception: If you are testing a business idea with minimal revenue (under CHF 2,300/year), you might operate as a "Nebenerwerb" (secondary occupation) initially. But the thresholds are low — verify with your canton.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-03-1', 'mba-step-03', 'q03-1', 'What is the UID-Nummer?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-03-1a', 'mba-q-03-1', 'A social media handle required for all Swiss businesses that register on the cantonal platform', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-03-1b', 'mba-q-03-1', 'Switzerland''s official enterprise identification number (UID)', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-03-1c', 'mba-q-03-1', 'A password for accessing the cantonal tax website', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-03-1d', 'mba-q-03-1', 'The minimum capital required to start a business', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-03-2', 'mba-step-03', 'q03-2', 'What happened to Thomas, the programming tutor, because he did not register properly?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-03-2a', 'mba-q-03-2', 'He received a government grant for being innovative', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-03-2b', 'mba-q-03-2', 'He was invited to join a cantonal business accelerator programme', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-03-2c', 'mba-q-03-2', 'He received a tax office letter demanding back taxes plus fines', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-03-2d', 'mba-q-03-2', 'His students paid him in cryptocurrency', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-03-3', 'mba-step-03', 'q03-3', 'How long before launching should you start the registration process?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-03-3a', 'mba-q-03-3', 'The day before', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-03-3b', 'mba-q-03-3', '4-6 weeks', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-03-3c', 'mba-q-03-3', '6 months', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-03-3d', 'mba-q-03-3', 'Registration is automatic when you start', FALSE, 3);

-- ============================================================
-- PAGE 4: Swiss Company Law — What Directors Must Know
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-04', 'business-fundamentals-mba', 'swiss-company-law',
'Swiss Company Law — What Directors Must Know',
'In 2019, a 26-year-old founder of a small tech startup in Geneva became personally liable for CHF 180,000 in unpaid social security contributions. His company had cash flow problems, so he paid suppliers first and planned to catch up on social charges "next month." That was a crime. As Geschäftsführer (gérant), you have duties you cannot delegate. Violating them can mean personal bankruptcy or prison. This is not scaremongering — this is Swiss law.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-04-1', 'mba-step-04', 'Code of Obligations',
'The Swiss federal law (Obligationenrecht / Code des obligations — OR/CO) governing contracts, companies, and commercial obligations. Articles 530-926 cover companies. As a business owner, you are bound by these rules whether you have read them or not. Ignorance is not a defence.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-04-2', 'mba-step-04', 'Duty of Care',
'The legal requirement (Sorgfaltspflicht / devoir de diligence) that a managing director act with the care of a prudent businessman. This means keeping proper books, monitoring cash flow, and not taking reckless risks. Breaching this duty can lead to personal liability for resulting damages.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-04-3', 'mba-step-04', 'Over-Indebtedness',
'When liabilities exceed assets (Überschuldung / surendettement), or when unable to pay debts as they fall due. Under Article 725 OR, directors must file for bankruptcy within 30 days of discovering over-indebtedness. Delaying is a criminal offence.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-04-4', 'mba-step-04', 'Director Liability',
'The personal liability (Geschäftsführerhaftung / responsabilité du gérant) of directors — while GmbH/AG structures limit liability to company assets, directors remain personally liable for certain obligations: unpaid social security (AHV/AVS), withholding taxes, and VAT if the company fails to pay. These are considered "trust" obligations to the state.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-04-5', 'mba-step-04', 'Non-Competition',
'The prohibition (Konkurrenzverbot / interdiction de concurrence) on competition — as managing director, you cannot run competing businesses or work for competitors without approval. This duty of loyalty exists as long as you hold the position and often continues briefly after leaving.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-04-1', 'mba-step-04',
'The story of the Geneva founder is not unique. Every year, dozens of young entrepreneurs face personal liability because they did not understand their obligations. Here is what sinks them:',
NULL,
'1. Paying suppliers before paying employee social charges<br/>2. Using company money for personal expenses<br/>3. Not filing for bankruptcy when the company is clearly insolvent<br/>4. Failing to keep proper accounting records',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-04-2', 'mba-step-04',
'Your fiduciary duties as Geschäftsführer look like this:',
NULL, NULL,
'graph TD
    A[Geschäftsführer Duties] --> B[Sorgfaltspflicht<br/>Duty of Care]
    A --> C[Treuepflicht<br/>Duty of Loyalty]
    A --> D[Überschuldungspflicht<br/>Bankruptcy Filing]
    B --> E[Proper Bookkeeping]
    B --> F[Prudent Decisions]
    C --> G[No Competition]
    C --> H[No Self-Dealing]
    D --> I[File within 30 Days]
    style A fill:#ffe1e1
    style D fill:#ff9999',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-04-3', 'mba-step-04',
'A cautionary tale from Lucerne: Anna, 25, ran a small catering business as a GmbH. When cash got tight, she stopped paying the AHV contributions for her one employee, planning to catch up "after wedding season." The SVA noticed after 6 months. She became personally liable for CHF 45,000 plus penalties. The GmbH protection did not help — social security obligations follow the director personally.',
NULL,
'This is the most common trap: young entrepreneurs think "limited liability" means "no personal risk." It does not. Certain obligations pierce the corporate veil, and social security is the big one.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-04-4', 'mba-step-04',
'Key takeaway: If your business is struggling, speak to a Treuhand (fiduciaire) or lawyer immediately. The sooner you address problems, the more options you have. Waiting makes everything worse — legally and financially.',
NULL,
'Swiss bankruptcy law actually encourages restructuring. If you act early, you might save the business. If you wait until you are hopelessly over-indebted, you will likely lose everything.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-04-1', 'mba-step-04', 'q04-1', 'Under Article 725 OR, how long do directors have to file for bankruptcy after discovering over-indebtedness?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-04-1a', 'mba-q-04-1', '90 days', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-04-1b', 'mba-q-04-1', '60 days', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-04-1c', 'mba-q-04-1', '30 days', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-04-1d', 'mba-q-04-1', 'There is no specific deadline', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-04-2', 'mba-step-04', 'q04-2', 'For which obligations does a Geschäftsführer remain personally liable even in a GmbH?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-04-2a', 'mba-q-04-2', 'Only bank loans taken out in the company name', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-04-2b', 'mba-q-04-2', 'Only rent and lease payments on company premises', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-04-2c', 'mba-q-04-2', 'AHV/AVS social contributions, withholding tax on salaries, and VAT collected from customers', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-04-2d', 'mba-q-04-2', 'Personal liability does not exist in a GmbH — the corporate veil is absolute', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-04-3', 'mba-step-04', 'q04-3', 'What happened to Anna, the catering business owner?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-04-3a', 'mba-q-04-3', 'She successfully expanded to three catering locations across Lucerne and the surrounding region', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-04-3b', 'mba-q-04-3', 'She faced personal liability for CHF 45,000 in AHV', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-04-3c', 'mba-q-04-3', 'She sold her business for a profit after two profitable years', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-04-3d', 'mba-q-04-3', 'She received a special emergency government assistance package from the cantonal welfare office', FALSE, 3);

-- ============================================================
-- PAGE 5: The Swiss VAT System
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-05', 'business-fundamentals-mba', 'swiss-vat-system',
'The Swiss VAT System',
'When Felix turned 20, his mobile app development side hustle suddenly took off. He went from CHF 3,000 per year to CHF 35,000 in six months. What he did not know: the CHF 100,000 turnover threshold for mandatory VAT registration. He kept charging clients without adding MWST/TVA. When he finally registered (after a client asked for a VAT invoice), he had to pay the VAT out of his own pocket for all previous sales — a CHF 8,000 lesson. VAT is simple once you understand it. Painful when you do not.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-05-1', 'mba-step-05', 'VAT',
'Value added tax (MWST / TVA — Taxe sur la Valeur Ajoutée) — a consumption tax on goods and services. In Switzerland, businesses collect VAT from customers and remit it to the federal tax administration (ESTV/AFC). You are essentially a tax collector for the government. The current standard rate is 8.1% (as of 2024).',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-05-2', 'mba-step-05', 'Input Tax Deduction',
'The mechanism (Vorsteuerabzug / déduction de l''impôt préalable) where businesses can deduct the VAT they paid on purchases from the VAT they collected on sales. You only remit the difference. This prevents VAT from accumulating through the supply chain. If you buy materials for CHF 1,000 + CHF 81 VAT, and sell the product for CHF 2,000 + CHF 162 VAT, you remit CHF 81 (162 - 81) to the government.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-05-3', 'mba-step-05', 'Effective Taxation',
'The standard VAT accounting method (Effektivbesteuerung / taxation effective) where you track every transaction with VAT. Required if your annual turnover exceeds CHF 5.02 million or if you want to claim input tax on most purchases. More paperwork, but often beneficial for B2B businesses.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-05-4', 'mba-step-05', 'Net Tax Rate Method',
'A simplified VAT calculation where you apply a flat-rate percentage to your total revenue rather than tracking every transaction (Saldo-Methode / méthode du solde). Available for businesses with turnover under CHF 5.02 million and fewer than 20 employees. Less paperwork, but you cannot claim input tax on purchases.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-05-5', 'mba-step-05', 'Federal Tax Administration',
'The authority that collects VAT in Switzerland (ESTV / AFC — Administration fédérale des contributions). You file returns quarterly or semi-annually, depending on your revenue. Late filings incur penalties.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-05-1', 'mba-step-05',
'The CHF 100,000 threshold is crucial. Below it, VAT registration is voluntary (and usually not worth the hassle). Above it, mandatory. But here is the trap: turnover includes ALL revenue, even VAT-exempt sales. If you have CHF 80,000 in taxable sales plus CHF 30,000 in exempt sales (like exports), you are over the threshold.',
NULL,
'Felix''s mistake: he calculated based on taxable sales only. When he added a big export project, he crossed the threshold without realising.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-05-2', 'mba-step-05',
'How VAT flows through a business:',
NULL, NULL,
'graph TD
    A[You Buy Materials<br/>Pay CHF 1,000 + CHF 81 VAT] --> B[You Make Product]
    B --> C[You Sell Product<br/>Charge CHF 2,000 + CHF 162 VAT]
    C --> D[VAT Collected<br/>CHF 162]
    A --> E[VAT Paid<br/>CHF 81]
    D --> F[Remit to ESTV<br/>CHF 162 - CHF 81 = CHF 81]',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-05-3', 'mba-step-05',
'A practical example: Lisa runs a graphic design business. She buys a CHF 3,000 MacBook (CHF 243 VAT included). She invoices a client CHF 10,000 for a project (CHF 810 VAT). When filing her quarterly return, she declares CHF 810 collected minus CHF 243 paid = CHF 567 to remit. The MacBook just got cheaper by CHF 243 thanks to input tax deduction.',
NULL,
'This is why B2B businesses generally want effective taxation: all that equipment and software becomes cheaper by 8.1%.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-05-4', 'mba-step-05',
'Simplified method (Saldo-Methode) example: Tom is a hairdresser with CHF 150,000 annual turnover. He uses the net tax rate of 5.9% for his industry. His VAT liability: CHF 150,000 × 5.9% = CHF 8,850. Simple, no tracking every purchase. But he cannot deduct the VAT on his CHF 20,000 salon equipment purchase. For capital-intensive businesses, effective taxation is usually better.',
NULL,
'Each industry has its own net tax rate: restaurants 6.7%, retail 5.5%, construction 6.2%, etc. Check the ESTV website for your rate.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-05-1', 'mba-step-05', 'q05-1', 'What is the mandatory VAT registration threshold in Switzerland?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-05-1a', 'mba-q-05-1', 'CHF 50,000 annual turnover', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-05-1b', 'mba-q-05-1', 'CHF 100,000 annual turnover', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-05-1c', 'mba-q-05-1', 'CHF 250,000 annual turnover', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-05-1d', 'mba-q-05-1', 'There is no threshold — all businesses must register immediately', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-05-2', 'mba-step-05', 'q05-2', 'What is Vorsteuerabzug (input tax deduction)?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-05-2a', 'mba-q-05-2', 'A discount offered to loyal B2B customers who pay before the due date', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-05-2b', 'mba-q-05-2', 'Claiming back VAT paid on business purchases against VAT collected on sales', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-05-2c', 'mba-q-05-2', 'A tax exemption for newly founded businesses in their first year', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-05-2d', 'mba-q-05-2', 'The mandatory penalty imposed by the ESTV for late VAT filing', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-05-3', 'mba-step-05', 'q05-3', 'What was Felix''s mistake with his app development business?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-05-3a', 'mba-q-05-3', 'He overcharged VAT to his clients and had to refund the difference to the ESTV', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-05-3b', 'mba-q-05-3', 'He crossed the CHF 100,000 VAT threshold without registering and owed back-payments', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-05-3c', 'mba-q-05-3', 'He voluntarily registered for VAT too early, which triggered compulsory quarterly filing obligations and penalties', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-05-3d', 'mba-q-05-3', 'He submitted his VAT returns daily rather than on the standard quarterly schedule', FALSE, 3);

-- ============================================================
-- PAGE 6: Swiss Accounting Requirements
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-06', 'business-fundamentals-mba', 'swiss-accounting-requirements',
'Swiss Accounting Requirements',
'In 2022, a 26-year-old event planner in Basel nearly lost her business to a simple mistake: she could not produce proper financial statements when applying for a loan. Her "accounting" was a shoebox of receipts and an Excel spreadsheet with more errors than cells. The bank said no. A potential investor said no. She spent three months reconstructing two years of books with a Treuhand (fiduciaire), paying CHF 8,000 for what should have cost CHF 2,000 if done properly from the start. Accounting is not optional decoration — it is the navigation system of your business.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-06-1', 'mba-step-06', 'Proper Bookkeeping',
'The legal standard for Swiss businesses under the OR/CO (Ordentliche Buchführung / comptabilité régulière). Requires recording all business transactions completely, correctly, and in a timely manner. Must show the financial position accurately. If your books are messy, you cannot file proper taxes, get loans, or sell your business.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-06-2', 'mba-step-06', 'Double-Entry Bookkeeping',
'The standard accounting system where every transaction affects two accounts (debit and credit) (Doppelte Buchführung / comptabilité en partie double). Required for larger businesses (revenue over CHF 500,000 or capital over CHF 100,000) and all GmbH/AG structures. Provides built-in error checking and produces a complete financial picture.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-06-3', 'mba-step-06', 'Profit and Loss Statement',
'Shows revenue, expenses, and profit over a period, usually one year (Erfolgsrechnung / compte de résultat). Required annually. Tells you if your business is making money. Without it, you are flying blind.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-06-4', 'mba-step-06', 'Balance Sheet',
'A snapshot of assets, liabilities, and equity at a specific date (Bilanz / bilan). Shows what the business owns and owes. Required annually for all businesses using double-entry bookkeeping. Essential for understanding financial health.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-06-5', 'mba-step-06', 'Fiduciary',
'A professional who handles bookkeeping, accounting, and tax filing for businesses (Treuhand / fiduciaire). Not legally required to use one (you can do your own books), but highly recommended unless you enjoy spending weekends on accounting software.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-06-1', 'mba-step-06',
'Record keeping requirements: Swiss law requires you to keep all business records for 10 years. This includes invoices (sent and received), bank statements, contracts, receipts, and accounting records. Digital copies are acceptable if they are complete and unalterable.',
NULL,
'The shoebox method is not sufficient. Digital tools like Bexio, Run my Accounts, or even Excel (if properly structured) work fine. But you need an organised system.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-06-2', 'mba-step-06',
'How accounting produces the two key financial statements:',
NULL, NULL,
'graph TD
    A[All Transactions<br/>Invoices, Payments] --> B[Journal Entries]
    B --> C[Ledger Accounts]
    C --> D[Year-End<br/>Adjustments]
    D --> E[Erfolgsrechnung<br/>Revenue - Expenses = Profit]
    D --> F[Bilanz<br/>Assets = Liabilities + Equity]
    style E fill:#e1f5ff
    style F fill:#fff4e1',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-06-3', 'mba-step-06',
'Jan, a 24-year-old photographer, learned this lesson cheaply. He started using Bexio (cloud accounting software) from day one. Cost: CHF 29/month. Result: He always knew his cash position, his tax filings took 30 minutes, and when he needed a CHF 20,000 equipment loan after 18 months, the bank approved it in 48 hours because his books were clean. Good accounting is a competitive advantage.',
NULL,
'Popular Swiss accounting tools: Bexio (user-friendly for small businesses), Run my Accounts (popular with startups), Banana Accounting (traditional, powerful), and standard software like QuickBooks or Sage.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-06-4', 'mba-step-06',
'When do you need a Revision (audit)? Only larger businesses need one: if you exceed two of the following three criteria for two consecutive years — CHF 20 million balance sheet total, CHF 40 million revenue, or 250 full-time employees. For most small businesses, no audit required. But you still need proper books.',
NULL,
'Even without an audit, the tax authorities can request to see your books. And if they are messy, you will spend painful hours reconstructing transactions.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-06-1', 'mba-step-06', 'q06-1', 'How long must Swiss businesses keep their accounting records?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-06-1a', 'mba-q-06-1', '3 years', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-06-1b', 'mba-q-06-1', '5 years', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-06-1c', 'mba-q-06-1', '10 years', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-06-1d', 'mba-q-06-1', 'Permanently', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-06-2', 'mba-step-06', 'q06-2', 'What is doppelte Buchführung (double-entry bookkeeping)?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-06-2a', 'mba-q-06-2', 'Keeping two entirely separate and independent ledgers to cross-verify totals and catch errors automatically', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-06-2b', 'mba-q-06-2', 'Every transaction affects two accounts — one debited, one credited', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-06-2c', 'mba-q-06-2', 'Hiring two different accountants to verify each other''s work', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-06-2d', 'mba-q-06-2', 'Keeping both physical and digital copies of all receipts and invoices', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-06-3', 'mba-step-06', 'q06-3', 'Why was the event planner in Basel unable to get a loan?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-06-3a', 'mba-q-06-3', 'She had too much outstanding revenue that the bank considered high risk', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-06-3b', 'mba-q-06-3', 'She could not produce proper financial statements — her records were an unsorted shoebox of receipts', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-06-3c', 'mba-q-06-3', 'She had never filed taxes since starting her event planning business', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-06-3d', 'mba-q-06-3', 'Swiss banks do not lend to people under 30 years old', FALSE, 3);
