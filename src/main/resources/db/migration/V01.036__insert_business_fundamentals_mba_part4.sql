-- ============================================================
-- Business Fundamentals for New Entrepreneurs — Part 4
-- Pages 19-24
-- ============================================================

-- ============================================================
-- PAGE 19: Intellectual Property
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-19', 'business-fundamentals-mba', 'intellectual-property',
'Intellectual Property',
'When Luca, 24, launched his sustainable clothing brand, he spent months designing the perfect logo — a stylised mountain peak that captured Swiss heritage. Three weeks after launch, he received a cease-and-desist letter. A ski equipment company had registered a similar logo five years earlier. Luca''s rebranding cost CHF 15,000 and months of momentum. Your brand, your methods, your creations — they are assets. But only if you protect them. This page explains how Swiss IP law works and what you must do to safeguard your business identity.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-19-1', 'mba-step-19', 'Trademark Law',
'Protects names, logos, and distinctive signs (Markenrecht / droit des marques) that identify your business. In Switzerland, registration with the IPI (Institut de la propriété intellectuelle) gives you exclusive rights to use the mark for your goods/services. Valid for 10 years, renewable indefinitely. Without registration, you have limited protection under unfair competition law only.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-19-2', 'mba-step-19', 'Copyright',
'Protects creative works (Urheberrecht / droit d''auteur) like text, images, music, and software. In Switzerland, copyright arises automatically when a work is created. No registration required. Lasts 70 years after the author''s death. Important: Copyright protects expression, not ideas.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-19-3', 'mba-step-19', 'Patent',
'Protects inventions and technical solutions (Patent / brevet). Must be novel, non-obvious, and industrially applicable. Registration required with the IPI. Valid for 20 years from filing. Expensive to obtain and maintain — usually only worthwhile for significant innovations with commercial potential.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-19-4', 'mba-step-19', 'Design Right',
'Protects the appearance (Geschmacksmuster / modèle d''utilité) of products (shape, ornamentation, colour). Registration required. Valid for up to 25 years. Useful for product designers and manufacturers with distinctive designs.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-19-5', 'mba-step-19', 'Trade Secret',
'Confidential business information (Geschäftsgeheimnis / secret d''affaires) that gives you a competitive advantage (recipes, customer lists, algorithms). Protected under Swiss unfair competition law as long as it remains secret. No registration, but you must actively protect it (NDAs, access controls).',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-19-1', 'mba-step-19',
'Luca''s mistake was checking Instagram for similar logos, not the trademark register. Here is the proper process: 1) Brainstorm your brand name and logo; 2) Search the Swiss trademark database (Swissreg) for conflicts; 3) Search Google and social media for unregistered use; 4) If clear, file for trademark registration BEFORE launching; 5) Consider similar marks in related industries that might confuse consumers.',
NULL,
'A trademark search costs nothing but time. A trademark conflict costs thousands. The math is simple.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-19-2', 'mba-step-19',
'IP protection hierarchy for typical small businesses:',
NULL, NULL,
'graph TD
    A[First Priority:<br/>Trademark Your Name<br/>& Logo] --> B[Second:<br/>Copyright Notice<br/>on Creative Works]
    B --> C[Third:<br/>NDAs for<br/>Contractors/Employees]
    C --> D[Fourth:<br/>Consider Patent<br/>Only if Truly Novel]
    D --> E[Fifth:<br/>Monitor & Enforce<br/>Your Rights]
    style A fill:#e1f5ff
    style D fill:#fff4e1',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-19-3', 'mba-step-19',
