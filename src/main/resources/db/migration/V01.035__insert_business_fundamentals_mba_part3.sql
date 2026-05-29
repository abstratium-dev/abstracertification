-- ============================================================
-- Business Fundamentals for New Entrepreneurs — Part 3
-- Pages 13-18
-- ============================================================

-- ============================================================
-- PAGE 13: Marketing for Small Swiss Businesses
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-13', 'business-fundamentals-mba', 'marketing-swiss-businesses',
'Marketing for Small Swiss Businesses',
'Thomas, 24, spent CHF 5,000 on Instagram ads for his new bicycle repair shop in Bern. He got 3,000 likes and zero customers. Meanwhile, his competitor — a 60-year-old mechanic with no social media — had a waiting list. Why? The mechanic had been fixing bikes for 40 years and everyone in the neighbourhood knew him. Thomas learned a hard lesson: in Swiss small business, reputation beats advertising. Trust beats impressions. Word-of-mouth beats hashtags. Marketing for Swiss small businesses is different from global brand marketing. This page explains what actually works.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-13-1', 'mba-step-13', 'Target Audience',
'The specific people (Zielgruppe / groupe cible) most likely to buy from you. Not "everyone" — that is too expensive to reach. Define by demographics (age, location, income), psychographics (values, interests), and behaviour (problems they have, solutions they seek).',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-13-2', 'mba-step-13', 'Positioning',
'How you want to be perceived (Positionierung / positionnement) in the market relative to competitors. Are you the cheapest? The fastest? The most premium? The most sustainable? The most local? Clear positioning helps the right customers find you.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-13-3', 'mba-step-13', 'Word-of-Mouth',
'The most powerful marketing (Mund-zu-Mund-Propaganda / bouche à oreille) for Swiss small businesses. Swiss consumers trust recommendations from friends and family above all other sources. One satisfied customer telling three friends beats 1,000 Instagram impressions.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-13-4', 'mba-step-13', 'Referral Marketing',
'Actively encouraging satisfied customers (Empfehlungsmarketing / marketing par recommandation) to refer others. Simple: ask happy clients for reviews on Google. Ask them to mention you to friends. Offer a small thank-you for referrals. Most entrepreneurs never ask — leaving money on the table.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-13-5', 'mba-step-13', 'Google Business Profile',
'The free listing (Google Business Profil / profil Google Business) that shows your business on Google Maps and search results. Essential for local businesses. Include photos, hours, services, and respond to reviews. Often the first impression potential customers have of you.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-13-1', 'mba-step-13',
'Thomas''s corrected approach: He claimed his Google Business Profile, added photos of his workshop and repaired bikes, and asked every satisfied customer for a review. Within 3 months, he had 47 five-star reviews. He appeared in "bike repair near me" searches. Customers started finding him organically. His marketing spend: CHF 0. His results: better than the CHF 5,000 Instagram campaign.',
NULL,
'For local Swiss businesses — cafes, repair shops, tradespeople, salons — Google Business Profile is often more valuable than any paid advertising.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-13-2', 'mba-step-13',
'The marketing hierarchy for Swiss small businesses:',
NULL, NULL,
'graph TD
    A[Best: Word of Mouth<br/>Personal Recommendations] --> B[Second: Local SEO<br/>Google Business<br/>Local Directories]
    B --> C[Third: Content/Education<br/>Show Expertise<br/>Build Trust]
    C --> D[Fourth: Community<br/>Local Events<br/>Partnerships]
    D --> E[Fifth: Paid Ads<br/>If Profitable<br/>Not Before]
    style A fill:#e1ffe1
    style E fill:#ffe1e1',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-13-3', 'mba-step-13',
