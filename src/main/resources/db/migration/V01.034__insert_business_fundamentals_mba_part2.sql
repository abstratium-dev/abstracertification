-- ============================================================
-- Business Fundamentals for New Entrepreneurs — Part 2
-- Pages 7-12
-- ============================================================

-- ============================================================
-- PAGE 7: Understanding Financial Statements
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-07', 'business-fundamentals-mba', 'understanding-financial-statements',
'Understanding Financial Statements',
'Sophie, 23, ran a successful Instagram marketing agency. She had 15 clients, a cool office in a converted factory, and a sense that things were going great. Then she looked at her bank account and saw CHF 847. How could she be "successful" but broke? The answer was in her financial statements — which she had never learned to read. Her profit and loss showed CHF 200,000 in revenue but CHF 190,000 in expenses. Her balance sheet showed she owed CHF 30,000 more than she owned. She was profitable on paper but had negative cash flow. She survived by learning to read the story her numbers were telling.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-07-1', 'mba-step-07', 'Profit and Loss Statement',
'Shows revenue minus expenses (Erfolgsrechnung / compte de résultat) over a period. The formula: Revenue - Cost of Goods Sold = Gross Profit; Gross Profit - Operating Expenses = Operating Profit; Operating Profit - Interest and Taxes = Net Profit. Tells you if your business model works.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-07-2', 'mba-step-07', 'Balance Sheet',
'A financial statement (Bilanz / bilan) that shows what the business owns (assets) and owes (liabilities) at a point in time. Assets = Liabilities + Equity. The balance sheet reveals financial health: can you pay your debts? Do you have enough working capital? Are you solvent?',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-07-3', 'mba-step-07', 'Equity',
'The owner''s stake (Eigenkapital / capitaux propres) in the business. Calculated as Assets minus Liabilities. Positive equity means the business owns more than it owes. Negative equity means insolvency — technically bankrupt. Growing equity means building value.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-07-4', 'mba-step-07', 'Contribution Margin',
'Revenue minus variable costs (Deckungsbeitrag / contribution à la couverture). Shows how much each sale contributes to covering fixed costs. If your contribution margin is negative, you lose money on every sale. Critical for pricing decisions.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-07-5', 'mba-step-07', 'Working Capital',
'Working capital (fonds de roulement) — current assets minus current liabilities. Measures liquidity: can you pay short-term obligations? Positive working capital means you can operate smoothly. Negative working capital is a crisis. Many profitable businesses fail from negative working capital.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-07-1', 'mba-step-07',
'Sophie''s problem was classic: she confused profit with cash. You can be profitable and broke. How? If clients pay in 60 days (accounts receivable) but you pay suppliers in 30 days (accounts payable), you are constantly funding a gap. Your P&L looks good, but your cash position is dire.',
NULL,
'Her breakthrough came when she started offering 2% discounts for payment within 10 days. Her average collection time dropped from 58 days to 23 days. Suddenly, she had cash.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-07-2', 'mba-step-07',
'The relationship between the three key statements:',
NULL, NULL,
'graph TD
    ER[Erfolgsrechnung<br/>P&L Statement] -->|Net Profit flows to| EK[Eigenkapital<br/>Equity on Bilanz]
    ER -->|Affects| CF[Cashflow<br/>Cash Movement]
    CF -->|Changes| BA[Bilanz Assets<br/>Cash Position]
    style ER fill:#e1f5ff
    style EK fill:#fff4e1
    style CF fill:#f0ffe1',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-07-3', 'mba-step-07',
