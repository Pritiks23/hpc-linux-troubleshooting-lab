#!/bin/bash

echo "Attempting service recovery..."

systemctl daemon-reexec
systemctl restart broken_service.service

systemctl status broken_service.service
