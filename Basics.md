# 🐧 Linux — Core Concepts Explained

> A structured breakdown of how Linux works under the hood — from the kernel to containers, filesystems to firewalls.

---

## Table of Contents

1. [The Kernel & Shell](#1-the-kernel--shell)
2. [File System Hierarchy](#2-file-system-hierarchy)
3. [Users, Permissions & Access](#3-users-permissions--access)
4. [Processes & Signals](#4-processes--signals)
5. [Init System & Services](#5-init-system--services)
6. [Package Management](#6-package-management)
7. [Shell Scripting & Automation](#7-shell-scripting--automation)
8. [Input, Output & Pipes](#8-input-output--pipes)
9. [Links — Symbolic & Hard](#9-links--symbolic--hard)
10. [Storage, Mounting & Swap](#10-storage-mounting--swap)
11. [Networking](#11-networking)
12. [Security](#12-security)
13. [System Monitoring & Logs](#13-system-monitoring--logs)
14. [File Systems & Disk Management](#14-file-systems--disk-management)
15. [Virtualization & Containers](#15-virtualization--containers)
16. [Desktop & Display](#16-desktop--display)
17. [Advanced Shell Concepts](#17-advanced-shell-concepts)
18. [Special Virtual Filesystems](#18-special-virtual-filesystems)
19. [Boot Process](#19-boot-process)
20. [Linux Distributions](#20-linux-distributions)

---

## 1. The Kernel & Shell

### What is Linux, Really?

Linux is **not an operating system** — it is a **kernel**: the core program that sits between hardware and software.

```
[ User Programs ]
      ↓
[ Shell / Terminal ]
      ↓
[ Linux Kernel ]         ← manages CPU, memory, hardware
      ↓
[ Hardware ]
```

### Kernel Responsibilities

- Managing **hardware** (CPU, RAM, I/O devices)
- Managing **memory** allocation and deallocation
- Creating and scheduling **processes**
- Enabling communication between software and hardware via **kernel modules** — loadable pieces of code that add features like hardware drivers without rebooting

### Shell

The **shell** is the command-line interface you use to talk to the kernel. Common shells:

| Shell | Notes |
|-------|-------|
| `bash` | Default on most Linux distros |
| `zsh` | Extended bash with plugins/themes |
| `sh` | POSIX-compliant minimal shell |
| `fish` | User-friendly, modern shell |

### Terminal

A **terminal** is the program (window) that hosts the shell. It gives you a text interface to type and run commands. Examples: GNOME Terminal, Alacritty, tmux.

---

## 2. File System Hierarchy

Linux organizes all files in a **single tree** rooted at `/` (root). Everything — programs, hardware, processes — is a file.

```
/
├── bin/        → Essential user binaries (ls, cp, bash)
├── sbin/       → System binaries (fsck, reboot)
├── etc/        → Configuration files
├── home/       → User home directories
├── var/        → Variable data (logs, databases)
│   └── log/   → System and application logs
├── tmp/        → Temporary files (cleared on reboot)
├── usr/        → User programs and libraries
├── lib/        → Shared libraries
├── dev/        → Device files (disks, USBs, sound cards)
├── proc/       → Virtual FS: real-time process/kernel info
├── sys/        → Virtual FS: kernel and hardware info
├── mnt/        → Mount points for temporary mounts
└── media/      → Auto-mount point for removable media
```

> **Key principle:** In Linux, *everything is a file* — hardware devices, processes, network sockets, and directories are all represented as files.

---

## 3. Users, Permissions & Access

### User Types

| User | Description |
|------|-------------|
| **root** | Superuser — unlimited access to the entire system |
| **regular user** | Restricted access — can only affect their own files |
| **service user** | Accounts created for running daemons (e.g., `www-data`) |

### File Permissions

Every file has three permission sets: **Owner**, **Group**, and **Others**.

```
-rwxr-xr--
 │││└─┴─┴── Others: r-- (read only)
 ││└─┴─┴──  Group:  r-x (read + execute)
 │└─┴─┴──   Owner:  rwx (read + write + execute)
 └── File type: - = file, d = directory, l = symlink
```

| Symbol | Meaning |
|--------|---------|
| `r` | Read |
| `w` | Write |
| `x` | Execute |
| `-` | Permission not granted |

### `sudo` — Controlled Superuser Access

Rather than logging in as root, Linux uses **sudo** (superuser do) to let authorized normal users run privileged commands. It logs who ran what and when — a critical security audit trail.

### PAM — Pluggable Authentication Modules

Linux uses **PAM** to manage *how* users authenticate — controlling logins, credential checks, and session policies in a modular, configurable way.

---

## 4. Processes & Signals

### What is a Process?

When you run a program, Linux creates a **process** — an instance of that program in execution. Each process gets a unique **PID** (Process ID).

```
[ You run: firefox ]
        ↓
[ Kernel forks a new process ]
        ↓
[ Assigns it a PID, e.g. 4521 ]
        ↓
[ Allocates memory, CPU time ]
```

### File Descriptors

Every process tracks open files and network sockets using **file descriptors** — integer IDs assigned by the kernel:

| FD | Stream |
|----|--------|
| `0` | stdin (standard input) |
| `1` | stdout (standard output) |
| `2` | stderr (standard error) |

### Signals — Controlling Processes

Signals are messages sent to a process to control its behavior:

| Signal | Number | Meaning |
|--------|--------|---------|
| `SIGTERM` | 15 | Politely ask process to stop (graceful) |
| `SIGKILL` | 9 | Force kill immediately (no cleanup) |
| `SIGHUP` | 1 | Reload configuration |
| `SIGSTOP` | 19 | Pause (freeze) the process |
| `SIGCONT` | 18 | Resume a paused process |

---

## 5. Init System & Services

### systemd — The First Process

When the kernel boots, the very first process it starts is the **init system**. On modern Linux, this is **systemd** (PID 1). It is responsible for:

- Launching all other services and processes
- Managing service dependencies
- Defining the system's boot target (run level)

### Run Levels / Targets

Linux can boot into different **targets** (formerly called run levels):

| Target | Description |
|--------|-------------|
| `rescue.target` | Single-user mode (maintenance) |
| `multi-user.target` | Multi-user, no GUI (typical server mode) |
| `graphical.target` | Multi-user with desktop environment |
| `reboot.target` | System reboot |
| `poweroff.target` | System shutdown |

### Daemons — Background Services

**Daemons** are background processes that run without direct user interaction. They typically end in `d`:

| Daemon | Role |
|--------|------|
| `sshd` | Listens for incoming SSH connections |
| `crond` | Runs scheduled cron jobs |
| `nginx` | Serves web pages |
| `systemd-journald` | Collects and stores logs |

### Scheduled Tasks — Cron Jobs

**Cron** allows commands to run automatically at scheduled times. Cron expressions follow the format:

```
* * * * * command
│ │ │ │ └── Day of week (0-7)
│ │ │ └──── Month (1-12)
│ │ └────── Day of month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)
```

Example — run a backup every day at 2 AM:
```bash
0 2 * * * /usr/bin/backup.sh
```

---

## 6. Package Management

### What is a Package Manager?

A **package manager** automates the installation, update, and removal of software. It fetches programs from **package repositories** (curated servers) and handles dependencies automatically.

| Package Manager | Distribution |
|----------------|--------------|
| `apt` | Debian, Ubuntu, and derivatives |
| `dnf` / `yum` | Fedora, Red Hat, CentOS |
| `pacman` | Arch Linux |
| `zypper` | openSUSE |

### Package Formats

| Format | Used by |
|--------|---------|
| `.deb` | Debian / Ubuntu |
| `.rpm` | Fedora / Red Hat |
| Flatpak / Snap / AppImage | Cross-distro universal formats |

> **Flatpak, Snap, and AppImage** bundle an application with all its dependencies, making it runnable on virtually any Linux distro without compatibility issues.

### Kernel Headers

Some software (like hardware drivers) must be compiled against the **kernel headers** — source-level interface files that describe the kernel's internal structures. These are installed as a separate package.

---

## 7. Shell Scripting & Automation

### Shell Scripts

A **shell script** is a plain text file containing a sequence of shell commands, executed top-to-bottom. Scripts make repetitive tasks repeatable and automated.

```bash
#!/bin/bash
# Simple deployment script

echo "Pulling latest code..."
git pull origin main

echo "Restarting service..."
sudo systemctl restart myapp

echo "Done!"
```

The first line `#!/bin/bash` is called the **shebang** — it tells the OS which interpreter to use.

### Environment Variables

**Environment variables** are named values that configure the system and shell behavior. They are inherited by child processes.

| Variable | Purpose |
|----------|---------|
| `$PATH` | Directories to search for executables |
| `$HOME` | Current user's home directory |
| `$USER` | Current logged-in username |
| `$SHELL` | Path to the current shell |

```bash
echo $PATH
# /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
```

### Aliases & Functions

**Aliases** create shortcuts for long commands:
```bash
alias ll='ls -la'
alias update='sudo apt update && sudo apt upgrade -y'
```

**Bash functions** define reusable blocks of commands:
```bash
mkcd() {
    mkdir -p "$1" && cd "$1"
}
```

---

## 8. Input, Output & Pipes

### Standard Streams

Every Linux process has three default data streams:

| Stream | FD | Description |
|--------|----|-------------|
| `stdin` | 0 | Standard Input — where a program reads from |
| `stdout` | 1 | Standard Output — where normal output goes |
| `stderr` | 2 | Standard Error — where error messages go |

### Redirection

Redirect streams to/from files:

```bash
command > output.txt        # Redirect stdout to file (overwrite)
command >> output.txt       # Append stdout to file
command 2> error.txt        # Redirect stderr to file
command < input.txt         # Feed file as stdin
command 2>&1                # Merge stderr into stdout
command > /dev/null 2>&1    # Discard all output silently
```

### Pipes `|`

**Pipes** connect the stdout of one command to the stdin of the next — building powerful command chains without temp files:

```bash
ps aux | grep nginx | awk '{print $2}'
#  ↑          ↑              ↑
# list      filter         extract
# all procs  nginx          PIDs only
```

---

## 9. Links — Symbolic & Hard

### Symbolic Links (Soft Links)

A **symlink** is a pointer (shortcut) to another file or directory. If the target is deleted, the symlink breaks.

```bash
ln -s /usr/local/bin/python3 /usr/bin/python
# 'python' → points to → 'python3'
```

**Use case:** Version management — point `python` to whichever version is active.

### Hard Links

A **hard link** is an alternative name for the *same data on disk* (same inode). The data persists as long as at least one hard link exists.

```bash
ln original.txt hardlink.txt
# Both names point to the SAME file data
```

| | Soft Link | Hard Link |
|-|-----------|-----------|
| Target deleted | Link breaks | Data still accessible |
| Cross filesystem | ✅ Yes | ❌ No |
| Points to | Path | Inode (data) |

---

## 10. Storage, Mounting & Swap

### Mounting

Linux doesn't use drive letters (like Windows C:, D:). Instead, storage devices are **mounted** — attached to a directory in the file system tree.

```bash
sudo mount /dev/sdb1 /mnt/usb     # Mount USB drive
sudo umount /mnt/usb              # Unmount it
```

### Partition Tools

| Tool | Use |
|------|-----|
| `fdisk` | Create/delete partitions (MBR) |
| `parted` | Modern partition manager (GPT + MBR) |
| `lvm` | Logical Volume Manager — flexible, resizable storage pools |

### Swap Space

When physical RAM is full, Linux uses **swap space** — an area on disk that acts as overflow memory. It's much slower than RAM but prevents out-of-memory crashes.

```
[ RAM ] → full → [ Swap on disk ]
```

---

## 11. Networking

### Core Concepts

| Concept | Tool/Command |
|---------|-------------|
| View IP addresses | `ip addr`, `ifconfig` |
| Test connectivity | `ping` |
| DNS resolution status | `resolvectl status` |
| Open ports / sockets | `ss`, `netstat` |
| Transfer data over HTTP | `curl`, `wget` |
| Capture network packets | `tcpdump`, `Wireshark` |
| File transfer | `scp`, `rsync` |
| File sharing | `NFS` (Linux-to-Linux), `Samba` (Linux-to-Windows) |

### SSH — Secure Shell

**SSH** encrypts your connection to a remote machine, protecting your login credentials and commands from interception.

```
[ Your machine ]  →  encrypted tunnel  →  [ Remote server ]
     ssh client                              sshd daemon
```

### Firewall

| Tool | Description |
|------|-------------|
| `iptables` | Low-level firewall rule engine built into the kernel |
| `ufw` | Uncomplicated Firewall — friendly frontend for iptables |

### Web Servers

Linux can host services using web servers:
- **Apache** (`httpd`) — battle-tested, module-rich
- **Nginx** — high-performance, event-driven

---

## 12. Security

### Firewall — iptables & ufw

The kernel's **netfilter** subsystem controls incoming and outgoing packets. `iptables` writes rules directly; `ufw` simplifies this with human-readable commands.

### Mandatory Access Control

Beyond standard permissions, Linux offers stricter security frameworks:

| System | Description |
|--------|-------------|
| **SELinux** | Security-Enhanced Linux — enforces policies for every process and file. Used in RHEL/Fedora. |
| **AppArmor** | Profiles that restrict what individual programs can do. Used in Ubuntu/Debian. |

These operate at the **kernel level** and can restrict even root-owned processes.

### PAM — Pluggable Authentication Modules

PAM is a **flexible authentication framework** that sits between user login attempts and the actual credential verification. It controls:

- How users log in (password, key, biometric)
- Password complexity rules
- Account lockout policies
- Session setup and teardown

---

## 13. System Monitoring & Logs

### Process Monitoring

| Command | Use |
|---------|-----|
| `top` | Real-time process viewer |
| `htop` | Enhanced, interactive version of top |
| `ps aux` | Snapshot of all running processes |
| `free -h` | RAM and swap usage |
| `df -h` | Disk space usage per filesystem |
| `du -sh dir/` | Disk usage of a specific directory |

### System Logs

Logs are stored under `/var/log/`:

| Log | Contents |
|-----|---------|
| `/var/log/syslog` | General system messages |
| `/var/log/auth.log` | Authentication attempts (logins, sudo) |
| `/var/log/kern.log` | Kernel messages |
| `/var/log/nginx/` | Web server access and error logs |

### dmesg — Kernel Ring Buffer

`dmesg` shows messages from the **kernel itself** — especially useful for diagnosing hardware issues during and after boot:

```bash
dmesg | grep -i error
dmesg | tail -20
```

### systemd Journal

`journalctl` queries the systemd journal — a structured, indexed log for all services:

```bash
journalctl -u nginx -n 50       # Last 50 lines for nginx
journalctl -f                   # Live-follow all logs
journalctl --since "1 hour ago" # Recent entries
```

---

## 14. File Systems & Disk Management

### Common File System Types

| File System | Strengths |
|-------------|-----------|
| **ext4** | Default on most Linux distros; stable, well-tested |
| **XFS** | High performance for large files; used in RHEL |
| **Btrfs** | Modern; supports snapshots, compression, RAID built-in |

### LVM — Logical Volume Manager

LVM adds a flexible abstraction layer over physical disks:

```
[ Physical Disks ] → [ Volume Group ] → [ Logical Volumes ] → [ File System ]
```

Benefits: Resize volumes without downtime, add/remove disks on the fly, take snapshots.

### Building from Source

To compile programs manually, Linux provides:
- **GCC** — the GNU Compiler Collection (C, C++, etc.)
- **make** — a build automation tool that reads `Makefile` instructions

```bash
./configure
make
sudo make install
```

---

## 15. Virtualization & Containers

### Containers — Docker & Podman

**Containers** package an application with all its dependencies into an isolated, portable unit. They share the host kernel but have isolated processes, filesystems, and networks.

```
[ Host Linux Kernel ]
   ├── Container A (nginx + app)
   ├── Container B (postgres)
   └── Container C (redis)
```

| Tool | Notes |
|------|-------|
| **Docker** | Most popular container platform |
| **Podman** | Daemonless, rootless alternative to Docker |

### Virtualization — KVM & QEMU

**KVM** (Kernel-based Virtual Machine) turns the Linux kernel into a hypervisor, allowing it to run full virtual machines. **QEMU** provides hardware emulation.

```
[ Host Linux + KVM ]
   ├── VM 1: Windows Server
   ├── VM 2: Ubuntu
   └── VM 3: FreeBSD
```

| | Containers | Virtual Machines |
|-|------------|-----------------|
| Isolation | Process-level | Full OS-level |
| Overhead | Very low | Higher |
| Startup | Milliseconds | Seconds/minutes |
| Shares kernel | Yes | No |

---

## 16. Desktop & Display

### Display Servers

A **display server** manages graphical output — it draws windows on screen and handles input devices.

| Server | Notes |
|--------|-------|
| **X11 (X.Org)** | Decades-old, widely compatible |
| **Wayland** | Modern, more secure and performant replacement for X11 |

### Desktop Environments

Sitting above the display server, a **desktop environment** provides the full graphical interface:

| DE | Style | Used in |
|----|-------|---------|
| **GNOME** | Clean, modern | Ubuntu, Fedora |
| **KDE Plasma** | Feature-rich, customizable | Kubuntu, openSUSE |
| **XFCE** | Lightweight | Xubuntu, older hardware |
| **i3 / sway** | Tiling window managers | Power users |

### Terminal Multiplexer — tmux

**tmux** lets you run multiple terminal sessions inside one window. Key features:

- Split the terminal into panes (horizontal/vertical)
- Detach from a session and re-attach later (sessions survive SSH disconnects)
- Run multiple windows within one session

```bash
tmux                    # Start new session
tmux attach             # Re-attach to existing session
Ctrl+b %                # Split pane vertically
Ctrl+b "                # Split pane horizontally
Ctrl+b d                # Detach from session
```

---

## 17. Advanced Shell Concepts

### Shell Built-ins vs External Commands

| Type | Examples | Behavior |
|------|----------|----------|
| **Built-ins** | `cd`, `echo`, `export`, `alias` | Run inside the shell process itself — faster |
| **External binaries** | `ls`, `grep`, `curl` | Fork a new child process to run |

### Shell Built-ins Worth Knowing

```bash
cd          # Change directory (must be built-in — can't change parent process dir otherwise)
echo        # Print text
export      # Set environment variable for child processes
alias       # Define command shortcuts
source      # Execute a script in the current shell context
type        # Show whether a command is a built-in, alias, or external binary
```

---

## 18. Special Virtual Filesystems

These directories are **not on disk** — they exist only in memory and expose live kernel data.

### `/proc` — Process & Kernel Info

```
/proc/
├── 1/              → Info about PID 1 (systemd)
├── cpuinfo         → CPU details
├── meminfo         → Memory usage
├── net/            → Network stats
└── sys/            → Kernel parameters (tunable via sysctl)
```

### `/dev` — Device Files

Every hardware device is represented as a file:

| File | Device |
|------|--------|
| `/dev/sda` | First SATA/SCSI hard disk |
| `/dev/nvme0n1` | First NVMe SSD |
| `/dev/tty` | Current terminal |
| `/dev/null` | Discard sink (write anything, read nothing) |
| `/dev/random` | Cryptographically secure random data |

---

## 19. Boot Process

The Linux boot sequence, step by step:

```
1. Power On
        ↓
2. BIOS / UEFI
   (POST, finds boot device)
        ↓
3. Bootloader (GRUB)
   (loads the kernel from disk)
        ↓
4. Kernel loads into memory
   (decompresses itself)
        ↓
5. initramfs (temporary root FS in RAM)
   (loads essential drivers before real FS is mounted)
        ↓
6. Real root filesystem mounted
        ↓
7. systemd starts (PID 1)
        ↓
8. systemd reaches the boot target
   (multi-user, graphical, etc.)
        ↓
9. Login prompt / Desktop
```

### initramfs

**initramfs** (initial RAM filesystem) is a small temporary root filesystem loaded into memory during boot. It contains the minimal drivers and tools needed to mount the actual root filesystem. Without it, the kernel couldn't access the disk drivers required to find `/`.

### Boot Analysis

```bash
systemd-analyze                     # Total boot time
systemd-analyze blame               # Per-service startup time
systemd-analyze plot > boot.svg     # Visual boot timeline
```

### Recovery

If the system fails to boot:
- **Recovery mode** — a special boot entry with minimal services and a root shell
- **Live USB** — boot a full Linux environment from USB to repair files, reinstall grub, or recover data

---

## 20. Linux Distributions

A **Linux distribution** (distro) packages the Linux kernel together with a set of software, package manager, default configuration, and support model.

### Major Families

| Family | Distros | Focus |
|--------|---------|-------|
| **Debian** | Ubuntu, Mint, Kali | Stability, wide compatibility |
| **Red Hat** | RHEL, Fedora, CentOS, Rocky | Enterprise, server use |
| **Arch** | Arch, Manjaro, EndeavourOS | Cutting-edge, DIY |
| **openSUSE** | Tumbleweed, Leap | Enterprise + rolling release |

### Choosing a Distro

| Need | Recommended |
|------|-------------|
| Beginner / Desktop | Ubuntu, Linux Mint |
| Server / Production | Ubuntu LTS, RHEL, Debian |
| Latest software | Fedora, Arch |
| Security / Pentesting | Kali Linux, Parrot OS |
| Low-end hardware | Alpine, Lubuntu, XFCE-based |

---

## Concept Map — How Everything Connects

```
                    ┌─────────────┐
                    │   Hardware  │
                    └──────┬──────┘
                           │
              ┌────────────▼────────────┐
              │       Linux Kernel      │
              │  (processes, memory,    │
              │   drivers, syscalls)    │
              └──┬──────┬──────┬────────┘
                 │      │      │
        ┌────────▼┐  ┌──▼──┐  ┌▼──────────┐
        │ /proc   │  │/dev │  │  systemd   │
        │ /sys    │  │files│  │ (PID 1)    │
        └─────────┘  └─────┘  └─────┬──────┘
                                     │ starts
                              ┌──────▼──────┐
                              │  Daemons &  │
                              │  Services   │
                              │(sshd, nginx)│
                              └─────────────┘
                                     │
              ┌──────────────────────▼──────────────────────┐
              │              Shell (bash/zsh)                │
              │  env vars, pipes, redirection, scripts       │
              └──────────────────────┬──────────────────────┘
                                     │
              ┌──────────────────────▼──────────────────────┐
              │            User Programs                     │
              │        (editors, browsers, tools)            │
              └─────────────────────────────────────────────┘
```

---

*This document covers Linux internals from kernel to desktop — structured for progressive learning and quick reference.*
