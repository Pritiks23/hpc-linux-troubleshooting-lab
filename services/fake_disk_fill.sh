#!/bin/bash
echo "Simulating disk exhaustion..."
dd if=/dev/zero of=/tmp/fill_disk.img bs=1M count=2000
df -h
