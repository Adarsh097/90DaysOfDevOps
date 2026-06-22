# Core components of Linux :
- Hardware :
The physical component where OS is installed.
- Kernel :
The heart of Linux. The central core that directly controls hardware, processes, memory. Interface between hardware and software. Machine understands kernel language.
- Shell :
Interactive way to talk to kernel using commands.
- GUI :
Graphical user interface for visual interaction.
- System Libraries : 
Collections of pre-written functions that applications use to request services from the kernel.
- System Utilities : 
Programs and tools (like ls, cp, grep) that perform specific tasks, managing files, users, and system operations.

# Processes in Linux
Processes are instances of running programs. For ex. if you do pin ww.google.com then ping process is created.
You can list processes using ps(ps ax, ps ef) or top commands. 
## Process states
- running : Active process.
- sleeping : Idle process.
- Stopped : Process suspended by signal SIGSTOP (Ctrl+Z, Ctrl+C). It can be resumed by a SIGCONT signal.
- Zombie : The process has terminated, but its entry in the process table still exists because its parent process has not 
           yet read its exit status.
           
# 5 Commands used daily 
- ps or top : Provides process ID, memory usage, CPU time and command name which is crucial for monitoring system performance
              and troubleshooting.
- chmod : Changing permission of files.
- ssh : Provides secure shell connecting to remote server.
- systemctl : Managing system services (starting, stopping).
- df /du : df is used to monitor disk space usage and du is used to estimate size of a specific directory.


# Linux Core Components & Processes - DevOps Summary Notes

## Linux Architecture

```text
Applications
    ↓
System Utilities
    ↓
System Libraries
    ↓
Shell
    ↓
Kernel
    ↓
Hardware
```

---

# 1. Hardware

Physical components of a computer:

* CPU
* RAM
* HDD/SSD
* Network Card (NIC)
* GPU
* Keyboard/Mouse

Applications cannot directly access hardware. They must communicate through the Kernel.

---

# 2. Kernel (Heart of Linux)

The Kernel is loaded into memory during boot and remains active until shutdown.

### Responsibilities

#### Process Management

Creates and manages processes.

Example:

```bash
ping google.com
```

Creates a process with a unique PID.

---

#### Memory Management

* Allocates RAM to processes.
* Prevents processes from accessing each other's memory.
* Ensures process isolation and stability.

---

#### Device Management

Controls:

* Disk drives
* USB devices
* Printers
* Network cards

Example:

```bash
echo "hello" > file.txt
```

Kernel communicates with storage devices to save data.

---

#### File System Management

Linux treats everything as a file.

Examples:

```bash
/dev/sda
/dev/null
/etc/passwd
```

Kernel manages file access operations.

---

#### Network Management

Handles:

* TCP/IP stack
* Packet routing
* Socket communication

Example:

```bash
curl google.com
```

Kernel manages network communication.

---

### Why Kernel Matters in DevOps

Kernel manages:

* CPU usage
* Memory allocation
* Disk I/O
* Network traffic

Most production issues involve troubleshooting these resources.

---

# System Calls

Applications cannot directly communicate with the Kernel.

They use System Calls.

Common system calls:

```c
open()
read()
write()
close()
fork()
```

Flow:

```text
Application
    ↓
System Call
    ↓
Kernel
    ↓
Hardware
```

Example:

```bash
cat file.txt
```

Internally uses:

```c
open()
read()
close()
```

---

# 3. Shell

A command interpreter that acts as a bridge between the user and the Kernel.

Example:

```bash
ls
```

Shell:

1. Reads command
2. Finds executable
3. Creates process
4. Kernel executes process
5. Displays output

---

### Popular Shells

| Shell | Path                     |
| ----- | ------------------------ |
| Bash  | /bin/bash                |
| Zsh   | /bin/zsh                 |
| Sh    | /bin/sh                  |
| Fish  | Modern interactive shell |

---

Example:

```bash
mkdir demo
```

Flow:

```text
User → Shell → Kernel → Disk
```

---

# 4. GUI (Graphical User Interface)

Provides visual interaction with Linux.

Examples:

* GNOME
* KDE
* Ubuntu Desktop

Instead of:

```bash
cp file1 file2
```

you can drag and drop files.

---

### Why DevOps Engineers Prefer CLI

Production servers usually run:

* Ubuntu Server
* RHEL
* Amazon Linux
* CentOS

without GUI because:

* Lower memory usage
* Better performance
* Improved security
* Easier automation

Remote access is mostly through:

```bash
ssh
```

---

# 5. System Libraries

Reusable code libraries used by applications.

Benefits:

* Avoid writing common functionality repeatedly.
* Provide APIs to communicate with the Kernel.

---

### Common Libraries

#### glibc

Provides:

```c
printf()
malloc()
fopen()
```

---

#### OpenSSL

Provides:

