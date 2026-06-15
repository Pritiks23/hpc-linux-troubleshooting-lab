#!/bin/bash

SERVICE=$1

echo "===== SYSTEMCTL STATUS ====="
systemctl status $SERVICE --no-pager

echo "===== JOURNAL LOGS (LAST 100) ====="
journalctl -u $SERVICE -n 100 --no-pager

echo "===== CPU + MEMORY ====="
top -b -n 1 | head -20
free -h

echo "===== DISK USAGE ====="
df -h

echo "===== NETWORK PORTS ====="
ss -tupln