'The story of the bakery that was not: Maria, 25, opened a gluten-free bakery. Her P&L showed CHF 15,000 monthly profit. But her cash was vanishing. The problem: she bought organic ingredients cash-upfront (7-day payment) but sold to cafes on 45-day terms. She needed CHF 20,000 in working capital just to operate. She got a credit line from her bank, adjusted her supplier terms, and survived.',
NULL,
'Working capital requirement = (Days Inventory + Days Receivables - Days Payables) × Daily Revenue. If this number is positive, you need funding to operate.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-07-4', 'mba-step-07',
'Key ratios to watch: 1) Current ratio (current assets/current liabilities) — should be above 1.2; 2) Debt-to-equity (liabilities/equity) — lower is safer; 3) Gross margin (gross profit/revenue) — shows pricing power; 4) Net margin (net profit/revenue) — shows overall efficiency. You do not need to calculate these daily, but check them monthly.',
NULL,
'Most accounting software calculates these automatically. Look at the "Kennzahlen" or "Indicateurs" section.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-07-1', 'mba-step-07', 'q07-1', 'What is the formula for calculating Eigenkapital (equity)?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-07-1a', 'mba-q-07-1', 'Total annual revenue minus total annual operating expenses', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-07-1b', 'mba-q-07-1', 'Total assets minus total liabilities equals owner equity', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-07-1c', 'mba-q-07-1', 'Total cash balance minus total outstanding debt obligations', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-07-1d', 'mba-q-07-1', 'Sales price minus variable production cost per unit sold', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-07-2', 'mba-step-07', 'q07-2', 'Why was Sophie''s marketing agency broke despite being "successful"?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-07-2a', 'mba-q-07-2', 'She had no clients and had not generated any revenue in the previous quarter', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-07-2b', 'mba-q-07-2', 'Negative cash flow from slow-paying clients', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-07-2c', 'mba-q-07-2', 'She overspent on office renovation, new furniture, and branded equipment', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-07-2d', 'mba-q-07-2', 'She consistently undercharged clients and never raised her prices despite growing demand', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-07-3', 'mba-step-07', 'q07-3', 'What is Working Capital?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-07-3a', 'mba-q-07-3', 'The total cumulative amount of money the business has ever made since founding', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-07-3b', 'mba-q-07-3', 'Current assets minus current liabilities — the short-term financial buffer of the business', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-07-3c', 'mba-q-07-3', 'The owner''s monthly salary drawn from profits', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-07-3d', 'mba-q-07-3', 'The total value of all equipment and machinery owned by the business', FALSE, 3);

-- ============================================================
-- PAGE 8: Taxation for Swiss Businesses
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-08', 'business-fundamentals-mba', 'swiss-business-taxation',
'Taxation for Swiss Businesses',
'Leo, 24, made CHF 80,000 in his first year as a freelance videographer. He was thrilled — until his Steuerberater (tax advisor) calculated his tax bill: CHF 18,000. Leo had not set aside money for taxes. He had spent it on equipment, travel, and a new apartment. He spent the next 18 months paying off a tax debt while barely scraping by. Tax planning is not something you do once a year. It is something you do every month. And Switzerland''s three-layer tax system makes it more complex — but also more manageable if you understand it.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-08-1', 'mba-step-08', 'Direct Federal Tax',
'The federal income tax (DBG / IFD — impôt fédéral direct) applied to personal and business income. For sole proprietors, this is part of their personal tax return. For GmbH/AG, the company pays corporate tax at federal and cantonal levels, then shareholders pay tax on dividends.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-08-2', 'mba-step-08', 'Cantonal and Municipal Taxes',
'The largest component (Staats- und Gemeindesteuern / impôts cantonaux et communaux) of Swiss tax burden. Rates vary dramatically by canton: Zug is famous for low taxes (around 12% total for corporations), while Geneva is higher (around 24%). Where you register your business matters significantly.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-08-3', 'mba-step-08', 'Profit Tax',
'The tax (Gewinnsteuer / impôt sur le bénéfice) on business profits. For GmbH/AG, this includes both cantonal and federal corporate tax. Rates vary by canton, typically 12-24% combined. For sole proprietors, business profit is taxed as personal income, which can be advantageous at lower income levels.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-08-4', 'mba-step-08', 'Pillar 3a',
'Tax-advantaged retirement savings (Säule 3a / pilier 3a). Contributions are tax-deductible (up to CHF 7,056 for employees, CHF 35,280 for self-employed in 2024). Reduces taxable income while building retirement wealth. Available through banks and insurance companies. Every self-employed person should use this.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-08-5', 'mba-step-08', 'Depreciation',
'Deducting the cost (Abschreibung / amortissement) of equipment and assets over their useful life. A CHF 5,000 computer might be depreciated over 3 years (CHF 1,667 per year). Reduces taxable profit. Different assets have different depreciation periods set by the tax authorities.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-08-1', 'mba-step-08',
'Switzerland''s three-layer tax system explained:',
NULL, NULL,
'graph TD
    A[Business Profit] --> B{Business Structure?}
    B -->|Einzelunternehmen| C[Taxed as Personal Income<br/>DBG + Cantonal<br/>Progressive Rates]
    B -->|GmbH/AG| D[Corporate Tax First<br/>Gewinnsteuer]
    D --> E[Retained Earnings<br/>Lower Immediate Tax]
    D --> F[Dividends to Owner<br/>Taxed as Income]
    C --> G[One Tax Layer]
    F --> H[Two Tax Layers<br/>But Dividend Income<br/>Often Reduced Rate]',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-08-2', 'mba-step-08',
