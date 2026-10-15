#server-stats/devops

A simple Bash script that shows basic performance stats for any Linux server.

Project from the roadmap.sh DevOps projects: https://roadmap.sh/devops

## What it shows

- Total CPU usage
- Total memory usage (used vs free, with percentage)
- Total disk usage (used vs free, with percentage)
- Top 5 processes by CPU usage
- Top 5 processes by memory usage
- 
## How to run

1. Clone the repository:
   ```bash
   git clone 
   cd server-stats
   ```
2. Make the script executable:
   ```bash
   chmod +x server-stats.sh
   ```
3. Run it:
   ```bash
   ./server-stats.sh
   ```
4. To also see failed login attempts, run it as root:
   ```bash
   sudo ./server-stats.sh
   ```

## Commands used

| Stat | Command |
|------|---------|
| CPU usage | `top -bn1` (100 minus the idle percentage) |
| Memory | `free -m` |
| Disk | `df -h --total` |
| Top processes | `ps -eo pid,comm,%cpu,%mem --sort=-%cpu` |
| OS version | `/etc/os-release` |
| Uptime | `uptime -p` |
| Load average | `/proc/loadavg` |
| Logged-in users | `who` |
| Failed logins | `lastb` |

## What I learned

Write this part in your own words after you finish.