'The Swiss resistance to hard selling: Swiss consumers generally dislike aggressive sales tactics, pushy marketing, and hype. They respond to facts, quality evidence, and patience. A soft approach works better: "Here is what I do, here are examples, take your time to decide." Pressure creates resistance. Information builds trust.',
NULL,
'Sarah, a financial advisor, found that offering free 30-minute consultations (no obligation, no hard sell) converted 40% of prospects to clients. Her previous "sales pitch" approach converted 5%.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-13-4', 'mba-step-13',
'Social media reality check: Instagram and TikTok can work for visually appealing businesses (food, fashion, design) targeting under-35 consumers. For B2B services, professional trades targeting homeowners, or industrial services, social media is often a time sink with little return. Focus on channels where your actual customers spend time. A plumber''s customers are on Google looking for "emergency plumber Zurich" — not scrolling Instagram.',
NULL,
'Ask your first 10 customers: "How did you find me?" If none say Instagram, stop posting there.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-13-1', 'mba-step-13', 'q13-1', 'What form of marketing is most powerful for Swiss small businesses?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-13-1a', 'mba-q-13-1', 'Paid Instagram and Facebook advertising campaigns', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-13-1b', 'mba-q-13-1', 'Television commercials on regional Swiss channels', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-13-1c', 'mba-q-13-1', 'Word-of-mouth — satisfied customers recommending the business to friends and family', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-13-1d', 'mba-q-13-1', 'Billboard advertising along main commuter routes', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-13-2', 'mba-step-13', 'q13-2', 'What marketing tool did Thomas use successfully after his failed Instagram campaign?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-13-2a', 'mba-q-13-2', 'Television ads on local Bern channels', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-13-2b', 'mba-q-13-2', 'A Google Business Profile with updated hours, location, and customer reviews', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-13-2c', 'mba-q-13-2', 'Billboards placed at key junctions around Bern city centre', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-13-2d', 'mba-q-13-2', 'Sponsored radio spots on regional Swiss stations', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-13-3', 'mba-step-13', 'q13-3', 'What is the Swiss consumer generally resistant to?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-13-3a', 'mba-q-13-3', 'High prices and premium service charges', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-13-3b', 'mba-q-13-3', 'Pushy or high-pressure sales tactics', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-13-3c', 'mba-q-13-3', 'High quality products and professional service delivery', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-13-3d', 'mba-q-13-3', 'Small local businesses competing with larger corporations', FALSE, 3);

-- ============================================================
-- PAGE 14: Sales and Customer Relationships
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-14', 'business-fundamentals-mba', 'sales-customer-relationships',
'Sales and Customer Relationships — The Swiss Way',
'When Elena, 25, moved from Italy to Zurich to start a consulting business, she brought her Mediterranean sales style: enthusiastic pitches, warm relationship-building, and frequent follow-ups. It backfired. Swiss prospects found her "pushy." Her response rate was 5%. She adapted: shorter emails, factual presentations, respect for response time, and clear written follow-up. Her response rate jumped to 35%. Swiss business culture values punctuality (Pünktlichkeit), preparation, and precision. Sales here is different — and understanding the difference is the difference between success and frustration.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-14-1', 'mba-step-14', 'Sales Conversation',
'The meeting (Verkaufsgespräch / entretien de vente) where you present your offering and try to win the business. In Swiss B2B contexts, this is typically formal, well-prepared, and focused on facts and value. Bring examples, case studies, and clear pricing.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-14-2', 'mba-step-14', 'Quotation',
'The formal written proposal (Offerte / offre) with price and terms. In Switzerland, a verbal agreement is binding in many contexts, but a written quotation prevents disputes and shows professionalism. Always include scope, timeline, price, payment terms, and acceptance method.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-14-3', 'mba-step-14', 'Order Confirmation',
'The document (Auftragsbestätigung / confirmation de commande) confirming acceptance of an order. Creates clarity about what was agreed. Essential for preventing "but I thought you said..." disputes.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-14-4', 'mba-step-14', 'Customer Complaint',
'When a customer is dissatisfied (Reklamation / réclamation). Swiss consumers expect prompt, professional handling of complaints. A well-handled complaint often creates a more loyal customer than one who never had a problem. Ignore complaints at your peril.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-14-5', 'mba-step-14', 'Follow-up',
'Follow-up (suivi) — contacting prospects or customers after initial contact. In Swiss business culture, this is expected but must not be pushy. One or two follow-ups is polite; three or more can be perceived as aggressive unless the prospect has shown continued interest.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-14-1', 'mba-step-14',
'The Swiss sales process flow:',
NULL, NULL,
'graph TD
    A[Initial Contact<br/>Professional & Brief] --> B[Discovery<br/>Understand Needs]
    B --> C[Offerte/Proposal<br/>Written, Detailed]
    C --> D{Customer Decides}
    D -->|Yes| E[Auftragsbestätigung<br/>Confirm Everything]
    D -->|No| F[Polite Follow-up<br/>Once or Twice]
    D -->|Maybe| G[Patient Wait<br/>Add Value]
    E --> H[Deliver Excellence]
    H --> I[Ask for Referral]',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-14-2', 'mba-step-14',
