#!/bin/bash

echo "Simulating disk exhaustion..."

dd if=/dev/zero of=/tmp/fill.img bs=1M count=500 2>/dev/null

df -h
