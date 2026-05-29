#!/usr/bin/env python3
"""Check that all T_info_item term values are within VARCHAR(100)."""
import re
import sys
from pathlib import Path

migration_dir = Path(sys.argv[1] if len(sys.argv) > 1 else 'src/main/resources/db/migration')
errors = []
for f in sorted(migration_dir.glob('V01.03[3-9]__insert_business_fundamentals_mba*.sql')):
    content = f.read_text()
    pattern = re.compile(r"INSERT INTO T_info_item.*?VALUES \('[^']+', '[^']+', '((?:[^']|'')+)',", re.DOTALL)
    for m in pattern.finditer(content):
        term = m.group(1).replace("''", "'")
        if len(term) > 100:
            errors.append((f.name, len(term), term))

if errors:
    print("ERRORS - terms exceeding VARCHAR(100):")
    for fname, length, term in errors:
        print(f"  {fname}: len={length}: {term}")
    sys.exit(1)
else:
    print("All term values within VARCHAR(100) limit.")
