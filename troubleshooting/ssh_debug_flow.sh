#!/bin/bash

echo "=============================="
echo "SSH DEBUG DIAGNOSTIC FLOW"
echo "=============================="

echo ""
echo "[1] Checking SSH service status..."
systemctl status sshd --no-pager 2>/dev/null || systemctl status ssh --no-pager 2>/dev/null

echo ""
echo "[2] Checking port 22 connectivity..."
nc -zv localhost 22

echo ""
echo "[3] Checking SSH processes..."
ps aux | grep -E "sshd|ssh" | grep -v grep

echo ""
echo "[4] Recent authentication logs..."
journalctl -u sshd -n 20 --no-pager 2>/dev/null || \
journalctl -u ssh -n 20 --no-pager 2>/dev/null

echo ""
echo "[5] Common failure indicators:"
echo "- If port 22 is closed → service down or firewall issue"
echo "- If service active but connection fails → auth/config issue"
echo "- If logs show 'Failed password' → credential/auth problem"
echo "- If logs show 'refused connection' → daemon or bind issue"
