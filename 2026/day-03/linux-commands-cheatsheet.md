# Linux Commands Cheat Sheet

## Process Management 

- `&` - Add this character to the end of command to run it in the background.
- `ps aux` - Display full snapshot of running processes on your system.
- `pgrep name` - Find processes by name.
- `kill pid` - Kill a process specified by its process id(pid).
- `top` - Display sorted information about processes.

## File System

- `pwd` - Display the path of current working directory.
- `wc X` - Display the word count of X.
- `head X` - Display the first 10 lines of X.
- `tail X` - Display the last 10 lines of X.
- `grep patt path/to/src` - Search for a text pattern in file.
- `find` - Find files.
- `chmod 777 file` - Changes file permissions.
- `chown user:group file` - Change ownership of file.
- `du -h` - Show file/folder size on disk.
- `df -h` - Display free disk space(overall).

## Networking troubleshooting

- `ifconfig/ip a` - Display all network interfaces with IP addresses.
- `netstat -a` - Show listening tcp and udp ports and corresponding programs.
- `traceroute host` - Traces network path.
- `wget url` - Download files from internet.
- `whois domain` - Displays whois information for domain.
- `host domain` - Displays DNS IP address for domain.
- `nslookup domain` - Display IP address of domain.


# Linux Commands Cheat Sheet — Quick DevOps Summary

## Process Management

### `command &`

Run a command in the background.

```bash
python app.py &
```

Useful for long-running tasks without blocking the terminal.

---

### `ps aux`

Display all running processes.

Shows:

* USER
* PID
* CPU %
* Memory %
* Process State
* Command

Example:

```bash
ps aux | grep nginx
```

Used to identify resource-consuming processes.

---

### `pgrep`

Find PID using process name.

```bash
pgrep nginx
```

Useful alternative to:

```bash
ps aux | grep nginx
```

---

### `kill`

Terminate a process.

```bash
kill PID
```

Default:

```text
SIGTERM (15)
```

Force kill:

```bash
kill -9 PID
```

Uses:

```text
SIGKILL (9)
```

Common Signals:

| Signal  | Purpose       |
| ------- | ------------- |
| SIGINT  | Ctrl+C        |
| SIGTERM | Graceful stop |
| SIGKILL | Force stop    |
| SIGSTOP | Pause         |
| SIGCONT | Resume        |

---

### `top`

Real-time process monitoring.

```bash
top
```

Shows:

* CPU Usage
* Memory Usage
* Running Processes
* Load Average

Alternative:

```bash
htop
```

---

# File System Commands

### `pwd`

Show current working directory.

```bash
pwd
```

---

### `wc`

Count lines, words, and characters.

```bash
wc file.txt
```

Useful options:

```bash
wc -l file.txt   # Lines
wc -w file.txt   # Words
```

---

### `head`

Display first 10 lines.

```bash
head file.txt
```

Custom count:

```bash
head -20 file.txt
```

---

### `tail`

Display last 10 lines.

```bash
tail file.txt
```

Real-time log monitoring:

```bash
tail -f app.log
```

One of the most-used DevOps commands.

---

### `grep`

Search text patterns.

```bash
grep ERROR app.log
```

Case-insensitive:

```bash
grep -i error app.log
```

Recursive search:

```bash
grep -r "database" .
```

Commonly used for log analysis.

---

### `find`

Search files and directories.

Examples:

```bash
find . -name app.log
find . -type d
find . -size +500M
```

Used to locate logs, backups, and large files.

---

### `chmod`

Change permissions.

Permission values:

```text
r = 4
w = 2
x = 1
```

Example:

```bash
chmod 755 script.sh
```

Common permissions:

| Permission | Meaning                           |
| ---------- | --------------------------------- |
| 644        | Regular file                      |
| 755        | Executable                        |
| 600        | Private file                      |
| 700        | Private executable                |
| 777        | Full access (avoid in production) |

---

### `chown`

Change ownership.

```bash
chown user:group file
```

Example:

```bash
sudo chown ubuntu:ubuntu app.log
```

Used to fix permission issues.

---

### `du`

Display size of files/directories.

```bash
du -h
```

Most useful:

```bash
du -sh folder
```

Used to find large directories.

---

### `df`

Display filesystem disk usage.

```bash
df -h
```

Shows:

* Total Space
* Used Space
* Available Space
* Usage %

Used when disk space alerts occur.

---

# Networking Commands

### `ip a`

Display network interfaces and IP addresses.

```bash
ip a
```

Modern replacement for `ifconfig`.

---

### `ifconfig`

Older networking command.

```bash
ifconfig
```

May require:

```bash
sudo apt install net-tools
```

---

### `netstat`

Display network connections and listening ports.

```bash
netstat -a
```

Most useful:

```bash
netstat -tulpn
```

Shows:

* Ports
* Protocols
* PIDs
* Programs

Modern alternative:

```bash
ss -tulpn
```

---

### `traceroute`

Trace network path to a host.

```bash
traceroute google.com
```

Used to troubleshoot latency and routing issues.

---

### `wget`

Download files from the internet.

```bash
wget URL
```

Save with a different name:

```bash
wget -O backup.zip URL
```

---

### `whois`

Show domain registration details.

```bash
whois example.com
```

Displays:

* Registrar
* Expiry Date
* Name Servers

---

### `host`

Simple DNS lookup.

```bash
host google.com
```

Returns IP address of a domain.

---

### `nslookup`

DNS query tool.

```bash
nslookup google.com
```

Displays:

* DNS Server Used
* Domain IP Addresses

Used for DNS troubleshooting.

---

# Most Important Commands for DevOps

```bash
ps aux
top
kill
pgrep

pwd
find
grep
tail -f
chmod
chown

du -sh
df -h

ip a
ss -tulpn
nslookup
```

---

# Production Troubleshooting Flow

```bash
top                 # CPU/RAM issue
ps aux              # Find problematic process
tail -f app.log     # Monitor logs
grep ERROR app.log  # Search errors
df -h               # Check disk usage
du -sh *            # Find large directories
ss -tulpn           # Check listening ports
ip a                # Verify network config
nslookup domain     # Verify DNS
```

### Core Areas Covered

* Process Management
* File System Navigation
* Permissions & Ownership
* Disk Space Monitoring
* Log Analysis
* Network Troubleshooting
* DNS Debugging
* Production Server Troubleshooting

These commands form the foundation for Linux Administration, AWS, Docker, Kubernetes, Terraform, CI/CD, and DevOps engineering.
