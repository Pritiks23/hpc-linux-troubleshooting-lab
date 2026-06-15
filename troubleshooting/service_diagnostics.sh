#!/bin/bash

SERVICE=$1

echo "=== SERVICE STATUS ==="
systemctl status $SERVICE --no-pager 2>/dev/null || echo "systemctl unavailable in Codespaces"

echo ""
echo "=== LOGS ==="
journalctl -u $SERVICE -n 100 --no-pager 2>/dev/null || echo "No journal access"

echo ""
echo "=== SYSTEM HEALTH ==="
top -b -n 1 | head -20

echo ""
free -h

echo ""
df -h

echo ""
ss -tupln