'The smart move for Leo would have been: 1) Setting aside 25% of every payment for taxes immediately; 2) Making quarterly prepayments (Vorauszahlungen / acomptes) to spread the burden; 3) Maximising Säule 3a contributions to reduce taxable income; 4) Tracking all business expenses for deduction.',
NULL,
'Most young entrepreneurs should set aside 20-30% of revenue for taxes. If you end up owing less, you have savings. If you owe more, you are prepared.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-08-3', 'mba-step-03',
'Deductible expenses include: office rent, equipment (depreciated), software subscriptions, professional development, travel for business, meals with clients (usually 50%), insurance, phone and internet (business portion), and even part of your home if you have a dedicated office space. Keep every receipt.',
NULL,
'The rule: expenses must be commercially justified and documented. That CHF 200 business lunch is deductible if you discussed work and kept the receipt with a note about who you met.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-08-4', 'mba-step-08',
'Nina, 26, a freelance designer, learned to love tax planning. She bought her CHF 3,500 MacBook in December rather than January — getting the depreciation deduction one year earlier. She maxed out her Säule 3a contribution every January, reducing her quarterly prepayments. She paid her professional association fees in advance. These moves saved her CHF 4,000 in taxes annually.',
NULL,
'Tax planning is not evasion (illegal) — it is arranging your affairs legally to minimise tax. Everyone has the right to do this.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-08-1', 'mba-step-08', 'q08-1', 'What percentage of revenue should most young entrepreneurs set aside for taxes?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-08-1a', 'mba-q-08-1', 'Around 5% is enough to cover all Swiss federal and cantonal taxes', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-08-1b', 'mba-q-08-1', 'About 10% covers most tax scenarios', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-08-1c', 'mba-q-08-1', '20-30% of revenue should be set aside to cover all tax obligations safely', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-08-1d', 'mba-q-08-1', 'Half of all revenue should be reserved since Switzerland has some of the highest tax rates in Europe', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-08-2', 'mba-step-08', 'q08-2', 'What is Säule 3a?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-08-2a', 'mba-q-08-2', 'A mandatory business liability insurance required from all Swiss SMEs', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-08-2b', 'mba-q-08-2', 'Voluntary tax-deductible retirement savings that also reduce your annual taxable income', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-08-2c', 'mba-q-08-2', 'The third layer of Swiss company law covering directors'' obligations', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-08-2d', 'mba-q-08-2', 'A special reduced tax rate applied exclusively to registered Swiss tech startups', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-08-3', 'mba-step-08', 'q08-3', 'Why did Leo struggle financially after his first year?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-08-3a', 'mba-q-08-3', 'He did not have enough clients to generate sufficient revenue', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-08-3b', 'mba-q-08-3', 'He had not set aside tax money and spent it all on personal and business expenses', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-08-3c', 'mba-q-08-3', 'The cantonal tax authority assessed him at an unusually high 50% rate', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-08-3d', 'mba-q-08-3', 'He never formally registered his freelance business with the authorities', FALSE, 3);