'Sarah, a software developer, protected her codebase without patents: She used copyright (automatic) for her code, trademarks for her product name, NDAs for any contractors who accessed the code, and trade secret protection for her algorithms. Total cost: CHF 800 for trademark registration. Protection level: Sufficient to deter copycats and defend against infringement.',
NULL,
'Software patents are controversial and often hard to enforce. For most small software businesses, copyright + trade secrets + trademarks provide adequate protection more cheaply.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-19-4', 'mba-step-19',
'What to do if someone copies you: First, document the infringement (screenshots, dates). Second, send a friendly but firm cease-and-desist letter (often enough for small businesses). Third, if that fails, engage a lawyer for formal proceedings. Swiss courts can award damages and injunctions. But litigation is expensive — often CHF 10,000+ even for simple cases. Sometimes a negotiated coexistence agreement is wiser than war.',
NULL,
'David discovered a competitor using his trademarked brand name. A CHF 300 letter from his lawyer resolved it. The competitor rebranded. Sometimes enforcement is necessary to protect your market position.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-19-1', 'mba-step-19', 'q19-1', 'How long does Swiss trademark registration last?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-19-1a', 'mba-q-19-1', '5 years from the date of first use in commerce', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-19-1b', 'mba-q-19-1', '10 years from registration, renewable indefinitely for further 10-year periods', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-19-1c', 'mba-q-19-1', '20 years, like a patent', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-19-1d', 'mba-q-19-1', 'For the lifetime of the business owner, then it expires automatically', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-19-2', 'mba-step-19', 'q19-2', 'In Switzerland, when does copyright arise?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-19-2a', 'mba-q-19-2', 'Only after registration with the IPI', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-19-2b', 'mba-q-19-2', 'Automatically when a work is created', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-19-2c', 'mba-q-19-2', 'Only after publication', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-19-2d', 'mba-q-19-2', 'Only for works with copyright notices', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-19-3', 'mba-step-19', 'q19-3', 'What was Luca''s mistake with his clothing brand logo?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-19-3a', 'mba-q-19-3', 'He did not register the logo as a design patent with the IPI before launch', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-19-3b', 'mba-q-19-3', 'He skipped the trademark search and registration', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-19-3c', 'mba-q-19-3', 'He hired a designer who unknowingly copied an existing protected work', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-19-3d', 'mba-q-19-3', 'He did not include any copyright notice on his marketing materials', FALSE, 3);

-- ============================================================
-- PAGE 20: Managing Operations and Quality
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-20', 'business-fundamentals-mba', 'managing-operations-quality',
'Managing Operations and Quality',
'When Anna opened her bakery, every croissant was slightly different. Some days they were perfect; some days underbaked. Customers noticed. One Yelp review: "Inconsistent — sometimes amazing, sometimes disappointing." Anna realised that talent is not enough; systems are required. She documented every recipe, timed every process, calibrated her ovens, and trained her staff to the same standard. Three months later, her Google rating jumped from 3.8 to 4.7 stars. Consistency builds trust. Trust builds business. Operations management is how you deliver consistency.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-20-1', 'mba-step-20', 'Process Documentation',
'Writing down how work is done (Prozessdokumentation / documentation des processus). Recipes, checklists, standard procedures. Enables consistency, training, and improvement. Without it, knowledge lives only in people''s heads — risky when they leave or are absent.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-20-2', 'mba-step-20', 'Quality Management',
'A systematic approach (Qualitätsmanagement / management de la qualité) to ensuring products/services meet standards. Includes quality control (checking output), quality assurance (preventing defects), and continuous improvement.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-20-3', 'mba-step-20', 'Standard Work',
'The best current method (Standardarbeit / travail standardisé) for performing a task, documented and followed by all. Not rigid bureaucracy — a baseline for improvement. When everyone follows the standard, variations disappear and problems become visible.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-20-4', 'mba-step-20', 'Supplier Evaluation',
'Assessing vendors (Lieferantenbewertung / évaluation des fournisseurs) on quality, reliability, price, and service. Critical for maintaining your own quality. A chain is only as strong as its weakest link.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-20-5', 'mba-step-20', 'Punctuality',
'Being on time (Pünktlichkeit / ponctualité), every time. The Swiss value this highly. In business, it means delivering when promised, opening on schedule, responding to messages promptly. Punctuality signals reliability and respect.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-20-1', 'mba-step-20',
'Anna''s bakery transformation: She created Standardarbeit sheets for each product. Croissant procedure: 1) Mix dough, 2) Laminate 3x, 3) Rest 30 min, 4) Cut and shape, 5) Proof 2 hours at 24°C, 6) Bake 18 min at 190°C. Result: Every croissant now identical. Staff can cover for each other. Quality is predictable.',
NULL,
'The Swiss concept of "Ordnung" (order) applies to business operations. Clear processes create order from chaos.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-20-2', 'mba-step-20',
'The continuous improvement cycle:',
NULL, NULL,
'graph TD
    A[Document<br/>Current Process] --> B[Follow<br/>Standard]
    B --> C[Identify<br/>Problems]
    C --> D[Improve<br/>Process]
    D --> E[Update<br/>Standard]
    E --> B
    style C fill:#fff4e1
    style D fill:#e1f5ff',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-20-3', 'mba-step-20',