* Encryption
* SSL/TLS support
* Secure communication

Widely used in DevOps and web applications.

---

# 6. System Utilities

Command-line tools used for system administration.

Examples:

```bash
ls
cp
mv
grep
find
tar
awk
sed
```

Example:

```bash
which ls
```

Output:

```bash
/bin/ls
```

Shell executes these utilities as programs.

---

# Processes in Linux

### Program vs Process

Program:

```text
Code stored on disk
```

Process:

```text
Program currently executing in memory
```

Example:

Program:

```bash
ping
```

Process:

```bash
ping google.com
```

Kernel assigns a unique:

```text
PID (Process ID)
```

---

# Process Lifecycle

```text
New
 ↓
Ready
 ↓
Running
 ↓
Waiting
 ↓
Terminated
```

---

# Viewing Processes

```bash
ps aux
ps -ef
top
```

---

# Process States

## Running (R)

Currently executing on CPU.

Example:

```bash
python cpu_intensive.py
```

---

## Sleeping (S)

Waiting for an event.

Most Linux processes remain in this state.

Example:

```text
nginx waiting for HTTP requests
```

---

## Uninterruptible Sleep (D)

Waiting for disk or storage I/O.

Common causes:

* Disk failures
* NFS issues
* Storage bottlenecks

Important for production troubleshooting.

---

## Stopped (T)

Process is paused.

Pause:

```bash
Ctrl + Z
```

Signal sent:

```bash
SIGTSTP
```

Resume:

```bash
fg
```

or

```bash
kill -CONT PID
```

---

### Important Signal Correction

❌ Incorrect:

```text
Ctrl + C → SIGSTOP
```

✅ Correct:

```text
Ctrl + C → SIGINT
```

Usually terminates the process.

---

# Common Linux Signals

| Signal  | Purpose              |
| ------- | -------------------- |
| SIGINT  | Interrupt process    |
| SIGTERM | Graceful termination |
| SIGKILL | Force kill           |
| SIGSTOP | Pause process        |
| SIGCONT | Resume process       |

---

# Zombie Process (Z)

Occurs when:

1. Child process terminates.
2. Parent process has not yet collected its exit status.

Kernel keeps:

* PID
* Exit status

in the process table.

---

### Detect Zombies

```bash
ps aux | grep Z
```

State:

```text
Z
```

---

### Why Zombies Matter

Large numbers of zombie processes can:

* Fill the process table.
* Prevent creation of new processes.

Common DevOps interview topic.

---

# Daily DevOps Commands

## 1. ps

Displays process information.

```bash
ps aux
```

Shows:

* PID
* CPU usage
* Memory usage
* Command

---

### ps -ef

Shows process hierarchy and parent-child relationships.

Useful for troubleshooting.

---

## 2. top

Real-time system monitoring.

```bash
top
```

Shows:

* CPU usage
* Memory usage
* Running processes

Alternative:

```bash
htop
```

---

## 3. chmod

Changes file permissions.

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

Meaning:

```text
Owner  → rwx
Group  → r-x
Others → r-x
```

---

## 4. ssh

Secure remote server access.

```bash
ssh user@server-ip
```

Used for:

* Server administration
* Deployments
* Troubleshooting

### SSH Key Authentication

Generate keys:

```bash
ssh-keygen
```

Copy key:

```bash
ssh-copy-id user@server
```

Connect:

```bash
ssh user@server
```

More secure than password authentication.

---

## 5. systemctl

Manages services through systemd.

Check status:

```bash
systemctl status nginx
```

Start:

```bash
systemctl start nginx
```

Stop:

```bash
systemctl stop nginx
```

Restart:

```bash
systemctl restart nginx
```

Enable at boot:

```bash
systemctl enable nginx
```

---

## 6. Disk Usage Commands

### df

Shows filesystem usage.

```bash
df -h
```

Displays:

* Total size
* Used space
* Available space
* Usage percentage

---

### du

Shows directory/file size.

```bash
du -sh /var/log
```

Used to identify storage-consuming directories.

---

# Production Server Health Check Commands

When investigating an incident:

```bash
ssh server
```

Run:

```bash
uptime          # Load average
top             # CPU and memory
free -h         # RAM usage
df -h           # Disk usage
du -sh *        # Large directories
ps -ef          # Running processes
systemctl status service
journalctl -xe  # System logs
```

---

# Key DevOps Takeaway

Before learning:

* Docker
* Kubernetes
* AWS
* Terraform
* CI/CD

You must master:

1. Linux Architecture
2. Kernel Fundamentals
3. System Calls
4. Shell Operations
5. Processes & Signals
6. Service Management
7. File Permissions
8. Resource Monitoring
9. Disk Management
10. Troubleshooting Basics

**Nearly every production issue ultimately traces back to CPU, Memory, Disk, Network, Processes, or Services—all of which are managed by Linux.**