-- ============================================================
-- PAGE 9: Employment Law in Switzerland
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-09', 'business-fundamentals-mba', 'employment-law',
'Employment Law in Switzerland',
'Max, 27, hired his first employee — a developer — at CHF 8,000 per month. He was proud. Three months later, he faced a CHF 15,000 fine from the cantonal labour office because his employment contract violated multiple rules: no written contract provided, working hours not documented, no rest period rules communicated. Max thought he was being "flexible" and "startup-friendly." Swiss employment law thought he was being negligent. When you hire someone, you step into a web of obligations that you cannot ignore.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-09-1', 'mba-step-09', 'Employment Contract',
'The agreement (Arbeitsvertrag / contrat de travail) between employer and employee. Under Swiss law (OR/CO Art. 319ff), certain elements must be in writing: parties, start date, job description, salary, working hours. While oral contracts are technically valid, written is mandatory for proving terms and required by law in most cases.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-09-2', 'mba-step-09', 'Notice Period',
'The advance notice (Kündigungsfrist / délai de congé) required to terminate employment. By law: 7 days during probation, 1 month in first year, 2 months in second year, 3 months thereafter. Can be extended by contract, never shortened below statutory minimum.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-09-3', 'mba-step-09', 'Payroll Accounting',
'The tracking (Lohnbuchhaltung / comptabilité de salaires) of all salary payments, deductions, and social charges. Every payment to an employee must be documented with a payslip (Lohnabrechnung / bulletin de salaire) showing gross salary, all deductions, and net pay. Required for tax and social security compliance.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-09-4', 'mba-step-09', 'Withholding Tax',
'Tax deducted at source (Quellensteuer / impôt à la source) from salaries for employees who are not Swiss citizens or C-permit holders. The employer acts as tax collector, deducting tax from each paycheck and remitting it to the canton. Foreign employees typically start with withholding tax.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-09-5', 'mba-step-09', 'Occupational Pension',
'The occupational pension law (BVG / LPP — Loi sur la prévoyance professionnelle) requires employers to provide pension coverage for employees earning over CHF 22,050 annually (as of 2024). The employer must join a pension fund (Pensionskasse / caisse de pension) and contribute at least 50% of the premiums.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-09-1', 'mba-step-09',
'The true cost of an employee is much higher than their salary. For a CHF 6,000/month salary, the employer typically pays an additional 15-20% in social charges: employer AHV/AVS (5.3%), employer BVG/LPP (varies, 3-8%), employer Unfallversicherung (0.5-5%), and other insurances. That CHF 6,000 employee costs CHF 7,000-7,200.',
NULL,
'Young entrepreneurs often underestimate this. They budget for the salary and forget the "Nebenkosten" (charges annexes) — then wonder why they are losing money.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-09-2', 'mba-step-09',
'Your obligations as an employer flow like this:',
NULL, NULL,
'graph TD
    A[Hire Employee] --> B[Written Contract<br/>Required Elements]
    B --> C[Register with SVA/AC<br/>AHV/AVS within 30 days]
    C --> D[Set Up Payroll<br/>Monthly or Quarterly]
    D --> E[BVG Registration<br/>If Salary > CHF 22,050]
    E --> F[Quarterly Reporting<br/>To SVA/AC]
    F --> G[Year-End Statements<br/>Lohnausweis]',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-09-3', 'mba-step-09',
'Anna, 25, runs a small café. She hired a barista and thought a verbal agreement was "more trusting." When the relationship soured, she had no documentation of agreed terms. The employee claimed she was promised CHF 5,500/month; Anna remembered CHF 5,000. Without a written contract, Anna had no proof. The dispute cost her CHF 8,000 in legal fees.',
NULL,
'Written contracts protect both parties. They prevent misunderstandings and provide clarity. Never skip this because you are "friends" or "trust each other."',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-09-4', 'mba-step-09',
'Minimum employment terms in Switzerland (non-negotiable): Maximum 45-hour work week for industrial workers, 50 hours for others; minimum 4 weeks vacation (5 weeks for under-20s); at least one rest day per week; break after 5.5 hours of work; protection against dismissal during pregnancy and military service. These are mandated by law and cannot be contracted away.',
NULL,
'Check the OR/CO and your canton''s labour law. Some cantons have additional protections. The State Secretariat for Economic Affairs (SECO) website has excellent resources.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-09-1', 'mba-step-09', 'q09-1', 'What is the maximum standard work week in Switzerland for office workers?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-09-1a', 'mba-q-09-1', '40 hours', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-09-1b', 'mba-q-09-1', '45 hours', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-09-1c', 'mba-q-09-1', '50 hours', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-09-1d', 'mba-q-09-1', '60 hours', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-09-2', 'mba-step-09', 'q09-2', 'At what salary level must an employer provide BVG/pension coverage?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-09-2a', 'mba-q-09-2', 'CHF 10,000 per year', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-09-2b', 'mba-q-09-2', 'CHF 22,050 per year', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-09-2c', 'mba-q-09-2', 'CHF 50,000 per year', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-09-2d', 'mba-q-09-2', 'There is no minimum — all employees must have pension coverage', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-09-3', 'mba-step-09', 'q09-3', 'Why did Anna''s verbal employment agreement cost her CHF 8,000?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-09-3a', 'mba-q-09-3', 'She had to pay the employee a mandatory statutory bonus for the absence of a written contract', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-09-3b', 'mba-q-09-3', 'A salary dispute arose with no written proof, leading to CHF 8,000 in legal fees', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-09-3c', 'mba-q-09-3', 'The employee stole from her café and she could not prove the terms of employment', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-09-3d', 'mba-q-09-3', 'She had to pay a fine to the canton for verbal contracts', FALSE, 3);