'David''s IT consultancy used simple quality management: Every code deployment followed a checklist (test locally, code review, deploy to staging, client approval, deploy to production). Before the checklist: 30% of deployments had issues requiring fixes. After: 5% issues. The checklist took 5 minutes; fixing deployment problems took hours.',
NULL,
'Checklists are not just for pilots and surgeons. Any complex, repetitive task benefits from a checklist.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-20-4', 'mba-step-20',
'The Pünktlichkeit premium: Swiss customers will pay more for reliable, on-time service. A handyman who arrives exactly when promised, finishes on schedule, and cleans up after becomes the "expensive but worth it" choice over the "cheap but unreliable" alternative. Operational excellence is a competitive advantage.',
NULL,
'Markus charges 30% more than his competitor for the same renovation work. His differentiator: he starts and finishes exactly as scheduled, every time. His competitor is cheaper but chronically 2-3 weeks late. Most customers choose Markus.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-20-1', 'mba-step-20', 'q20-1', 'What happened to Anna''s bakery rating after implementing standard procedures?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-20-1a', 'mba-q-20-1', 'It stayed exactly the same despite all the new procedures', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-20-1b', 'mba-q-20-1', 'It dropped because customers disliked the standardised products', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-20-1c', 'mba-q-20-1', 'Her Google rating jumped from 3.8 to 4.7 stars within three months of implementing procedures', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-20-1d', 'mba-q-20-1', 'She closed the bakery after the standardisation process proved too expensive', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-20-2', 'mba-step-20', 'q20-2', 'What is Standardarbeit?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-20-2a', 'mba-q-20-2', 'The contractual obligation to work standard office hours from 9 to 5 every weekday', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-20-2b', 'mba-q-20-2', 'The documented standard method for performing a recurring task the same way every time', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-20-2c', 'mba-q-20-2', 'The practice of working continuously without scheduled breaks to maximise output', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-20-2d', 'mba-q-20-2', 'The policy of only hiring standard permanent employees rather than freelancers', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-20-3', 'mba-step-20', 'q20-3', 'Why can Markus charge 30% more than his competitor?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-20-3a', 'mba-q-20-3', 'He invests in significantly better professional tools and equipment than competitors', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-20-3b', 'mba-q-20-3', 'He always delivers work that starts and finishes exactly on the agreed schedule', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-20-3c', 'mba-q-20-3', 'He spends more on advertising than any other handyman in his region', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-20-3d', 'mba-q-20-3', 'He deliberately sources cheaper materials to maximise his profit margin', FALSE, 3);

-- ============================================================
-- PAGE 21: Growth and Scaling
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-21', 'business-fundamentals-mba', 'growth-and-scaling',
'Growth and Scaling',
'When Laura''s vegan café hit CHF 20,000 monthly revenue, she thought: "Time to expand!" She opened a second location, hired 5 new staff, and doubled her marketing spend. Six months later, she was bankrupt. Why? She had grown revenue but destroyed profitability. Her second location had higher rent, lower foot traffic, and required all her attention, neglecting the first location. She learned the hard way: growth is not always good. Smart growth is good. This page explains when and how to expand without killing your business.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-21-1', 'mba-step-21', 'Growth',
'Increasing revenue, customers, or market presence (Wachstum / croissance). Can be organic (slow, funded by profits) or inorganic (fast, funded by investment or debt). Not all growth is profitable growth.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-21-2', 'mba-step-21', 'Scaling',
'Growing revenue faster than costs (Skalierung / mise à l''échelle). The holy grail of business. Requires systems, delegation, and often technology. A scalable business can double revenue without doubling expenses.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-21-3', 'mba-step-21', 'Quality First',
'The Swiss business philosophy (Qualität vor Quantität / qualité avant quantité) that sustainable success comes from excellence, not just size. Many Swiss Mittelstand companies stay small but world-class rather than growing big and mediocre.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-21-4', 'mba-step-21', 'Capacity Planning',
'Understanding your maximum sustainable output (Kapazitätsplanung / planification des capacités) before quality suffers. Growing beyond capacity creates bottlenecks, delays, and customer dissatisfaction.',
3);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-21-1', 'mba-step-21',
'Signs you are ready to grow: 1) Consistent profitability for 12+ months; 2) Systems that work without your constant presence; 3) Demand exceeding your capacity; 4) Cash reserves for the investment; 5) You have identified the right growth opportunity (not just "bigger is better"). Laura had none of these.',
NULL,
'Growth readiness checklist: Can your first location run 2 weeks without you? If not, you are not ready for a second location.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-21-2', 'mba-step-21',
'The growth decision tree:',
NULL, NULL,
'graph TD
    A[Consistent Profit<br/>12+ Months] --> B{Why Grow?}
    B -->|Demand Exceeds<br/>Capacity| C[Organic Growth<br/>Same Location/Service]
    B -->|New Market<br/>Opportunity| D[Calculated Expansion<br/>Research Required]
    B -->|Ego/Competition| E[Dangerous Growth<br/>Risky Motivation]
    C --> F[Systematise First]
    D --> G[Pilot Test<br/>Small Scale]
    E --> H[Reconsider<br/>Motivation]
    F --> I[Scale Gradually]
    G --> J{Pilot Works?}
    J -->|Yes| K[Controlled Expansion]
    J -->|No| L[Stop/Learn]
    style E fill:#ffe1e1
    style H fill:#ffe1e1',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-21-3', 'mba-step-21',