'Decoding Swiss communication: When a Swiss prospect says "interesting," they often mean "no." When they say "we will think about it," they usually mean "no thank you." Direct "no" is rare — look for soft rejections. On the positive side, when a Swiss client says "yes," they mean it and will follow through. Follow-up timing: Give prospects 5-7 days after sending an Offerte before following up. Then one more follow-up after 10-14 days. After that, let it go unless they engage.',
NULL,
'Markus learned to read the signals: If a prospect asked detailed questions after the Offerte, they were interested. If they said "thank you for the information" and went silent, they were declining politely.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-14-3', 'mba-step-14',
'Pünktlichkeit (punctuality) in sales: Arrive exactly on time — not early (which can be awkward) and certainly not late. If you will be even 5 minutes late, call or message immediately. Being late to a first meeting often kills the deal. Being early suggests poor time management. Being precisely on time signals professionalism.',
NULL,
'Anna, a consultant, once arrived 15 minutes early to a meeting and waited in the hallway. The prospect later told her he appreciated that she did not expect him to receive her early.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-14-4', 'mba-step-14',
'Written communication wins: Swiss business runs on written documentation. Verbal agreements happen, but the written confirmation (email, Offerte, contract) is what counts. After every call, send a summary email: "As discussed, we will deliver X by Y for CHF Z. Please confirm by reply." This prevents misunderstandings and creates a paper trail.',
NULL,
'When disputes arise, Swiss courts and commercial mediators look at written records. "He said, she said" is a weak position.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-14-1', 'mba-step-14', 'q14-1', 'What does a Swiss prospect often mean when they say "interesting"?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-14-1a', 'mba-q-14-1', 'They are definitely buying', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-14-1b', 'mba-q-14-1', 'They want more information immediately', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-14-1c', 'mba-q-14-1', 'They are politely declining', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-14-1d', 'mba-q-14-1', 'They want a discount', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-14-2', 'mba-step-14', 'q14-2', 'How many follow-ups are generally considered polite in Swiss business culture?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-14-2a', 'mba-q-14-2', 'None — never follow up, as it is considered rude in Swiss business culture', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-14-2b', 'mba-q-14-2', 'One or two follow-ups spaced a week apart, no more', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-14-2c', 'mba-q-14-2', 'Five or more — persistence demonstrates strong interest and professionalism', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-14-2d', 'mba-q-14-2', 'Daily automated follow-up emails until the prospect responds', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-14-3', 'mba-step-14', 'q14-3', 'What is the ideal arrival time for a Swiss business meeting?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-14-3a', 'mba-q-14-3', '10-15 minutes early to show enthusiasm', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-14-3b', 'mba-q-14-3', 'Exactly on time, as punctuality signals respect and professionalism in Swiss business culture', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-14-3c', 'mba-q-14-3', '5-10 minutes late to avoid being too eager', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-14-3d', 'mba-q-14-3', 'Timing does not matter', FALSE, 3);