-- ============================================================
-- PAGE 10: Social Security and Payroll
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-10', 'business-fundamentals-mba', 'social-security-payroll',
'Social Security and Payroll',
'When Laura, 26, hired her first employee at CHF 5,500 per month, she thought her costs were CHF 5,500 plus maybe a few hundred francs in "fees." Her first payroll calculation shocked her: CHF 6,450 total employer cost. The employee took home CHF 4,600 after deductions. The gap — nearly CHF 1,000 — was social security contributions, split between employer and employee. Swiss social security is comprehensive but expensive. Understanding the system is essential for accurate budgeting.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-10-1', 'mba-step-10', 'Old Age Insurance',
'The foundation of Swiss social security (AHV / AVS — assurance-vieillesse et survivants). Provides pensions to retirees and survivors. Contribution rate: 10.6% of salary (5.3% employee, 5.3% employer). No cap — paid on all earnings up to the maximum insured salary.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-10-2', 'mba-step-10', 'Disability Insurance',
'Provides benefits (IV / AI — assurance-invalidité) to those unable to work due to illness or injury. Integrated with old age insurance, same contribution rate and split. Ensures income continuation if health fails.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-10-3', 'mba-step-10', 'Unemployment Insurance',
'Provides income replacement (ALV / AC — assurance-chômage) if unemployed. Contribution rate: 2.2% (1.1% employee, 1.1% employer) up to CHF 148,200 of salary; above that, an additional 1% solidarity contribution. Self-employed persons generally do not contribute.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-10-4', 'mba-step-10', 'Pension Fund',
'The mandatory second pillar pension (BVG / LPP — Loi sur la prévoyance professionnelle). Contributions vary by age and pension fund, typically 7-18% of insured salary (above coordination deduction). Employer must pay at least 50%.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-10-5', 'mba-step-10', 'Sickness Allowance',
'Provides salary continuation (KTG / AJ — assurance-maladie journalière) during illness. Mandatory in most cantons. Premiums vary, typically 0.5-2% of payroll. Usually employer-paid.',
4);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-10-6', 'mba-step-10', 'Accident Insurance',
'Covers workplace accidents (UVG / LAA — Loi sur l''assurance-accidents) and occupational diseases. Mandatory for all employees. Non-occupational accident coverage required for employees working 8+ hours weekly. Premiums vary by risk class; employer pays entire premium.',
5);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-10-1', 'mba-step-10',
'Here is a real monthly payroll breakdown for CHF 5,500 gross salary:',
NULL, '| Component | Employee Pays | Employer Pays |\n|-----------|---------------|---------------|\n| AHV/AVS (5.3% each) | CHF 291.50 | CHF 291.50 |\n| IV/AI (integrated) | included | included |\n| ALV/AC (1.1% each) | CHF 60.50 | CHF 60.50 |\n| BVG/LPP (~4%) | CHF 180 | CHF 180 |\n| KTG/AJ (~0.7%) | - | CHF 38.50 |\n| UVG/LAA (~0.5%) | - | CHF 27.50 |\n| **Total Social** | **~CHF 532** | **~CHF 598** |\n| **Take Home / Total Cost** | **~CHF 4,968** | **~CHF 6,098** |',
NULL,
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-10-2', 'mba-step-10',
'The flow of social security administration:',
NULL, NULL,
'graph TD
    A[Employee Works] --> B[Calculate Gross Salary]
    B --> C[Deduct Employee Share<br/>From Paycheck]
    C --> D[Add Employer Share<br/>Company Expense]
    D --> E[Quarterly Report<br/>To SVA/AC]
    E --> F[Remit Total<br/>To SVA/AC]
    F --> G[SVA Distributes<br/>To Each Insurance]',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-10-3', 'mba-step-10',
