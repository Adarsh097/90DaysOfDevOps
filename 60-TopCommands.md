# 🐧 Linux Commands — Practical Reference Guide

> A hands-on reference for 60+ essential Linux commands with real-world use cases, syntax, and examples.

---

## Table of Contents

1. [Remote Access](#1-remote-access)
2. [Navigation & File System](#2-navigation--file-system)
3. [File Operations](#3-file-operations)
4. [Text Editors](#4-text-editors)
5. [File Viewing & Manipulation](#5-file-viewing--manipulation)
6. [User Management](#6-user-management)
7. [Permissions & Ownership](#7-permissions--ownership)
8. [Package Management](#8-package-management)
9. [Networking](#9-networking)
10. [System Information & Monitoring](#10-system-information--monitoring)
11. [Process Management](#11-process-management)
12. [Services & System Control](#12-services--system-control)
13. [Miscellaneous Utilities](#13-miscellaneous-utilities)

---

## 1. Remote Access

### `ssh` — Secure Shell

Connect securely to a remote machine over a network.

```bash
ssh username@192.168.1.10          # Connect by IP
ssh username@example.com           # Connect by hostname
ssh -p 2222 username@example.com   # Connect on custom port
ssh -i ~/.ssh/mykey.pem ec2-user@3.14.159.26  # Connect using a private key (AWS EC2 style)
```

**Real-world use case:** You've deployed a web server on a cloud VM (e.g., AWS/GCP). You use `ssh` to log in and manage it — install packages, check logs, restart services — all from your laptop terminal.

---

## 2. Navigation & File System

### `pwd` — Print Working Directory

Shows your current location in the file system.

```bash
pwd
# Output: /home/adarsh/projects
```

**Use case:** When you're deep inside nested directories and forget where you are.

---

### `ls` — List Directory Contents

```bash
ls                  # Basic listing
ls -l               # Long format (permissions, size, date)
ls -la              # Include hidden files (dotfiles)
ls -lh              # Human-readable file sizes
ls /var/log         # List a specific directory
```

**Use case:** After SSH-ing into a server, run `ls -la` to see all files including hidden configs like `.bashrc` or `.env`.

---

### `cd` — Change Directory

```bash
cd /var/www/html    # Go to absolute path
cd ..               # Go up one level
cd ~                # Go to home directory
cd -                # Go back to previous directory
```

**Use case:** Navigate between your project folder, config directory, and log folder during debugging.

---

## 3. File Operations

### `touch` — Create Empty File / Update Timestamp

```bash
touch notes.txt             # Create a new empty file
touch file1.txt file2.txt   # Create multiple files at once
touch -t 202401011200 old.txt  # Set a specific timestamp
```

**Use case:** Quickly create placeholder files, or trigger a rebuild in Make-based systems by updating a file's timestamp.

---

### `echo` — Print Text / Write to File

```bash
echo "Hello, World!"                # Print to terminal
echo "PORT=3000" > .env             # Write to file (overwrites)
echo "DB_HOST=localhost" >> .env    # Append to file
echo $HOME                          # Print environment variable
```

**Use case:** Quickly add environment variables to a `.env` file without opening an editor.

---

### `mkdir` — Make Directory

```bash
mkdir myproject                     # Create a single directory
mkdir -p projects/web/frontend      # Create nested directories at once
mkdir -m 755 public_html            # Create with specific permissions
```

**Use case:** Setting up a project structure — `mkdir -p src/components src/utils tests` creates all folders in one shot.

---

### `cp` — Copy Files and Directories

```bash
cp file.txt backup.txt              # Copy a file
cp -r myfolder/ backup_folder/     # Copy an entire directory
cp -p config.yml /etc/app/         # Preserve permissions and timestamps
```

**Use case:** Before editing a critical config file, back it up: `cp nginx.conf nginx.conf.bak`.

---

### `rm` — Remove Files and Directories

```bash
rm file.txt                 # Delete a file
rm -r old_project/          # Delete a directory recursively
rm -rf build/               # Force delete without prompts (⚠️ use carefully)
rm -i *.log                 # Interactive mode — asks before each deletion
```

> ⚠️ **Warning:** `rm -rf` is irreversible. Always double-check before running.

---

### `rmdir` — Remove Empty Directory

```bash
rmdir empty_folder          # Removes only if folder is empty
rmdir -p a/b/c              # Remove nested empty directories
```

**Use case:** Clean up empty scaffold directories after reorganizing a project.

---

### `ln` — Create Links

```bash
ln -s /usr/local/bin/python3 /usr/bin/python   # Symbolic (soft) link
ln original.txt hardlink.txt                    # Hard link
```

**Use case:** Create a symlink so typing `python` runs `python3`. Widely used for version management and config aliasing.

---

### `shred` — Securely Delete Files

```bash
shred -u secret.txt             # Overwrite and delete
shred -n 5 -u sensitive.csv     # Overwrite 5 times, then delete
```

**Use case:** When deleting files containing passwords or private keys that should not be recoverable via disk recovery tools.

---

### `find` — Search for Files

```bash
find . -name "*.log"                        # Find all .log files
find /var -type f -mtime -1                 # Files modified in last 24 hours
find . -size +100M                          # Files larger than 100MB
find /home -user adarsh -name "*.py"       # Python files owned by adarsh
```

**Use case:** Find all leftover `.tmp` files across a project to clean them up: `find . -name "*.tmp" -delete`.

---

## 4. Text Editors

### `nano` — Beginner-Friendly Terminal Editor

```bash
nano config.txt         # Open or create a file
```

| Shortcut | Action |
|----------|--------|
| `Ctrl+O` | Save (Write Out) |
| `Ctrl+X` | Exit |
| `Ctrl+K` | Cut line |
| `Ctrl+U` | Paste line |

**Use case:** Quick edits to config files on a server when you don't want to deal with vim's modal interface.

---

### `vim` — Powerful Modal Text Editor

```bash
vim server.js           # Open a file
```

| Mode/Key | Action |
|----------|--------|
| `i` | Enter Insert mode |
| `Esc` | Return to Normal mode |
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving |
| `dd` | Delete line |
| `/word` | Search for "word" |

**Use case:** Edit files on remote servers where no GUI is available. Once learned, it's far faster than nano for complex edits.

---

## 5. File Viewing & Manipulation

### `cat` — Concatenate & Display File Contents

```bash
cat file.txt                    # Display entire file
cat file1.txt file2.txt         # Concatenate two files
cat > newfile.txt               # Type content and save (Ctrl+D to finish)
cat -n file.txt                 # Show line numbers
```

**Use case:** Quick inspection of log files, config files, or scripts without opening an editor.

---

### `less` — Paginated File Viewer

```bash
less /var/log/syslog
```

| Key | Action |
|-----|--------|
| `Space` | Next page |
| `b` | Previous page |
| `/pattern` | Search forward |
| `q` | Quit |

**Use case:** Viewing large log files without loading the whole thing into memory (unlike `cat`).

---

### `head` — View Top of File

```bash
head file.txt           # First 10 lines (default)
head -n 20 file.txt     # First 20 lines
head -c 100 file.txt    # First 100 bytes
```

**Use case:** Quickly check the column headers of a large CSV file before processing it.

---

### `tail` — View End of File

```bash
tail file.txt               # Last 10 lines
tail -n 50 error.log        # Last 50 lines
tail -f /var/log/nginx/access.log   # Live-follow log in real time
```

**Use case:** `tail -f` is invaluable for monitoring a running application's logs in real time during debugging.

---

### `cmp` — Compare Two Files Byte-by-Byte

```bash
cmp file1.txt file2.txt
# Output: file1.txt file2.txt differ: byte 42, line 3
```

**Use case:** Verify that a backup file is identical to the original (especially for binaries).

---

### `diff` — Show Line-by-Line Differences

```bash
diff original.txt updated.txt
diff -u v1.conf v2.conf         # Unified format (easier to read)
diff -r dir1/ dir2/             # Compare two directories
```

**Use case:** Review what changed between two versions of a config file before applying updates to production.

---

### `sort` — Sort File Contents

```bash
sort names.txt                  # Alphabetical sort
sort -r scores.txt              # Reverse order
sort -n numbers.txt             # Numeric sort
sort -u names.txt               # Sort and remove duplicates
sort -k2 data.csv               # Sort by 2nd column
```

**Use case:** Sort a list of IP addresses, usernames, or log entries for easier analysis.

---

### `grep` — Search Text with Patterns

```bash
grep "error" app.log                    # Search for "error"
grep -i "warning" app.log              # Case-insensitive
grep -r "TODO" ./src                   # Recursive search in directory
grep -n "def main" script.py           # Show line numbers
grep -v "DEBUG" app.log                # Exclude lines matching pattern
grep -E "fail|error|critical" app.log  # Multiple patterns (extended regex)
```

**Use case:** `grep -r "API_KEY" .` to check if any API keys were accidentally hardcoded in source files.

---

### `awk` — Text Processing & Column Extraction

```bash
awk '{print $1}' file.txt               # Print first column
awk -F',' '{print $2}' data.csv         # CSV: print second column
awk '{sum += $1} END {print sum}' nums.txt   # Sum all numbers in a column
awk '/error/ {print $0}' app.log        # Print lines containing "error"
ps aux | awk '{print $1, $11}'          # Print user and process name
```

**Use case:** Extract specific columns from server logs or CSV reports without writing a full script.

---

### `curl` — Transfer Data from/to URLs

```bash
curl https://api.github.com             # GET request
curl -o file.zip https://example.com/download.zip   # Download file
curl -X POST -H "Content-Type: application/json" \
  -d '{"name":"adarsh"}' https://api.example.com/users  # POST request
curl -I https://example.com            # Fetch only HTTP headers
```

**Use case:** Test REST APIs directly from the terminal, download files from URLs, or check if a server is responding.

---

### `zip` / `unzip` — Compress & Extract Archives

```bash
zip archive.zip file1.txt file2.txt     # Zip files
zip -r project.zip ./project/           # Zip entire directory
unzip archive.zip                       # Extract to current directory
unzip archive.zip -d /tmp/extracted/    # Extract to specific path
unzip -l archive.zip                    # List contents without extracting
```

**Use case:** Package a project for sharing, or extract downloaded software archives.

---

## 6. User Management

### `whoami` — Show Current User

```bash
whoami
# Output: adarsh
```

**Use case:** Confirm your identity after switching users with `su` or on a shared server.

---

### `useradd` — Add User (Low-Level)

```bash
sudo useradd john                          # Create user (no home dir by default)
sudo useradd -m -s /bin/bash john         # With home directory and shell
sudo useradd -m -G sudo,developers john   # Add to groups
```

**Use case:** Quickly create a system/service account (e.g., for running a web app under a dedicated user).

---

### `adduser` — Add User (Interactive, High-Level)

```bash
sudo adduser john       # Interactive prompts for password, info, etc.
```

**Use case:** Preferred for creating human user accounts as it sets up home directory, prompts for password, and is more user-friendly than `useradd`.

---

### `passwd` — Change Password

```bash
passwd                      # Change your own password
sudo passwd john            # Change another user's password
sudo passwd -l john         # Lock an account
sudo passwd -u john         # Unlock an account
```

**Use case:** Force a new employee to change their initial password, or lock a departed employee's account.

---

### `su` — Switch User

```bash
su john                     # Switch to user john (needs john's password)
su -                        # Switch to root with root's environment
su - john                   # Switch to john with their full environment
```

**Use case:** Test something as a different user without logging out, or switch to root for system-level tasks.

---

### `sudo` — Execute as Superuser

```bash
sudo apt update                         # Run with root privileges
sudo -u www-data command                # Run as a specific user
sudo !!                                 # Re-run last command with sudo
sudo -l                                 # List what sudo you're allowed to run
```

**Use case:** Install packages, edit system configs, or restart services — tasks that require root access.

---

### `exit` — Exit Shell / Session

```bash
exit            # Exit current shell session or SSH connection
exit 0          # Exit with code 0 (success)
exit 1          # Exit with code 1 (error — used in scripts)
```

**Use case:** Exit from an SSH session, a `su` shell, or signal success/failure from a shell script.

---

## 7. Permissions & Ownership

### `chmod` — Change File Permissions

```bash
chmod 755 script.sh             # rwxr-xr-x (owner: full, others: read+execute)
chmod 644 config.yml            # rw-r--r-- (owner: read+write, others: read)
chmod +x deploy.sh              # Add execute permission for all
chmod -R 755 public/            # Recursively change directory permissions
```

**Permission Reference:**

| Number | Permission |
|--------|------------|
| 7 | rwx (read + write + execute) |
| 6 | rw- (read + write) |
| 5 | r-x (read + execute) |
| 4 | r-- (read only) |
| 0 | --- (no permission) |

**Use case:** Make a deploy script executable: `chmod +x deploy.sh`, then run it with `./deploy.sh`.

---

### `chown` — Change File Owner

```bash
chown adarsh file.txt                  # Change owner
chown adarsh:developers file.txt       # Change owner and group
chown -R www-data:www-data /var/www/   # Recursively change for web server
```

**Use case:** After creating a web root as root, transfer ownership to `www-data` so the web server process can access it.

---

## 8. Package Management

### `apt` — Advanced Package Tool (Debian/Ubuntu)

```bash
sudo apt update                         # Refresh package list from repos
sudo apt upgrade                        # Upgrade all installed packages
sudo apt install nginx                  # Install a package
sudo apt remove firefox                 # Remove a package
sudo apt autoremove                     # Remove unused dependencies
sudo apt search python                  # Search for packages
apt list --installed                    # List installed packages
```

**Use case:** Setting up a fresh Ubuntu server — `sudo apt update && sudo apt install -y nginx git python3-pip` installs everything in one go.

---

### `finger` — Display User Info

```bash
finger                      # Info about all logged-in users
finger adarsh               # Info about a specific user
```

**Use case:** On a shared server, see who else is logged in and when they last used the system.

---

### `man` — Manual Pages

```bash
man ls                  # Manual for ls command
man -k network          # Search manuals by keyword
man 5 passwd            # Section 5 of passwd manual (file formats)
```

**Use case:** The most reliable source for command documentation. `man curl` shows every option available — far more complete than `--help`.

---

### `whatis` — One-Line Command Description

```bash
whatis ls
# Output: ls (1) - list directory contents

whatis grep awk sed
```

**Use case:** When you see an unfamiliar command in a script, run `whatis <command>` for a quick one-liner before diving into `man`.

---

## 9. Networking

### `ifconfig` — Interface Configuration (Legacy)

```bash
ifconfig                    # Show all network interfaces
ifconfig eth0               # Show specific interface
```

> ℹ️ Replaced by `ip` on modern systems. May require: `sudo apt install net-tools`

---

### `ip address` — Show/Manage Network Interfaces

```bash
ip address                  # List all interfaces and IPs
ip addr show eth0           # Specific interface
ip route                    # Show routing table
ip link set eth0 up         # Bring interface up
```

**Use case:** Find your server's IP address to configure DNS or firewall rules.

---

### `resolvectl status` — DNS Resolver Status

```bash
resolvectl status           # Show DNS servers, domains per interface
resolvectl query google.com # Resolve a domain via system DNS
```

**Use case:** Debug DNS issues — verify which DNS server your system is using and whether resolution works.

---

### `ping` — Test Network Connectivity

```bash
ping google.com             # Continuous ping
ping -c 4 8.8.8.8           # Send exactly 4 packets
ping -i 2 example.com       # Ping every 2 seconds
```

**Use case:** Basic first step in network debugging — is the host reachable? Is there packet loss?

---

### `netstat` — Network Statistics (Legacy)

```bash
netstat -tuln               # List listening TCP/UDP ports
netstat -anp                # All connections with PIDs
netstat -r                  # Routing table
```

> ℹ️ Replaced by `ss` on modern Linux. Requires: `sudo apt install net-tools`

---

### `ss` — Socket Statistics (Modern `netstat`)

```bash
ss -tuln                    # Listening ports (TCP/UDP)
ss -tnp                     # TCP connections with PIDs
ss -s                       # Summary statistics
```

**Use case:** Check if your web server is actually listening on port 80/443 before debugging further: `ss -tuln | grep :80`.

---

### `iptables` — Firewall Rules (Low-Level)

```bash
sudo iptables -L                            # List all rules
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT   # Allow SSH
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT   # Allow HTTP
sudo iptables -A INPUT -j DROP              # Drop all other traffic
sudo iptables-save > /etc/iptables/rules.v4 # Save rules
```

**Use case:** Fine-grained control over which traffic is allowed. Used extensively in server hardening and network security setups.

---

### `ufw` — Uncomplicated Firewall (Frontend for iptables)

```bash
sudo ufw enable                     # Enable firewall
sudo ufw status                     # Check status
sudo ufw allow 22                   # Allow SSH
sudo ufw allow 80/tcp               # Allow HTTP
sudo ufw deny 3306                  # Block MySQL from external access
sudo ufw allow from 192.168.1.0/24  # Allow a subnet
```

**Use case:** Easier firewall management for most server scenarios. After deploying a web app: allow 80, 443, and 22; deny everything else.

---

## 10. System Information & Monitoring

### `uname` — System Information

```bash
uname -a            # All info (kernel, hostname, architecture)
uname -r            # Kernel version only
uname -m            # Machine hardware (x86_64, arm64)
```

**Use case:** Verify the kernel version before installing a kernel-specific driver or module.

---

### `neofetch` — Fancy System Info Display

```bash
neofetch             # Display system info with ASCII art logo
```

**Use case:** Quick visual overview of OS, kernel, CPU, RAM, and uptime — popular for screenshots and documentation.

---

### `cal` — Calendar

```bash
cal                     # Current month
cal 2025                # Entire year
cal 3 2025              # March 2025
```

**Use case:** Quickly check a date or plan around weekends without leaving the terminal.

---

### `free` — Memory Usage

```bash
free -h                 # Human-readable (MB/GB)
free -s 5               # Update every 5 seconds
```

**Use case:** Check if a server is running low on RAM before deploying a memory-intensive service.

---

### `df` — Disk Space Usage

```bash
df -h                   # Human-readable disk usage
df -h /                 # Specific filesystem
df -T                   # Include filesystem type
```

**Use case:** Check if the disk is full when a service fails to write logs or uploads.

---

### `ps` — Process Status

```bash
ps aux                              # All running processes
ps aux | grep nginx                 # Find nginx processes
ps -ef --forest                     # Tree view of process hierarchy
```

**Use case:** Find which process is consuming CPU/memory, or check if a service is actually running.

---

### `top` — Real-Time Process Monitor

```bash
top                     # Interactive process viewer
top -u adarsh           # Processes for a specific user
```

| Key | Action |
|-----|--------|
| `k` | Kill a process |
| `r` | Renice (change priority) |
| `q` | Quit |
| `M` | Sort by memory |
| `P` | Sort by CPU |

---

### `htop` — Enhanced Process Monitor

```bash
htop                    # Colorful, interactive top replacement
```

**Use case:** More visual and interactive than `top`. Use F9 to kill processes, F5 for tree view. Ideal for real-time monitoring on servers.

---

## 11. Process Management

### `kill` — Terminate Process by PID

```bash
kill 1234               # Send SIGTERM (graceful shutdown)
kill -9 1234            # Send SIGKILL (force kill)
kill -l                 # List all signal names
```

**Use case:** A web server process is hung. Get its PID with `ps aux | grep apache`, then `kill -9 <PID>`.

---

### `pkill` — Kill Processes by Name

```bash
pkill nginx             # Kill all processes named "nginx"
pkill -9 firefox        # Force kill
pkill -u adarsh         # Kill all processes by user
```

**Use case:** Restart a crashed service: `pkill -9 node && node server.js` — no need to look up the PID manually.

---

## 12. Services & System Control

### `systemctl` — Service & System Manager

```bash
sudo systemctl start nginx          # Start a service
sudo systemctl stop nginx           # Stop a service
sudo systemctl restart nginx        # Restart
sudo systemctl reload nginx         # Reload config (no downtime)
sudo systemctl status nginx         # Check service status
sudo systemctl enable nginx         # Auto-start on boot
sudo systemctl disable nginx        # Disable auto-start
systemctl list-units --type=service # List all services
```

**Use case:** After editing `nginx.conf`, run `sudo systemctl reload nginx` to apply changes without dropping active connections.

---

### `reboot` — Restart the System

```bash
sudo reboot                         # Reboot immediately
sudo reboot --force                 # Force reboot (skips graceful shutdown)
```

**Use case:** After a kernel update or major config change that requires a fresh start.

---

### `shutdown` — Power Off or Schedule Shutdown

```bash
sudo shutdown now               # Immediate shutdown
sudo shutdown -h +10            # Shutdown in 10 minutes
sudo shutdown -r 02:00          # Reboot at 2:00 AM
sudo shutdown -c                # Cancel a scheduled shutdown
```

**Use case:** Schedule maintenance downtime on a server: `sudo shutdown -r +30 "Rebooting for kernel update"` — sends a broadcast to all logged-in users.

---

## 13. Miscellaneous Utilities

### `clear` — Clear Terminal Screen

```bash
clear           # Clear the visible terminal
# Shortcut: Ctrl + L
```

**Use case:** Clean up a cluttered terminal before sharing your screen or starting a new task.

---

### `history` — Command History

```bash
history                 # Show all previous commands
history 20              # Show last 20 commands
history | grep ssh      # Search history for ssh commands
!42                     # Re-run command number 42
!!                      # Re-run the last command
Ctrl+R                  # Interactive reverse search through history
```

**Use case:** Forgot the exact `ffmpeg` command you ran last week? `history | grep ffmpeg` finds it instantly.

---

## Quick Reference Cheat Sheet

| Category | Key Commands |
|----------|-------------|
| **Navigation** | `pwd`, `ls`, `cd` |
| **File Ops** | `touch`, `cp`, `mv`, `rm`, `mkdir`, `find` |
| **Viewing** | `cat`, `less`, `head`, `tail`, `grep`, `awk` |
| **Editors** | `nano`, `vim`, `echo` |
| **Users** | `whoami`, `useradd`, `adduser`, `passwd`, `su`, `sudo` |
| **Permissions** | `chmod`, `chown` |
| **Packages** | `apt update/install/remove` |
| **Network** | `ping`, `ip addr`, `ss`, `curl`, `ufw` |
| **System Info** | `uname`, `free`, `df`, `neofetch` |
| **Processes** | `ps`, `top`, `htop`, `kill`, `pkill` |
| **Services** | `systemctl start/stop/status/enable` |
| **Archive** | `zip`, `unzip` |
| **Shutdown** | `reboot`, `shutdown` |

---

## Common Workflows

### 🔧 Server Setup (Fresh Ubuntu VM)
```bash
ssh ubuntu@<server-ip>
sudo apt update && sudo apt upgrade -y
sudo adduser deploy
sudo usermod -aG sudo deploy
sudo ufw allow 22 && sudo ufw allow 80 && sudo ufw enable
sudo apt install nginx
sudo systemctl enable nginx
```

### 🐛 Debugging a Crashed Service
```bash
sudo systemctl status myapp         # Check status
sudo journalctl -u myapp -n 50      # Last 50 log lines
ps aux | grep myapp                 # Find process
sudo systemctl restart myapp        # Restart
tail -f /var/log/myapp/error.log    # Watch logs live
```

### 🔍 Finding a File & Inspecting It
```bash
find / -name "nginx.conf" 2>/dev/null
cat /etc/nginx/nginx.conf
grep "server_name" /etc/nginx/nginx.conf
diff /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
```

### 🧹 Cleaning Up Disk Space
```bash
df -h                               # Check disk usage
du -sh /var/log/*                   # Find large log directories
sudo find /var/log -name "*.gz" -delete   # Delete compressed logs
sudo apt autoremove                 # Remove unused packages
```

---

*Generated as a practical reference guide for Linux command-line usage.*
