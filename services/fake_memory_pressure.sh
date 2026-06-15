#!/usr/bin/env bash
python3 - <<'PY'
import time
chunks = []
for _ in range(100):
    chunks.append('x' * 10000000)
print('Allocated memory chunks:', len(chunks))
time.sleep(60)
PY