'Self-employed persons have different obligations: You pay the full AHV/AVS (10.6%) yourself, not split with an employer. You are not required to contribute to ALV/AC (unemployment insurance) — which means no unemployment benefits if your business fails. You can optionally insure for loss of earnings (EO/APG). BVG/LPP is not mandatory for self-employed, though private pension planning is wise.',
NULL,
'This is why self-employed persons often seem to "pay more" — they cover both employer and employee portions. But they also have more flexibility in structuring their income.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-10-4', 'mba-step-10',
'David, 25, a freelance developer, set up his social security optimally: He registered as self-employed, pays his quarterly AHV/AVS contributions based on projected income, maxes out Säule 3a (CHF 35,280 annually for self-employed), and took out private daily sickness allowance insurance. His total monthly "social security" cost: CHF 420. An employee earning the same would have CHF 530+ deducted from salary plus employer contributions.',
NULL,
'Self-employed social security planning requires more active management but offers optimization opportunities. Most self-employed use a Treuhand (fiduciaire) to handle quarterly filings.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-10-1', 'mba-step-10', 'q10-1', 'What is the total AHV/AVS contribution rate for employed persons?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-10-1a', 'mba-q-10-1', 'Only 5.3% (the employee half)', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-10-1b', 'mba-q-10-1', 'Around 8.4% combined', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-10-1c', 'mba-q-10-1', '10.6% in total, paid half each by employee and employer', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-10-1d', 'mba-q-10-1', 'Approximately 15%, including all social insurance levies', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-10-2', 'mba-step-10', 'q10-2', 'Who pays the entire UVG/accident insurance premium?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-10-2a', 'mba-q-10-2', 'The employee', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-10-2b', 'mba-q-10-2', 'Split 50/50 between employee and employer', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-10-2c', 'mba-q-10-2', 'The employer', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-10-2d', 'mba-q-10-2', 'The government', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-10-3', 'mba-step-10', 'q10-3', 'How much does an employer typically pay beyond the gross salary in social charges?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-10-3a', 'mba-q-10-3', 'Nothing — gross is the total cost', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-10-3b', 'mba-q-10-3', 'Approximately 5%', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-10-3c', 'mba-q-10-3', 'Approximately 15-20%', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-10-3d', 'mba-q-10-3', 'Approximately 50%', FALSE, 3);

-- ============================================================
-- PAGE 11: Business Planning
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-11', 'business-fundamentals-mba', 'business-planning',
'Business Planning',
'Most business plans are fiction. They project CHF 500,000 revenue in year one with 50% market share of a market that does not exist yet. They have 40 pages of charts nobody reads. Then the entrepreneur discovers reality: customers do not care about their projections. Here is a better approach. The story of Ben and Jerry (yes, the ice cream guys) is instructive: their original business plan fit on one page. It focused on three things — making great ice cream, sourcing ethical ingredients, and having fun. They became a billion-dollar brand. Your plan does not need to be long. It needs to be right.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-11-1', 'mba-step-11', 'Business Model Canvas',
'A one-page visual template that captures the core elements of a business: value proposition, customer segments, channels, customer relationships, revenue streams, key resources, key activities, key partnerships, and cost structure. Perfect for early-stage planning. Forces clarity.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-11-2', 'mba-step-11', 'Break-Even-Point',
'The revenue level where total costs equal total revenue — no profit, no loss. Below this, you lose money; above it, you make money. Critical for understanding minimum viable business volume. Calculate: Fixed Costs ÷ Contribution Margin per Unit.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-11-3', 'mba-step-11', 'Contribution Margin',
'Price minus variable cost per unit (Deckungsbeitrag / contribution à la couverture). Shows how much each sale contributes to fixed costs. If contribution margin is CHF 50 and fixed costs are CHF 5,000, you need 100 sales to break even.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-11-4', 'mba-step-11', 'Revenue Planning',
'Realistic projection (Umsatzplanung / planification des recettes) of future sales. Based on market size, pricing, sales capacity, and historical data if available. The most dangerous part of any plan — optimism bias kills businesses here.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-11-1', 'mba-step-11',
'The lean business plan for a 22-year-old web developer starting freelance: Value proposition: "I build fast, mobile-first websites for small Swiss businesses who are losing customers to outdated designs." Customer segments: Restaurants, tradespeople, professional services. Channels: Direct outreach, referrals, Google Business. Revenue: CHF 100/hour, 20 billable hours/week = CHF 8,000/month. Costs: Software CHF 200, coworking CHF 300, Treuhand CHF 200, insurance CHF 150. Break-even: 7 hours/week. That is a plan you can execute.',
NULL,
'Notice: the plan is specific, not "I will get clients from the internet." Specificity enables action.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-11-2', 'mba-step-11',
'How break-even analysis works:',
NULL, NULL,
'graph TD
    A[Fixed Costs<br/>CHF 2,000/month] --> B{How many units<br/>to cover?}
    C[Price per unit<br/>CHF 100] --> D[Variable cost<br/>CHF 30]
    D --> E[Deckungsbeitrag<br/>CHF 70/unit]
    E --> B
    B -->|CHF 2,000 ÷ CHF 70| F[29 units<br/>to break even]',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-11-3', 'mba-step-11',