-- ============================================================
-- PAGE 15: Managing Cash Flow
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-15', 'business-fundamentals-mba', 'managing-cash-flow',
'Managing Cash Flow',
'David ran a successful IT consulting business. CHF 300,000 annual revenue, CHF 200,000 profit on paper. In month 18, he went bankrupt. Why? His largest client — 40% of revenue — paid on 90-day terms but had a cash crisis and delayed payment by another 60 days. Meanwhile, David had to pay his employees, rent, and suppliers on time. His paper profit meant nothing when cash ran out. More Swiss small businesses die from cash flow problems than from lack of profitability. Cash is oxygen. You can survive without profit for a while. You cannot survive without cash for even a week.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-15-1', 'mba-step-15', 'Liquidity',
'Having enough cash available (Liquidität / liquidité) to meet short-term obligations. Profitable businesses fail from illiquidity. You can be owed CHF 100,000 but unable to pay CHF 5,000 in salaries if the money has not arrived.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-15-2', 'mba-step-15', 'Payment Terms',
'How long customers have to pay (Zahlungsziel / délai de paiement). Standard in Switzerland: 30 days net. Many large companies take 60-90 days. The longer your payment terms, the more working capital you need.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-15-3', 'mba-step-15', 'Payment Reminder',
'The formal request (Mahnung / rappel) for payment when a customer is late. In Switzerland, you typically send a first reminder after the due date, then a second after 10-20 days, then escalate to debt collection (Betreibung / poursuites) if necessary.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-15-4', 'mba-step-15', 'Debt Collection',
'The legal process (Betreibung / poursuite) for forcing payment through the debt collection office (Betreibungsamt / Office des poursuites). You file a collection request. The debtor can contest it, but if they do not, you get a payment order. Effective but can damage business relationships.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-15-5', 'mba-step-15', 'Accounts Receivable',
'The process (Debitorenmanagement / gestion des débiteurs) of tracking who owes you money and ensuring timely payment. Includes credit checks, clear payment terms, timely invoicing, systematic follow-up, and escalation procedures.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-15-1', 'mba-step-15',
'The cash conversion cycle: You pay suppliers → You deliver work → You invoice → You wait for payment. The time between paying out and getting paid is your cash gap. If that gap is 60 days, you need enough cash to fund 60 days of operations. David''s gap was 120 days. He needed CHF 80,000 in cash reserves just to operate. He had CHF 30,000.',
NULL,
'Calculate your cash gap: (Days to deliver + Days payment terms) - Days supplier credit. If positive, that is how many days of operations you must fund.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-15-2', 'mba-step-15',
'Cash flow management strategies: 1) Negotiate shorter payment terms — even 15 days helps; 2) Offer early payment discounts (e.g., 2% for payment within 10 days); 3) Require deposits or milestone payments for large projects; 4) Use factoring (selling receivables) if necessary; 5) Negotiate longer supplier terms to match customer terms; 6) Build a cash reserve equal to 3 months of operating expenses.',
NULL,
'Anna, a designer, started requiring 50% deposit on projects over CHF 5,000. Her cash position improved immediately, and problem clients self-selected out — those unwilling to pay deposits often turn out to be slow payers anyway.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-15-3', 'mba-step-15',
'The Mahnung process:',
NULL, NULL,
'graph TD
    A[Invoice Due Date] -->|Day 0| B[Invoice Sent<br/>Payment Expected]
    B -->|Day 30| C{Payment Received?}
    C -->|No| D[First Mahnung<br/>Friendly Reminder]
    C -->|Yes| Z[Payment Recorded]
    D -->|Day 40| E{Payment?}
    E -->|No| F[Second Mahnung<br/>Firm Tone]
    E -->|Yes| Z
    F -->|Day 60| G{Payment?}
    G -->|No| H[Betreibung Filed<br/>Legal Pursuit]
    G -->|Yes| Z
    style H fill:#ffe1e1',
2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-15-4', 'mba-step-15',
'Credit checking Swiss customers: Before extending credit to new B2B customers, check their creditworthiness. Use the Zefix (Central Business Names Index) to verify company existence. For larger transactions, request a credit report from CRIF or Bisnode. For really big deals, ask for a Bürgschaft (cautionnement/guarantee) or Vorauszahlung (advance payment). It is not insulting — it is prudent.',
NULL,
'Thomas lost CHF 25,000 when a seemingly solid startup client went bankrupt. He now checks every new B2B client''s Handelsregisterauszug and asks for references.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-15-1', 'mba-step-15', 'q15-1', 'Why did David''s profitable consulting business go bankrupt?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-15-1a', 'mba-q-15-1', 'He had no clients and no revenue in the final quarter', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-15-1b', 'mba-q-15-1', 'Cash ran out while waiting for a slow-paying client to pay', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-15-1c', 'mba-q-15-1', 'He spent too much on equipment and office upgrades over time', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-15-1d', 'mba-q-15-1', 'He was not profitable and had negative margins throughout', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-15-2', 'mba-step-15', 'q15-2', 'What is a Mahnung?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-15-2a', 'mba-q-15-2', 'A mandatory Swiss business insurance product covering late payment losses', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-15-2b', 'mba-q-15-2', 'A formal written reminder that payment is overdue', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-15-2c', 'mba-q-15-2', 'A discount offered to clients who settle their invoices before the due date', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-15-2d', 'mba-q-15-2', 'A short-term bridging loan offered by Swiss banks to cover temporary cash flow gaps', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-15-3', 'mba-step-15', 'q15-3', 'How much cash reserve should a small business aim to maintain?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-15-3a', 'mba-q-15-3', 'One week of total business expenses including salaries', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-15-3b', 'mba-q-15-3', 'One month of operating expenses as a bare minimum', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-15-3c', 'mba-q-15-3', 'Three months', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-15-3d', 'mba-q-15-3', 'No reserve is needed if the business is consistently profitable throughout the year', FALSE, 3);

