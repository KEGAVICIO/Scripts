# ⚙ Scripts

This repository contains a collection of Bash and Python scripts designed to facilitate both operating system administration and networking tasks.

It includes tools for automation, scanning, file management, and other common Linux tasks.

---

## 🗂 Repository Structure

```bash
Scripts/
├── bash/ # Bash scripts
│ ├── detectDevices.sh # Detect devices on the local network
│ ├── ScannigPorts.sh # Scan open ports on a target IP
│ ├── ToolScaningv2.sh # Extended scanning tool
│ └── ... # Scripts to automate system tasks
│
├── python/ # Python scripts
│ ├── PassAttack.py # Script for dictionary or brute-force attacks
| └── ... # Other scripts to automate system tasks
│
└── README.md
```

---

## 🚀 How to use

### 🐚 Bash Scripts

Make sure you give them execution permissions:

```bash
chmod +x script.sh
./script.sh
```

Example to automate folder creation or network scanning:

```bash
./ToolScaningv2.sh
```

### 🐍 Python Script

Run with Python 3:

```bash
python3 PassAttack.py
```

*It is recommended to run it within a virtual or controlled environment.*

---

## 📦 Requirements

Depending on the script, you may need:

- Tools like `nmap`, `arp-scan`, `cron`, etc.
- Python 3.x and standard libraries
- Linux operating system (preferred)

---

## 🛡 Security Considerations

These scripts are for **educational and administrative** purposes. They are intended for use in your own or authorized environments. **Do not use them without permission on other people's networks or systems.**

---

## ✍ Author

**KEGA**
Passionate about cybersecurity, automation, and programming for operating systems and networks.

---

## 📬 Contributions

Do you have a useful script you'd like to share? All contributions are welcome!

1. Fork the repository 🍴
2. Create a new branch `feature/new-script`
3. Add your script to the corresponding folder (`bash/` or `python/`)
4. Open a Pull Request 🚀

---

## 🎯 Objective

This repository aims to centralize useful scripts for automating operating system tasks, performing network tests, and supporting daily Linux system administration.