'The solo-to-team transition: Hiring your first employees is the hardest growth step. You go from doing to managing. From craftsman to Geschäftsführer. Many entrepreneurs fail here — they micromanage, fail to delegate, or hire poorly. The rule: hire for attitude and values, train for skills. You can teach someone to use your software; you cannot teach them to care about quality.',
NULL,
'David spent 6 months finding his first employee. The wrong hire would have destroyed his reputation. The right hire doubled his capacity and freed him for strategic work.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-21-4', 'mba-step-21',
'Swiss wisdom on growth: Many successful Swiss companies deliberately stay small. They focus on being the best in their niche rather than the biggest in the market. The "hidden champions" — thousands of Swiss SMEs that dominate global niches while remaining family-owned and modestly sized. Consider: do you want to be big, or do you want to be excellent?',
NULL,
'There is no shame in building a CHF 2 million business that generates CHF 400,000 annual profit for you, employs 8 people well, and lets you have a life. That is success.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-21-1', 'mba-step-21', 'q21-1', 'What is the difference between growth and scaling?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-21-1a', 'mba-q-21-1', 'There is no practical difference — the two terms are completely interchangeable in modern business', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-21-1b', 'mba-q-21-1', 'Scaling means growing revenue faster than costs, so profitability improves as the business grows', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-21-1c', 'mba-q-21-1', 'Growth means international expansion while scaling refers only to domestic operations', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-21-1d', 'mba-q-21-1', 'Scaling requires prior written approval from the cantonal economic promotion office', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-21-2', 'mba-step-21', 'q21-2', 'Why did Laura''s second café location fail?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-21-2a', 'mba-q-21-2', 'She did not hire enough staff to cover the additional workload at both locations simultaneously', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-21-2b', 'mba-q-21-2', 'She expanded before her first location was profitable and systems were working', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-21-2c', 'mba-q-21-2', 'The food quality at the second location was consistently poor and received bad reviews', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-21-2d', 'mba-q-21-2', 'Vegan food had fallen out of fashion with the target demographic', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-21-3', 'mba-step-21', 'q21-3', 'What does Qualität vor Quantität mean?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-21-3a', 'mba-q-21-3', 'Excellence before size', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-21-3b', 'mba-q-21-3', 'Quantity before quality — a high-volume approach that sacrifices standards for growth', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-21-3c', 'mba-q-21-3', 'Quality is too expensive for small businesses to maintain', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-21-3d', 'mba-q-21-3', 'Producing in quantity is what ultimately drives sustainable long-term profit', FALSE, 3);

-- ============================================================
-- PAGE 22: Exit Strategies
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-22', 'business-fundamentals-mba', 'exit-strategies',
'Exit Strategies',
'When Thomas, 58, wanted to retire and sell his printing business he had built over 30 years, he discovered a painful truth: his business was unsellable. No proper books. Customer concentration — 60% of revenue from one client. Everything depended on him. He eventually sold the equipment for CHF 40,000 and closed. A lifetime of work, gone. Meanwhile, his competitor sold a similar-sized business for CHF 800,000. The difference? Planning. Every business journey ends. Selling, closing, or succession — this page prepares you for the end game, whether it is 2 years or 20 years away.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-22-1', 'mba-step-22', 'Business Succession',
'Transferring business ownership (Unternehmensnachfolge / succession d''entreprise) to the next generation, employees, or external buyers. The dominant form of business transition in Switzerland. Requires preparation: clean books, documented processes, and reduced owner dependency.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-22-2', 'mba-step-22', 'Business Valuation',
'What the business is worth (Firmenwert / valeur d''entreprise). Typically calculated as a multiple of earnings (EBITDA) plus asset value. For small Swiss businesses, multiples often 3-6x EBITDA. Clean books and growth potential increase value; owner dependence decreases it.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-22-3', 'mba-step-22', 'Due Diligence',
'Due diligence — the investigation a buyer conducts before purchase. They examine finances, contracts, legal compliance, customer relationships, and operations. Any problem found reduces price or kills the deal. Clean preparation is essential.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-22-4', 'mba-step-22', 'Liquidation',
'Liquidation (liquidation) — formally closing a business. Involves settling debts, distributing remaining assets, and dissolving the legal entity. For GmbH/AG, requires formal liquidation process with published notices. For Einzelunternehmen, simpler but still requires tax clearance.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-22-5', 'mba-step-22', 'Dissolution',
'The legal termination (Auflösung / dissolution) of a company. For GmbH/AG, involves shareholder resolution, appointment of liquidator, creditor notice period (usually 1 year), and commercial register deletion. Proper dissolution protects you from future liabilities.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-22-1', 'mba-step-22',
'Thomas''s mistakes that destroyed his business value: 1) No audited financials — buyers could not verify claims; 2) Customer concentration — one client held 60% of revenue; 3) Owner dependence — Thomas WAS the business; 4) No documented processes — knowledge in his head only; 5) Outdated equipment — no recent investment. His competitor had the opposite: clean books, diverse customers, trained staff, systems, and modern equipment.',
NULL,
'The time to prepare for exit is when you start the business, not when you want to leave.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-22-2', 'mba-step-22',
'Exit options hierarchy:',
NULL, NULL,
'graph TD
    A[Best:<br/>Strategic Sale<br/>Highest Price] --> B[Good:<br/>Management Buyout<br/>Employee Purchase]
    B --> C[Acceptable:<br/>Family Succession<br/>Continuity]
    C --> D[Last Resort:<br/>Liquidation<br/>Asset Sale]
    D --> E[Worst:<br/>Bankruptcy<br/>Failure]
    style A fill:#e1ffe1
    style E fill:#ffe1e1',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-22-3', 'mba-step-22',