-- ============================================================
-- PAGE 16: Financing Your Business
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-16', 'business-fundamentals-mba', 'financing-business',
'Financing Your Business',
'When Sofia wanted to expand her vegan café, she needed CHF 50,000 for a second location. She went to her bank with a 20-page business plan and dreams of easy money. The banker asked one question: "How much of your own money are you investing?" Sofia had CHF 2,000. The answer was no. Swiss banks fund businesses with collateral, cash flow, and owner commitment — not just good ideas. This page covers how Swiss businesses actually get funded, from bootstrapping to credit, and the realities of each option.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-16-1', 'mba-step-16', 'Self-Financing',
'Funding the business (Eigenfinanzierung / autofinancement) from your own savings and cash flow. The most common source for Swiss small businesses. Advantage: no debt, full control. Disadvantage: limited growth speed. Most successful small businesses start here.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-16-2', 'mba-step-16', 'Bank Loan',
'Traditional financing (Bankkredit / crédit bancaire) from a Swiss bank. Requires collateral (Sicherheit / sûreté), proven cash flow, and usually personal guarantees. Interest rates vary (3-8% typical for small business loans). Banks prefer funding working capital and assets, not "ideas."',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-16-3', 'mba-step-16', 'Personal Guarantee',
'A promise to pay (Bürgschaft / cautionnement) if the business cannot. Swiss banks often require personal guarantees from business owners, especially for young businesses. This means your house, savings, and personal assets are at risk if the business fails. Understand this before signing.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-16-4', 'mba-step-16', 'Leasing',
'Renting equipment or vehicles (Leasing / crédit-bail) rather than buying. Common for cars, machinery, and technology. Preserves cash flow. Payments are tax-deductible. At the end, you may have a purchase option. Swiss banks and specialised leasing companies offer this.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-16-5', 'mba-step-16', 'Equity Ratio',
'The proportion (Eigenkapitalquote / ratio de capitaux propres) of business assets financed by owner equity rather than debt. Banks like to see at least 20-30% equity. Below this, you are "over-leveraged" and risky. Higher is better.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-16-1', 'mba-step-16',
'The funding hierarchy for Swiss small businesses:',
NULL, NULL,
'graph TD
    A[Start Here:<br/>Eigenfinanzierung<br/>Own Savings] --> B{Need More?}
    B -->|Small Amount| C[3F:<br/>Friends, Family,<br/>Fools]
    B -->|Equipment| D[Leasing<br/>Preserve Cash]
    B -->|Working Capital| E[Bank Credit Line<br/>With Collateral]
    C --> F{Still Need More?}
    D --> F
    E --> F
    F -->|Growth Capital| G[Investors/Angels<br/>Give Up Equity]
    F -->|Grants| H[Government Support<br/>SEF, KfW-equivalent]',