'Swiss-specific planning considerations: 1) Seasonality — tourism businesses die in winter, construction slows, ski instructors starve in summer. Plan cash reserves for low seasons. 2) High fixed costs — Swiss rent, insurance, and social charges are expensive. Know your real break-even. 3) Slow sales cycles — Swiss B2B decision-making is deliberate. A "quick sale" might take 3 months. 4) Local focus — most Swiss small businesses serve local markets. Your plan should reflect geography.',
NULL,
'Markus planned a kayaking tour business in Interlaken. He budgeted for 8 months of operation, planning to "do something else" in winter. He survived. His competitor who planned year-round revenue went bankrupt in month 10.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-11-4', 'mba-step-11',
'The planning fallacy: Humans systematically underestimate time and cost while overestimating benefits. Your plan will be wrong. Build in contingency: 20% higher costs, 30% lower revenue, 50% longer timelines than your best case. If the business still works with those numbers, proceed. If not, reconsider.',
NULL,
'Psychologist Daniel Kahneman won a Nobel Prize for identifying this bias. Smart entrepreneurs plan for their own optimism.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-11-1', 'mba-step-11', 'q11-1', 'What is the formula for calculating the break-even point in units?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-11-1a', 'mba-q-11-1', 'The product of price multiplied by variable cost per unit produced', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-11-1b', 'mba-q-11-1', 'Total Fixed Costs divided by the Contribution Margin per unit sold', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-11-1c', 'mba-q-11-1', 'The simple difference between total revenue and total operating expenses', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-11-1d', 'mba-q-11-1', 'The sum of the unit selling price plus all fixed overhead costs per period', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-11-2', 'mba-step-11', 'q11-2', 'What is the planning fallacy?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-11-2a', 'mba-q-11-2', 'The widespread entrepreneurial belief that longer and more detailed business plans produce better outcomes and funding success', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-11-2b', 'mba-q-11-2', 'Underestimating costs and overestimating benefits', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-11-2c', 'mba-q-11-2', 'The legal requirement to file annual business plans with the cantonal government', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-11-2d', 'mba-q-11-2', 'A technique for planning and running multiple businesses at the same time', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-11-3', 'mba-step-11', 'q11-3', 'Why did Markus survive while his competitor went bankrupt?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-11-3a', 'mba-q-11-3', 'He had secured more investors who provided emergency capital during the slow season', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-11-3b', 'mba-q-11-3', 'He planned for seasonality and maintained cash reserves to survive the slow winter months', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-11-3c', 'mba-q-11-3', 'He consistently charged significantly higher prices than his competitor throughout the year', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-11-3d', 'mba-q-11-3', 'He avoided paying taxes during the slow months to preserve cash flow', FALSE, 3);

