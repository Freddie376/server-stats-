#!/bin/bash
# server-stats.sh
# Shows basic server performance stats on any Linux server.

line() { echo "------------------------------------------------------------"; }

echo "SERVER PERFORMANCE STATS"
line

# --- Stretch: system info ---
echo "OS version : $(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)"
echo "Uptime     : $(uptime -p)"
echo "Load average (1, 5, 15 min): $(cut -d' ' -f1-3 /proc/loadavg)"
echo "Logged in users: $(who | wc -l)"
line

# --- 1. Total CPU usage ---
# top shows a line like: %Cpu(s): 3.0 us, 1.0 sy, 0.0 ni, 96.0 id, ...
# "id" is idle time, so usage = 100 - idle.
cpu_idle=$(top -bn1 | awk '/Cpu\(s\)/ {for (i=1; i<=NF; i++) if ($i ~ /^id,?$/) print $(i-1)}')
cpu_used=$(awk -v idle="$cpu_idle" 'BEGIN {printf "%.1f", 100 - idle}')
echo "CPU USAGE"
echo "Total CPU usage: ${cpu_used}%"
line

# --- 2. Total memory usage (free vs used) ---
echo "MEMORY USAGE"
free -m | awk '/^Mem:/ {
    free = $2 - $3
    printf "Total: %d MB\nUsed : %d MB (%.1f%%)\nFree : %d MB (%.1f%%)\n", $2, $3, $3/$2*100, free, free/$2*100
}'
line

# --- 3. Total disk usage (free vs used) ---
# --total adds a summary row; -x skips temporary in-memory filesystems.
echo "DISK USAGE"
df -h --total -x tmpfs -x devtmpfs -x squashfs | awk '/^total/ {
    printf "Total: %s\nUsed : %s (%s)\nFree : %s\n", $2, $3, $5, $4
}'
line

# --- 4. Top 5 processes by CPU usage ---
echo "TOP 5 PROCESSES BY CPU"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
line

# --- 5. Top 5 processes by memory usage ---
echo "TOP 5 PROCESSES BY MEMORY"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6
line

# --- Stretch: failed login attempts (needs root) ---
echo "FAILED LOGIN ATTEMPTS"
if [ "$(id -u)" -eq 0 ] && command -v lastb >/dev/null 2>&1; then
    echo "Total failed attempts: $(lastb 2>/dev/null | grep -vc -e '^$' -e 'btmp begins')"
else
    echo "Run with sudo to see failed login attempts."
fi
line