0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-16-2', 'mba-step-16',
'What Swiss banks actually want to see: 1) 2-3 years of profitable operation (not projections — actual history); 2) Personal investment of 20-30% of the amount you are borrowing; 3) Collateral (property, equipment, guarantees); 4) Clear use of funds and repayment plan; 5) Clean credit history (Betreibungsregisterauszug without entries). If you cannot show these, a bank loan is unlikely.',
NULL,
'Sofia''s mistake: approaching a bank with CHF 2,000 of her own money wanting CHF 50,000. She had no track record, no collateral, and 4% "skin in the game." Banks want to see you are committed before they commit.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-16-3', 'mba-step-16',
'Alternative funding options: 1) Crowdfunding (Swiss platforms like wemakeit, crowdcube) — good for consumer products with emotional appeal; 2) Microloans from organisations like Lendico or Kiva; 3) Startup support from cantonal economic promotion offices (some offer loans or guarantees for innovative businesses); 4) Supplier credit — negotiating payment terms with suppliers is often easier than bank loans.',
NULL,
'David funded his IT consultancy entirely through supplier credit (60-day terms) and client prepayments (30% deposits). He never borrowed from a bank. Zero debt, full ownership.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-16-4', 'mba-step-16',
'The credit card trap: Do not fund your business on personal credit cards. The interest rates (12-15%) will destroy you. If you cannot get proper financing, reduce your plans and grow organically. Bootstrapping is slower but safer than drowning in high-interest debt.',
NULL,
'Markus racked up CHF 25,000 in credit card debt to fund his startup. It took him 3 years to pay it off, during which time he could not invest in growth. The interest cost more than any investor would have taken in equity.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-16-1', 'mba-step-16', 'q16-1', 'What percentage of their own money do Swiss banks typically want to see from business owners seeking a loan?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-16-1a', 'mba-q-16-1', '5%', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-16-1b', 'mba-q-16-1', '10%', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-16-1c', 'mba-q-16-1', '20-30%', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-16-1d', 'mba-q-16-1', 'No personal investment is required', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-16-2', 'mba-step-16', 'q16-2', 'What is a Bürgschaft in the context of business financing?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-16-2a', 'mba-q-16-2', 'A non-repayable government grant for small businesses in priority sectors', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-16-2b', 'mba-q-16-2', 'A personal guarantee to pay if the business cannot', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-16-2c', 'mba-q-16-2', 'A type of rewards-based crowdfunding platform popular in Switzerland', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-16-2d', 'mba-q-16-2', 'A dedicated business savings account with preferential interest rates', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-16-3', 'mba-step-16', 'q16-3', 'Why was Sofia''s bank loan application rejected?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-16-3a', 'mba-q-16-3', 'She had already invested far too much of her own capital, making the bank unwilling to lend further', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-16-3b', 'mba-q-16-3', 'Insufficient personal investment — only CHF 2,000 of her own money', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-16-3c', 'mba-q-16-3', 'Swiss cantonal banks have a blanket policy of refusing all loans to food and beverage businesses', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-16-3d', 'mba-q-16-3', 'Her business plan was too short and lacked the financial projections required by the bank', FALSE, 3);

-- ============================================================
-- PAGE 17: Insurance for Swiss Businesses
-- =========================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-17', 'business-fundamentals-mba', 'business-insurance',
'Insurance for Swiss Businesses',
'When a water pipe burst in Lukas''s electronics repair shop, flooding CHF 40,000 worth of inventory and equipment, his first thought was relief: "At least I have insurance." His second thought was horror: "I never updated the policy after expanding." The insurance paid CHF 15,000. The gap destroyed his cash reserves and nearly killed the business. Insurance is not a checkbox — it is a shield that needs to match your actual risks. This page covers what Swiss businesses must have, should have, and might consider.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-17-1', 'mba-step-17', 'Public Liability',
'Insurance (Betriebshaftpflicht / responsabilité civile d''entreprise) that covers damage your business causes to third parties. A customer slips in your shop, a product malfunctions and damages property, an employee damages a client''s equipment. Essential for any business with physical premises or products.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-17-2', 'mba-step-17', 'Professional Liability',
'Insurance (Berufshaftpflicht / responsabilité civile professionnelle) that covers errors in professional services. A consultant gives bad advice, an accountant makes a tax error, a web developer crashes a client''s server. Required for many regulated professions; wise for all knowledge workers.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-17-3', 'mba-step-17', 'Property Insurance',
'Insurance (Sachversicherung / assurance de choses) that covers your physical assets: equipment, inventory, furniture, fixtures. Against fire, water damage, theft, vandalism. Essential for any business with significant physical assets.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-17-4', 'mba-step-17', 'Legal Protection',
'Insurance (Rechtsschutz / protection juridique) that covers legal costs for disputes. Employment disputes, contract conflicts, debt collection. Swiss legal fees are high (CHF 300-500/hour). This insurance makes defending your rights affordable.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-17-5', 'mba-step-17', 'Business Interruption',
'Insurance (Betriebsunterbrechung / perte d''exploitation) that covers lost income when you cannot operate due to insured damage. Fire destroys your kitchen, you are closed for 3 months — this pays your fixed costs and lost profit. Often bundled with property insurance.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-17-1', 'mba-step-17',
'Mandatory insurance: UVG/LAA (accident insurance) is required for all employees. If you hire anyone — even part-time — you must have this. It covers workplace accidents and occupational diseases. Premiums depend on your industry risk class (construction = high, office = low).',
NULL,
'Self-employed persons are not required to have UVG but can optionally insure themselves through the SUVA or their health insurance provider.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-17-2', 'mba-step-17',
'Insurance priority pyramid:',
NULL, NULL,
'graph TD
    A[Base: Required<br/>UVG for Employees] --> B[Essential<br/>Betriebs-<br/>haftpflicht]
    B --> C[Important<br/>Sachversicherung<br/>Rechtsschutz]
    C --> D[Valuable<br/>Berufs-<br/>haftpflicht]
    D --> E[Recommended<br/>Betriebsunter-<br/>brechung]
    E --> F[Consider<br/>D&O for<br/>Directors]
    style A fill:#ffe1e1
    style B fill:#fff4e1
    style C fill:#f0ffe1',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-17-3', 'mba-step-17',