'Making your business sellable: 1) Clean books from day one; 2) Diversify customers — no single customer over 20%; 3) Build a team, not solo dependency; 4) Document all processes; 5) Invest in equipment and technology; 6) Establish recurring revenue (subscriptions, contracts); 7) Protect IP (trademarks, patents); 8) Resolve any legal issues. Start this now, even if exit is decades away.',
NULL,
'Sarah, 30, runs a consultancy. She is already preparing for eventual sale: two employees handle 60% of client work, processes are documented, revenue is recurring (annual contracts). If she wanted to sell today, the business has value beyond her personal involvement.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-22-4', 'mba-step-22',
'The emotional side: Your business is your identity. Selling or closing can feel like losing part of yourself. Plan not just financially but emotionally. What will you do next? How will you define yourself? Many entrepreneurs struggle with this transition. Prepare mentally as well as practically.',
NULL,
'Lukas sold his successful agency at 45. He had CHF 2 million from the sale but was depressed for a year — he had not planned for "what comes next." Build your identity beyond your business title.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-22-1', 'mba-step-22', 'q22-1', 'What made Thomas''s printing business unsellable?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-22-1a', 'mba-q-22-1', 'The shop was in a poor commercial location with low foot traffic and no parking', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-22-1b', 'mba-q-22-1', 'No proper books, high customer concentration, and owner dependence', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-22-1c', 'mba-q-22-1', 'Digital disruption had made physical printing services entirely obsolete', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-22-1d', 'mba-q-22-1', 'He set a sale price far above what the market would accept', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-22-2', 'mba-step-22', 'q22-2', 'What is Due Diligence?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-22-2a', 'mba-q-22-2', 'A formal tax audit carried out by the cantonal tax authority on business premises', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-22-2b', 'mba-q-22-2', 'The investigation a buyer performs to verify a business''s finances, contracts, and liabilities', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-22-2c', 'mba-q-22-2', 'The structured HR process of recruiting and onboarding new employees', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-22-2d', 'mba-q-22-2', 'A specialised form of management liability insurance for directors', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-22-3', 'mba-step-22', 'q22-3', 'When should you start preparing your business for eventual exit?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-22-3a', 'mba-q-22-3', 'One year before you plan to leave', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-22-3b', 'mba-q-22-3', 'When you start the business', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-22-3c', 'mba-q-22-3', 'Only if you plan to sell — otherwise it does not matter', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-22-3d', 'mba-q-22-3', 'Five years after starting', FALSE, 3);

