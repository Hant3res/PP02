#!/bin/bash
# Скрипт мониторинга сервера страховой системы

echo "========================================"
echo "   INSURANCE SYSTEM MONITORING"
echo "========================================"
echo "Timestamp: $(date)"
echo ""

# System uptime
echo "▶ System uptime:"
uptime
echo ""

# Disk usage
echo "▶ Disk usage:"
df -h | grep -E '^/dev|Filesystem'
echo ""

# Memory usage
echo "▶ Memory usage:"
free -h
echo ""

# CPU load
echo "▶ CPU load average:"
cat /proc/loadavg
echo ""

# Service status
echo "▶ Insurance application status:"
if command -v systemctl &> /dev/null; then
    systemctl status insurance-app --no-pager 2>/dev/null || echo "Service not found"
else
    echo "systemctl not available"
fi
echo ""

# Recent errors in logs
echo "▶ Recent errors in logs:"
if [ -f /var/log/insurance/error.log ]; then
    tail -n 5 /var/log/insurance/error.log 2>/dev/null || echo "No errors found"
else
    echo "Log file not found"
fi

echo "========================================"
