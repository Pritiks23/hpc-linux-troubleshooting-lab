#!/bin/bash

echo "Simulating memory pressure..."

python3 - << 'EOF'
a = []
while True:
    a.append("x" * 1000000)
EOF