-- ============================================================
-- PAGE 23: Professional Support
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-23', 'business-fundamentals-mba', 'professional-support',
'Professional Support',
'When Daniel started his first business at 22, he tried to do everything himself: bookkeeping, taxes, contracts, payroll. He spent 15 hours a week on admin. His business suffered. His sleep suffered. After a year, he hired a Treuhand (fiduciaire) for CHF 300/month. The time saved went to sales and product development. Revenue doubled in 8 months. The CHF 3,600 annual cost generated CHF 50,000 in additional revenue. Professional support is not an expense — it is an investment in your focus and sanity. This page explains when to hire experts and what to expect.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-23-1', 'mba-step-23', 'Fiduciary',
'A professional (Treuhand / fiduciaire) who handles bookkeeping, payroll, VAT filing, and annual accounts. Essential for most small businesses. Costs vary: CHF 200-500/month for basic bookkeeping, more for payroll and complex situations.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-23-2', 'mba-step-23', 'Tax Advisor',
'A professional (Steuerberater / conseiller fiscal) who specialises in tax planning and filing. Can be separate from your fiduciary or the same firm. Critical for complex situations: GmbH/AG structures, international transactions, significant assets.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-23-3', 'mba-step-23', 'Lawyer',
'A professional (Rechtsanwalt / avocat) for contracts, disputes, company formation, and legal compliance. Use for: drafting or reviewing major contracts, forming GmbH/AG, employment disputes, intellectual property matters, and any significant legal risk.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-23-4', 'mba-step-23', 'Mandate',
'The contract (Mandat / mandat) defining the relationship with a professional advisor. Specifies scope, responsibilities, fees, and duration. Read it. Question unclear terms. A good professional explains their mandate clearly.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-23-5', 'mba-step-23', 'Professional Fees',
'What professionals charge (Honorar / honoraires). Swiss professional services are expensive but transparent. Typical ranges: fiduciary CHF 100-200/hour, tax advisor CHF 150-300/hour, lawyer CHF 250-500/hour. Many offer fixed-price packages for small businesses.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-23-1', 'mba-step-23',
'What to do yourself vs. delegate: DO YOURSELF: customer relationships, product/service delivery, sales conversations, strategic decisions. DELEGATE: bookkeeping (once monthly transactions exceed 20), payroll (if you have employees), tax filing (always), contract review for significant deals, legal compliance checks. Your time is best spent where you add unique value.',
NULL,
'Rule of thumb: If a task can be done by someone at CHF 100/hour, and your time generates CHF 150+/hour in value, delegate.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-23-2', 'mba-step-23',
'Finding good advisors: Ask fellow entrepreneurs for recommendations. Check professional associations (EXPERTsuisse for Treuhand, SAV/FSA for tax advisors, Swiss Bar Association for lawyers). Interview multiple candidates. Ask about their experience with businesses your size. A good advisor educates you; a bad one just sends bills.',
NULL,
'Red flags: unwillingness to explain, no fixed-price options, no experience with small businesses, poor communication.',
NULL, 1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-23-3', 'mba-step-23',
'Daniel''s ROI calculation: Treuhand cost CHF 3,600/year. Time saved: 15 hours/week × 48 weeks = 720 hours. Value of that time redirected to revenue-generating activities: CHF 50,000 additional revenue. Even if only 10% of saved time generated revenue, the investment paid off. Plus: no stress about tax deadlines, no fear of mistakes, no lost receipts.',
NULL,
'Many young entrepreneurs see professional fees as "money out" rather than "time and risk saved." Reframe it: what is your time worth? What is peace of mind worth?',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-23-4', 'mba-step-23',
'When to upgrade your support: As your business grows, your needs change. Year 1: Basic Treuhand for bookkeeping and tax filing. Year 2-3: Add payroll support if you hire. Year 3+: Consider specialised Steuerberater for tax optimization. Year 5+: Engage lawyer for contract templates and IP protection. Year 10+: Strategic business consultant for growth planning. Match your professional team to your current stage.',
NULL,
'Nina reviews her professional support annually: "Am I getting value? Do I need more or less support? Are there new needs?" This ensures her advisory costs align with business value.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-23-1', 'mba-step-23', 'q23-1', 'What happened when Daniel hired a Treuhand?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-23-1a', 'mba-q-23-1', 'His admin costs increased while revenue remained completely unchanged', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-23-1b', 'mba-q-23-1', 'He freed up 15 hours weekly and doubled revenue within 8 months', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-23-1c', 'mba-q-23-1', 'The professional fees were so high that they eventually caused him to go bankrupt', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-23-1d', 'mba-q-23-1', 'He found the Treuhand unsatisfactory and reverted to doing all the admin himself again', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-23-2', 'mba-step-23', 'q23-2', 'What is a Treuhand?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-23-2a', 'mba-q-23-2', 'A dedicated business bank account with special trustee access features', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-23-2b', 'mba-q-23-2', 'A fiduciary firm handling your bookkeeping, payroll, and annual tax return', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-23-2c', 'mba-q-23-2', 'A government tax official employed by the cantonal Steueramt to audit businesses', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-23-2d', 'mba-q-23-2', 'A notarised legal document required when forming a GmbH', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-23-3', 'mba-step-23', 'q23-3', 'According to the rule of thumb, when should you delegate a task?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-23-3a', 'mba-q-23-3', 'Never — a true entrepreneur always does everything themselves to maintain full control', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-23-3b', 'mba-q-23-3', 'Always — delegate every single task and focus only on vision', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-23-3c', 'mba-q-23-3', 'When paying someone else to do it costs less per hour than what you could earn in that same time', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-23-3d', 'mba-q-23-3', 'Only for tasks that you personally find unpleasant or boring', FALSE, 3);