-- ============================================================
-- PAGE 12: Pricing Strategy
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-12', 'business-fundamentals-mba', 'pricing-strategy',
'Pricing Strategy',
'Clara, 23, was an excellent graphic designer. She charged CHF 50 per hour — "competitive" she thought. She worked 50 hours a week, 48 weeks a year. Her calculation: CHF 120,000 income! Reality: she could only bill 18 hours a week (client work). The rest was admin, proposals, learning, and waiting. Her real hourly rate: CHF 18.75 — barely above minimum wage. She burned out in 14 months. Pricing is where most young entrepreneurs fail. They price like employees, not business owners. They ignore true costs. They compete on price instead of value. This page fixes that.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-12-1', 'mba-step-12', 'Cost Estimate',
'The document (Kostenvoranschlag / devis) you provide to potential clients showing what work will cost. In Switzerland, this is legally binding once accepted. Include scope, timeline, price, and payment terms. Always include a clause for out-of-scope work.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-12-2', 'mba-step-12', 'Hourly Rate',
'What you charge per hour (Stundensatz / taux horaire) of work. Calculate: (Annual Target Income + Annual Costs + Desired Profit) ÷ Billable Hours. Most young entrepreneurs calculate backwards: "what sounds fair?" Instead, calculate what you need.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-12-3', 'mba-step-12', 'Contribution Margin',
'The amount each sale contributes (Deckungsbeitrag / contribution à la couverture) to covering fixed costs. In pricing, this tells you the minimum price you can accept without losing money on each unit sold.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-12-4', 'mba-step-12', 'Value-Based Pricing',
'Setting prices (Wertbasierte Preisgestaltung / tarification basée sur la valeur) based on the value delivered to the customer, not your costs. If you save a client CHF 50,000, charging CHF 5,000 is reasonable regardless of how many hours it took you.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-12-1', 'mba-step-12',
'Clara''s corrected calculation: Target income CHF 80,000 + costs CHF 20,000 + profit CHF 10,000 = CHF 110,000 needed. Billable hours: 18/week × 46 weeks = 828 hours/year (accounting for holidays, sick days, and dry spells). Minimum hourly rate: CHF 133. She raised her rate to CHF 150. Some clients said no. Better clients said yes. She worked fewer hours, earned more, and had time to learn new skills.',
NULL,
'The clients who complain about higher prices are often the hardest to work with. The clients who accept professional rates are usually more respectful and profitable.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-12-2', 'mba-step-12',
'Hourly rate calculation formula:',
NULL, NULL,
'graph TD
    A[Target Annual Income] --> T[Total Needed]
    B[Annual Business Costs] --> T
    C[Desired Profit/Savings] --> T
    T --> D[Divide by<br/>Annual Billable Hours]
    E[Working Hours<br/>× Utilization %<br/>× Working Weeks] --> D
    D --> F[Minimum Hourly Rate<br/>Add 20% buffer]',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-12-3', 'mba-step-12',
'The psychology of Swiss pricing: Swiss consumers and businesses are generally price-conscious but not cheap. They value quality, reliability, and Swiss presence. A price that is "too low" signals low quality. A professional price signals professionalism. Research shows that raising prices can sometimes increase demand because of perceived quality.',
NULL,
'Test: If 80% of prospects accept your price without hesitation, it is too low. If 20% accept, it might be too high. The sweet spot is 40-60% conversion rate.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-12-4', 'mba-step-12',
'When to publish prices: For commodity services (web hosting, standard products), publish. For custom services (design, consulting, development), do not publish hourly rates. Instead, offer project-based Kostenvoranschläge (devis). Why? Because experienced professionals can often deliver in 5 hours what takes beginners 20. Publishing CHF 150/hour scares budget clients. A CHF 3,000 project price for a result is easier to sell than 20 hours at CHF 150.',
NULL,
'Exception: If you are targeting startups and small businesses with limited budgets, having a "starter package" with a published price can reduce friction. But always have higher-tier options.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-12-1', 'mba-step-12', 'q12-1', 'What was Clara''s actual hourly earnings at CHF 50/hour billed rate?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-12-1a', 'mba-q-12-1', 'Her full CHF 50 billing rate, since she worked 50 hours every week', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-12-1b', 'mba-q-12-1', 'Approximately CHF 35 after deducting business expenses', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-12-1c', 'mba-q-12-1', 'CHF 18.75 — because only 18 of her 50 weekly hours were actually billable to clients', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-12-1d', 'mba-q-12-1', 'Effectively CHF 120 per billable hour, the true market rate for her skills', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-12-2', 'mba-step-12', 'q12-2', 'What is value-based pricing?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-12-2a', 'mba-q-12-2', 'Always charging the lowest competitive price in your local market to win volume', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-12-2b', 'mba-q-12-2', 'Setting prices based on the value delivered to the customer rather than on your time or costs', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-12-2c', 'mba-q-12-2', 'Charging an hourly rate based purely on how many hours you worked on a project', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-12-2d', 'mba-q-12-2', 'Always publishing all your prices online for full transparency', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-12-3', 'mba-step-12', 'q12-3', 'Why should custom service providers avoid publishing hourly rates?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-12-3a', 'mba-q-12-3', 'Publishing hourly rates for custom services is explicitly prohibited under Swiss commercial regulations', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-12-3b', 'mba-q-12-3', 'It shifts focus to time rather than value delivered', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-12-3c', 'mba-q-12-3', 'Swiss business clients strongly prefer daily rates and reject hourly billing', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-12-3d', 'mba-q-12-3', 'Published hourly rates make annual tax filing significantly more complicated', FALSE, 3);
