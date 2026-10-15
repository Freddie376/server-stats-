#server-stats/devops

A simple Bash script that shows basic performance stats for any Linux server.

Project from the roadmap.sh DevOps projects: https://roadmap.sh/devops

## What it shows

- Total CPU usage
- Total memory usage (used vs free, with percentage)
- Total disk usage (used vs free, with percentage)
- Top 5 processes by CPU usage
- Top 5 processes by memory usage
  
## How to run

1. Clone the repository:
   ```bash
   git clone https://github.com/Freddie376/server-stats-.git
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

## Commands used

| Stat | Command |
|------|---------|
| CPU usage | `top -bn1` |
| Memory | `free -m` |
| Disk | `df -h --total` |
| Top processes | `ps -eo pid,comm,%cpu,%mem --sort=-%cpu` |

## What I learned
I have learnt how to write Linux commands to give the general system performance report for any Linux server. This project has helped me to know how to write a nano script and make it executable. Use the above procedure to learn, practice and test your Linux server performance.
