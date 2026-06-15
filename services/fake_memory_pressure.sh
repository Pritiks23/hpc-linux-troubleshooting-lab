#!/bin/bash
echo "Simulating memory pressure..."
stress-ng --vm 2 --vm-bytes 90% --timeout 60s
