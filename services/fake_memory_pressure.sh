#!/usr/bin/env bash
python3 - <<'PY'
chunks = []
for _ in range(100):
    chunks.append('x' * 10_000_000)
print('Allocated memory chunks:', len(chunks))
PY