-- ============================================================
-- PAGE 24: The Entrepreneur Mindset
-- ============================================================
INSERT INTO T_certification_step (id, certification_id, step_key, title, why, info_expanded, created_at, updated_at)
VALUES ('mba-step-24', 'business-fundamentals-mba', 'entrepreneur-mindset',
'The Entrepreneur Mindset',
'You have learned about company structures, taxes, accounting, marketing, and operations. But the most important factor in your success cannot be found in any regulation or textbook: it is your mindset. Meet three Swiss entrepreneurs: Hans, who failed twice before building a successful manufacturing company at 34; Fatima, who turned a side hustle into a CHF 2 million agency while raising two children; and Lukas, whose first café failed but whose second became a beloved local institution. Their common trait was not talent or luck. It was resilience. The ability to learn from failure, adapt, and persist. This final page ties everything together and prepares you for the journey ahead.',
FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-24-1', 'mba-step-24', 'Resilience',
'The capacity to recover (Resilienz / résilience) from difficulties. In business, this means surviving slow months, handling difficult customers, adapting to market changes, and bouncing back from failure. Not innate — it can be developed through experience and mindset.',
0);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-24-2', 'mba-step-24', 'Lifelong Learning',
'The commitment to continuous education (Lebenslanges Lernen / apprentissage tout au long de la vie). Markets change, laws change, technology changes. Standing still means falling behind. The best entrepreneurs read, attend courses, join peer groups, and stay curious.',
1);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-24-3', 'mba-step-24', 'Networking',
'Building relationships (Netzwerken / réseautage) with fellow entrepreneurs, potential customers, suppliers, and advisors. Swiss business culture values trust built over time. Your network provides support, advice, referrals, and opportunities.',
2);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-24-4', 'mba-step-24', 'Work-Life Balance',
'Maintaining health, relationships, and personal fulfilment (Work-Life-Balance / équilibre vie-travail) while building a business. Burnout destroys businesses and lives. Sustainable success requires sustainable effort.',
3);
INSERT INTO T_info_item (id, step_id, term, description, sequence_order)
VALUES ('mba-ii-24-5', 'mba-step-24', 'Entrepreneurial Spirit',
'The combination of initiative, risk tolerance, creativity, and persistence (Unternehmergeist / esprit d''entreprise) that drives business creation. Not about being reckless — about seeing opportunities and acting on them despite uncertainty.',
4);

INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-24-1', 'mba-step-24',
'Hans''s story: At 24, his first startup ran out of cash. At 27, his second failed when his co-founder quit. At 30, he started his manufacturing business with lessons learned and CHF 20,000 saved. At 34, he employed 15 people and had CHF 3 million revenue. What kept him going: "Each failure taught me something the next business needed. I was not starting over — I was starting from experience."',
NULL,
'The Swiss view of failure is pragmatic. Bankruptcy is not shameful if you acted honourably. What matters is what you learn and whether you try again more wisely.',
NULL, 0);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-24-2', 'mba-step-24',
'The entrepreneur journey:',
NULL, NULL,
'graph TD
    A[Start<br/>Enthusiasm] --> B[Reality<br/>Challenges]
    B --> C{Adapt or Quit?}
    C -->|Quit| D[End<br/>Lesson Learned]
    C -->|Adapt| E[Growth<br/>New Skills]
    E --> F{Keep Going?}
    F -->|No| G[Exit<br/>Success or Pivot]
    F -->|Yes| H[Maturity<br/>Sustainable Business]
    H --> I[Legacy<br/>Mentor Others]
    style C fill:#fff4e1
    style H fill:#e1ffe1',