'D&O (Directors and Officers) insurance: If you are a Geschäftsführer or board member of a GmbH/AG, this covers personal liability for management errors. Remember — you can be personally liable for certain obligations. D&O does not cover taxes or social security, but it covers claims from shareholders, creditors, or employees for alleged mismanagement.',
NULL,
'Anna, a board member, faced a CHF 100,000 claim from minority shareholders over a strategic decision. Her D&O insurance covered legal defence and settlement. Cost of insurance: CHF 2,000/year. Cost of the claim without it: potentially everything she owned.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-17-4', 'mba-step-17',
'Annual review ritual: Set a calendar reminder every year to review your insurance coverage. Have you bought new equipment? Expanded premises? Hired employees? Launched new products? Each change affects your risk profile and may require coverage adjustments. Lukas''s mistake was not reviewing after expansion.',
NULL,
'Most insurers offer annual review calls for free. Take them. Under-insurance is discovered at the worst possible moment — when you have a claim.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-17-1', 'mba-step-17', 'q17-1', 'What is Betriebshaftpflicht insurance?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-17-1a', 'mba-q-17-1', 'Insurance covering all employee health, dental, and wellness benefits', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-17-1b', 'mba-q-17-1', 'Third-party liability insurance covering bodily injury and property damage claims from clients', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-17-1c', 'mba-q-17-1', 'Insurance covering only registered commercial vehicles', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-17-1d', 'mba-q-17-1', 'Insurance covering data breaches and cyber attack costs', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-17-2', 'mba-step-17', 'q17-2', 'Which insurance is mandatory for all employees in Switzerland?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-17-2a', 'mba-q-17-2', 'Mandatory private health insurance (KVG) paid by the employer on behalf of staff', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-17-2b', 'mba-q-17-2', 'UVG/LAA', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-17-2c', 'mba-q-17-2', 'Compulsory group life insurance covering death and disability', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-17-2d', 'mba-q-17-2', 'Travel insurance for all business-related trips abroad', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-17-3', 'mba-step-17', 'q17-3', 'Why did Lukas not receive full coverage for his flood damage?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-17-3a', 'mba-q-17-3', 'Water damage from pipe bursts is categorically excluded from all Swiss business insurance policies', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-17-3b', 'mba-q-17-3', 'He never updated the policy after expanding', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-17-3c', 'mba-q-17-3', 'The insurer cancelled the policy because he missed a monthly premium payment', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-17-3d', 'mba-q-17-3', 'Swiss property insurance explicitly excludes all electronic goods and computer equipment', FALSE, 3);

