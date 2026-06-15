echo "Checking SSH service..."
systemctl status ssh

echo "Checking port 22..."
nc -zv localhost 22

echo "Checking logs..."
journalctl -u ssh -n 50 --no-pager

echo "Checking authentication failures..."
grep "Failed password" /var/log/auth.log 2>/dev/null
