#!/bin/bash
systemctl daemon-reexec
systemctl restart broken-app.service
systemctl status broken-app.service