-- ============================================================
-- PAGE 18: Contracts and Legal Agreements
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-18', 'business-fundamentals-mba', 'contracts-agreements',
'Contracts and Legal Agreements',
'When Nina hired a freelance developer to build her app, they shook hands on CHF 10,000 and a 6-week timeline. Four months later, she had spent CHF 18,000, the app was not finished, and they were no longer speaking. "But we had a deal!" she protested. Legally, they had almost nothing — no written scope, no payment milestones, no dispute resolution. In Switzerland, clear written agreements are not just good practice — they are how business is done. The Swiss value precision, and contracts embody that value.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-18-1', 'mba-step-18', 'Contract',
'A legally binding agreement (Vertrag / contrat) between parties. Under Swiss law (OR/CO), contracts can be verbal or written. Verbal contracts are valid but hard to prove. Written contracts prevent disputes and provide clarity. For business, written is the standard.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-18-2', 'mba-step-18', 'General Terms',
'Standard terms (AGB / CGV — Conditions Générales de Vente) that apply to all customers. Include payment terms, delivery conditions, liability limitations, and dispute resolution. Must be referenced in contracts and easily accessible.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-18-3', 'mba-step-18', 'Scope of Work',
'A detailed description (Leistungsverzeichnis / cahier des charges) of what will be delivered. For service contracts, this is the most important element. Vague scopes lead to disputes. Specific scopes enable accountability.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-18-4', 'mba-step-18', 'Jurisdiction',
'Which court (Gerichtsstand / élection de for) will hear disputes. Swiss contracts typically specify the court of the defendant''s domicile or a specific Swiss court. Important for international contracts.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-18-5', 'mba-step-18', 'Mediation',
'Alternative dispute resolution (Schlichtung / conciliation) before going to court. Often faster and cheaper. Many Swiss contracts require mediation attempts before litigation.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-18-1', 'mba-step-18',
'Essential contract elements for any service agreement: 1) Parties — who is contracting; 2) Scope — exactly what will be delivered (Leistungsverzeichnis); 3) Timeline — when deliverables are due; 4) Price — amount and payment terms (milestones help); 5) Acceptance criteria — how the client approves work; 6) Changes — how scope changes are handled; 7) Termination — how either party can exit; 8) Liability — what happens if things go wrong; 9) Governing law and jurisdiction.',
NULL,
'Nina''s mistake: She had #1 (parties), partial #3 (timeline), and #4 (price). Missing everything else.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-18-2', 'mba-step-18',
'Payment milestones protect both parties: Instead of CHF 10,000 at the end, structure it: 30% upon contract signing, 30% at prototype delivery, 30% at beta, 10% upon final acceptance. This gives the provider cash flow and the client leverage to ensure completion. If the provider disappears after prototype, the client has only paid 30%, not 100%.',
NULL,
'David uses this structure for all development projects over CHF 5,000. In 8 years, he has had only one payment dispute — and the milestone structure made it easy to resolve.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-18-3', 'mba-step-18',
'The AGB hierarchy: Your website/service has AGB. Individual contracts reference these AGB. Specific terms in the individual contract override general AGB terms. Result: Clear standard terms for routine matters, flexibility for specific arrangements.',
NULL, NULL,
'graph TD
    A[AGB<br/>General Terms] --> B[Individual Contract<br/>References AGB]
    B --> C[Specific Terms<br/>Override General]
    C --> D[Clear Agreement<br/>All Parties Protected]',
2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-18-4', 'mba-step-18',
'When to involve a lawyer: For standard low-value contracts (under CHF 5,000), templates and clear terms are usually sufficient. For high-value contracts, complex arrangements, or unusual terms, get a Rechtsanwalt (avocat) to review. The cost of a lawyer reviewing a CHF 50,000 contract (CHF 500-1,000) is cheap insurance against CHF 50,000 disputes.',
NULL,
'Many cantons offer free or low-cost legal advice for startups through economic promotion offices. Check what your canton offers before paying full lawyer rates.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-18-1', 'mba-step-18', 'q18-1', 'Under Swiss law, can contracts be verbal?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-18-1a', 'mba-q-18-1', 'No, all contracts must be in writing', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-18-1b', 'mba-q-18-1', 'Yes, verbal contracts are valid but hard to prove', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-18-1c', 'mba-q-18-1', 'Only contracts under CHF 1,000 can be verbal', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-18-1d', 'mba-q-18-1', 'Verbal contracts are only valid between family members', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-18-2', 'mba-step-18', 'q18-2', 'What is a Leistungsverzeichnis?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-18-2a', 'mba-q-18-2', 'A register of all employees and their contact details', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-18-2b', 'mba-q-18-2', 'A written scope of work', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-18-2c', 'mba-q-18-2', 'A signed payment receipt confirming funds received', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-18-2d', 'mba-q-18-2', 'A specialised type of professional indemnity insurance for contractors', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-18-3', 'mba-step-18', 'q18-3', 'What was Nina''s mistake with the developer contract?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-18-3a', 'mba-q-18-3', 'She paid the full CHF 10,000 upfront before any work had started', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-18-3b', 'mba-q-18-3', 'No written scope, milestones, or change procedures', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-18-3c', 'mba-q-18-3', 'She hired a developer based abroad without verifying their legal entity', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-18-3d', 'mba-q-18-3', 'She failed to engage a qualified Swiss lawyer to review the CHF 10,000 contract', FALSE, 3);
