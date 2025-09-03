#!/bin/bash

DISK_THRESHOLD=80
CPU_THRESHOLD=80
MEM_THRESHOLD=80
HOST_TO_PING="172.31.107.226"

# Function to log and alert
alert() {
    message="$1"
    echo "ALERT: $message"
    LOG_FILE="/home/runner/workspace/sysmon.log"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ALERT: $message" >> "$LOG_FILE"
}

info() {
    message="$1"
    echo "INFO: $message"
}

# Disk Usage Check
disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]; then
    alert "Disk usage is at ${disk_usage}% threshold: ${DISK_THRESHOLD}%"
else
    info "Disk usage is normal at ${disk_usage}%"
fi

# CPU Usage Check
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
cpu_usage=${cpu_usage%.*}
if [ "$cpu_usage" -gt "$CPU_THRESHOLD" ]; then
    alert "CPU usage is at ${cpu_usage}% threshold: ${CPU_THRESHOLD}%"
else
    info "CPU usage is normal at ${cpu_usage}%"
fi

# Memory Usage Check
mem_usage=$(free | awk '/Mem/ {printf("%.0f"), $3/$2 * 100}')
if [ "$mem_usage" -gt "$MEM_THRESHOLD" ]; then
    alert "Memory usage is at ${mem_usage}% threshold: ${MEM_THRESHOLD}%"
else
    info "Memory usage is normal at ${mem_usage}%"
fi

# Network Connectivity Check
ping -c 2 "$HOST_TO_PING" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    alert "Network check failed! Cannot reach $HOST_TO_PING"
else
    info "Network check passed! Successfully reached $HOST_TO_PING"
fi

echo "System check completed at $(date)"