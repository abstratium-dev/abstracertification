#!/usr/bin/env python3
"""
Analyzes answer option length distribution across MBA certification SQL files.
Checks: in what % of questions is the correct answer the longest?
Also checks: in what % of questions is the correct answer longer than exactly 2 others?
"""
import re
import sys
from pathlib import Path

def analyze_file(filepath):
    content = Path(filepath).read_text()

    # Find all questions
    questions = {}
    q_pattern = re.compile(
        r"VALUES \('(mba-q-[^']+)', '(mba-[^']+)', '[^']+', '([^']+)',",
        re.MULTILINE
    )
    for m in q_pattern.finditer(content):
        qid = m.group(1)
        questions[qid] = []

    # Find all answer options
    a_pattern = re.compile(
        r"VALUES \('(mba-a-[^']+)', '(mba-q-[^']+)', '((?:[^']|'')+)', (TRUE|FALSE),",
        re.MULTILINE
    )
    answers = {}
    for m in a_pattern.finditer(content):
        aid = m.group(1)
        qid = m.group(2)
        text = m.group(3).replace("''", "'")
        is_correct = m.group(4) == 'TRUE'
        if qid not in answers:
            answers[qid] = []
        answers[qid].append({'id': aid, 'text': text, 'len': len(text), 'correct': is_correct})

    return answers

def analyze_all(migration_dir):
    migration_dir = Path(migration_dir)
    all_answers = {}

    sql_files = sorted(migration_dir.glob('V01.03[3-9]__insert_business_fundamentals_mba*.sql'))
    # Also check V01.037 if it exists
    sql_files += sorted(migration_dir.glob('V01.037__*.sql'))

    files_found = []
    for f in sorted(set(sql_files)):
        data = analyze_file(f)
        all_answers.update(data)
        files_found.append(f.name)

    print(f"Files analyzed: {', '.join(files_found)}")
    print(f"Total questions: {len(all_answers)}\n")

    correct_is_longest = 0
    correct_longer_than_two = 0
    correct_is_shortest = 0
    total = 0

    per_question_details = []

    for qid, opts in all_answers.items():
        if not opts:
            continue
        correct_opts = [o for o in opts if o['correct']]
        if not correct_opts:
            continue
        correct = correct_opts[0]
        others = [o for o in opts if not o['correct']]
        correct_len = correct['len']
        other_lens = [o['len'] for o in others]
        max_len = max([correct_len] + other_lens)
        min_len = min([correct_len] + other_lens)

        is_longest = correct_len == max_len and all(correct_len >= l for l in other_lens)
        longer_than_two = sum(1 for l in other_lens if correct_len > l)
        is_shortest = correct_len == min_len and all(correct_len <= l for l in other_lens)

        if is_longest:
            correct_is_longest += 1
        if longer_than_two >= 2:
            correct_longer_than_two += 1
        if is_shortest:
            correct_is_shortest += 1
        total += 1

        per_question_details.append({
            'qid': qid,
            'correct_len': correct_len,
            'other_lens': other_lens,
            'is_longest': is_longest,
            'longer_than': longer_than_two,
            'is_shortest': is_shortest,
        })

    print(f"=== Distribution Analysis ===")
    print(f"Total questions: {total}")
    print(f"Correct is longest: {correct_is_longest}/{total} = {100*correct_is_longest/total:.1f}% (target: ~25%)")
    print(f"Correct longer than 2 others: {correct_longer_than_two}/{total} = {100*correct_longer_than_two/total:.1f}% (target: ~50%)")
    print(f"Correct is shortest: {correct_is_shortest}/{total} = {100*correct_is_shortest/total:.1f}%")

    print(f"\n=== Questions where correct IS longest ===")
    for d in per_question_details:
        if d['is_longest']:
            print(f"  {d['qid']}: correct={d['correct_len']}, others={d['other_lens']}")

    print(f"\n=== Questions where correct IS shortest ===")
    for d in per_question_details:
        if d['is_shortest']:
            print(f"  {d['qid']}: correct={d['correct_len']}, others={d['other_lens']}")


if __name__ == '__main__':
    migration_dir = sys.argv[1] if len(sys.argv) > 1 else 'src/main/resources/db/migration'
    analyze_all(migration_dir)
