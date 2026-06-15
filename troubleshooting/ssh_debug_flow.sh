#!/bin/bash

echo "Checking SSH connectivity..."

nc -zv localhost 22

echo ""
echo "SSH processes:"
ps aux | grep ssh | grep -v grep

echo ""
echo "Simulated auth logs:"
echo "Failed password for user"
echo "Connection closed"