1);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-24-3', 'mba-step-24',
'Fatima''s principles for sustainable success: 1) Never compromise family time — it is non-negotiable; 2) Hire before you are desperate — rushing leads to bad hires; 3) Say no to bad clients — they cost more than they pay; 4) Invest 10% of revenue in learning — courses, books, conferences; 5) Build a peer group — monthly dinners with fellow entrepreneurs saved her sanity multiple times.',
NULL,
'The romantic image of the entrepreneur working 80-hour weeks is toxic. Sustainable businesses are built by sustainable people.',
NULL, 2);
INSERT INTO T_instruction (id, step_id, text, command, note, mermaid_diagram, sequence_order)
VALUES ('mba-in-24-4', 'mba-step-24',
'Final advice: You have the tools now. You understand Swiss company law, accounting, taxes, marketing, and operations. But knowledge without action is just potential. Start small. Test ideas. Fail small and learn. Build gradually. Stay curious. Ask for help. And remember — business is a marathon, not a sprint. The entrepreneurs who succeed are not necessarily the smartest or the most funded. They are the ones who keep going when others quit. Will that be you?',
NULL,
'Switzerland needs young entrepreneurs. It needs your ideas, your energy, and your contribution to the economy. The system is set up to support you if you engage with it properly. Now go build something.',
NULL, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-24-1', 'mba-step-24', 'q24-1', 'What quality did Hans, Fatima, and Lukas share that led to their eventual success?', 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-24-1a', 'mba-q-24-1', 'They all came from wealthy families who could provide financial safety nets', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-24-1b', 'mba-q-24-1', 'Resilience', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-24-1c', 'mba-q-24-1', 'They navigated entrepreneurship without ever experiencing a significant setback or failure', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-24-1d', 'mba-q-24-1', 'They all held university degrees in business administration from Swiss universities', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-24-2', 'mba-step-24', 'q24-2', 'What percentage of revenue does Fatima recommend investing in learning?', 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-24-2a', 'mba-q-24-2', '1%', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-24-2b', 'mba-q-24-2', '5%', FALSE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-24-2c', 'mba-q-24-2', 'Around 10% of annual revenue invested in courses, books, and professional development', TRUE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-24-2d', 'mba-q-24-2', '25%', FALSE, 3);

INSERT INTO T_question (id, step_id, question_key, text, sequence_order)
VALUES ('mba-q-24-3', 'mba-step-24', 'q24-3', 'According to the page, what type of race is business?', 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-24-3a', 'mba-q-24-3', 'A sprint — move as fast as possible to outrun the competition in the early stages', FALSE, 0);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-24-3b', 'mba-q-24-3', 'A marathon requiring sustained effort, patience, and recovery after setbacks', TRUE, 1);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-24-3c', 'mba-q-24-3', 'A relay race — hand off responsibilities to others as quickly as possible', FALSE, 2);
INSERT INTO T_answer_option (id, question_id, text, is_correct, sequence_order)
VALUES ('mba-a-24-3d', 'mba-q-24-3', 'A hurdle race — where success depends on how well you navigate each obstacle', FALSE, 3);

-- ============================================================
-- PAGE ENTRIES FOR CERTIFICATION NAVIGATION
-- ============================================================
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-01', 'business-fundamentals-mba', 'DIRECT', 0, 'mba-step-01', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-02', 'business-fundamentals-mba', 'DIRECT', 1, 'mba-step-02', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-03', 'business-fundamentals-mba', 'DIRECT', 2, 'mba-step-03', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-04', 'business-fundamentals-mba', 'DIRECT', 3, 'mba-step-04', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-05', 'business-fundamentals-mba', 'DIRECT', 4, 'mba-step-05', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-06', 'business-fundamentals-mba', 'DIRECT', 5, 'mba-step-06', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-07', 'business-fundamentals-mba', 'DIRECT', 6, 'mba-step-07', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-08', 'business-fundamentals-mba', 'DIRECT', 7, 'mba-step-08', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-09', 'business-fundamentals-mba', 'DIRECT', 8, 'mba-step-09', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-10', 'business-fundamentals-mba', 'DIRECT', 9, 'mba-step-10', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-11', 'business-fundamentals-mba', 'DIRECT', 10, 'mba-step-11', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-12', 'business-fundamentals-mba', 'DIRECT', 11, 'mba-step-12', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-13', 'business-fundamentals-mba', 'DIRECT', 12, 'mba-step-13', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-14', 'business-fundamentals-mba', 'DIRECT', 13, 'mba-step-14', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-15', 'business-fundamentals-mba', 'DIRECT', 14, 'mba-step-15', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-16', 'business-fundamentals-mba', 'DIRECT', 15, 'mba-step-16', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-17', 'business-fundamentals-mba', 'DIRECT', 16, 'mba-step-17', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-18', 'business-fundamentals-mba', 'DIRECT', 17, 'mba-step-18', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-19', 'business-fundamentals-mba', 'DIRECT', 18, 'mba-step-19', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-20', 'business-fundamentals-mba', 'DIRECT', 19, 'mba-step-20', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-21', 'business-fundamentals-mba', 'DIRECT', 20, 'mba-step-21', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-22', 'business-fundamentals-mba', 'DIRECT', 21, 'mba-step-22', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-23', 'business-fundamentals-mba', 'DIRECT', 22, 'mba-step-23', NULL, NULL);
INSERT INTO T_page_entry (id, certification_id, entry_type, sequence_order, direct_step_id, min_required, max_required)
VALUES ('mba-pe-24', 'business-fundamentals-mba', 'DIRECT', 23, 'mba-step-24', NULL, NULL);
