---
name: zabbix-super-agent
description: Comprehensive Zabbix diagnostics and troubleshooting agent. Uses Sherlock Holmes deductive methodology to investigate Zabbix server, frontend, database, agents, and monitoring targets. Use when Zabbix shows issues, server won't start, no data coming in, or alerts failing.
triggers:
  - zabbix
  - zabbix server
  - zabbix agent
  - zabbix troubleshooting
  - zabbix investigation
  - zabbix diagnostic
version: 1.0.0
category: monitoring
author: Goku Saiyan
---

# Zabbix Super Agent 🕵️

**Investigation-based Zabbix troubleshooting using Sherlock Holmes methodology.**

---

## 🔍 FULL DIAGNOSTIC (Run First)

When Zabbix has ANY issue, start here:

```bash
~/.openclaw/workspace/skills/zabbix-super-agent/scripts/zabbix-diagnose.sh
```

This runs the complete investigation chain automatically.

---

## 🕵️ INVESTIGATION PROTOCOL

### Step 1: OBSERVE - Collect Evidence

```bash
# === ZABBIX SERVER STATUS ===
systemctl status zabbix-server --no-pager
ps aux | grep zabbix_server | grep -v grep

# === FRONTEND STATUS ===
systemctl status zabbix-server --no-pager
nginx -t
httpdctl status apache2 2>/dev/null || systemctl status httpd 2>/dev/null

# === DATABASE STATUS ===
systemctl status mysql 2>/dev/null || systemctl status mariadb 2>/dev/null || systemctl status postgresql 2>/dev/null
ps aux | grep -E 'mysql|mariadb|postgres' | grep -v grep

# === MEMORY & DISK ===
free -h
df -h

# === ZABBIX LOGS ===
tail -100 /var/log/zabbix/zabbix_server.log
tail -50 /var/log/zabbix/zabbix_server.log | grep -i error

# === NETWORK CONNECTIONS ===
netstat -tlnp | grep -E '10051|3306|80|443'
netstat -tunp | grep zabbix

# === ZABBIX AGENT CONNECTIVITY ===
zabbix_get -s <agent-ip> -k 'system.cpu.load' 2>&1

# === CONFIGURATION ===
cat /etc/zabbix/zabbix_server.conf | grep -E '^DB|^Log|^Pid' 
```

---

### Step 2: DEDUCE - Common Issues

| Symptom | Likely Cause | Quick Fix |
|---------|-------------|-----------|
| **Server running but no data** | Agent can't reach server, or server can't reach DB | Check firewall, DB credentials |
| **Frontend shows "Zabbix server is running: No"** | Server process dead or port blocked | `systemctl restart zabbix-server` |
| **Old data in graphs** | Server crashed, nopoller issue | Check server log for crashes |
| **Alerts not sending** | Mail server, media type config | Test media type, check sendmail |
| **High CPU load** | Too many items, too many polls | Increase StartPollers, optimize items |
| **Can't connect to database** | Wrong credentials, DB down | Verify `/etc/zabbix/zabbix_server.conf` |
| **Zabbix server won't start** | MySQL lock, out of memory | `tail /var/log/zabbix/zabbix_server.log` |

---

### Step 3: TEST - Verification Commands

```bash
# === TEST DATABASE CONNECTION ===
mysql -u zabbix -p -h localhost zabbix -e "SELECT COUNT(*) FROM hosts;"

# === TEST AGENT connectivity ===
zabbix_get -s <HOST_IP> -k 'agent.ping'

# === TEST WEB FRONTEND ===
curl -s http://localhost/zabbix/index.php | grep -i zabbix

# === TEST SERVER LOGGING ===
zabbix_server -n 1 -c /etc/zabbix/zabbix_server.conf 2>&1 | head -20

# === CHECK SE linux / AppArmor ===
getenforce 2>/dev/null || echo "SELinux not installed"
aa-status 2>/dev/null || echo "AppArmor not installed"
```

---

### Step 4: FIX - Common Solutions

#### 🔴 SERVER WON'T START

```bash
# 1. Check logs first
tail -100 /var/log/zabbix/zabbix_server.log

# 2. Fix MySQL if lock issue
sudo systemctl restart mysql
sudo systemctl restart zabbix-server

# 3. If OOM (out of memory)
sudo systemctl edit zabbix-server
# Add: [Service]
# Environment="ZBX_VIRTUALMEMORYLIMIT=512"

# 4. Reconfigure if config broken
dpkg-reconfigure zabbix-server
# OR
sudo -u zabbix zabbix_server -n 1 -c /etc/zabbix/zabbix_server.conf
```

#### 🟠 DATABASE CONNECTION FAILURE

```bash
# 1. Test credentials
mysql -u zabbix -p YOUR_PASSWORD -h localhost zabbix

# 2. Update zabbix_server.conf
sudo nano /etc/zabbix/zabbix_server.conf
# Set: DBHost=localhost
# Set: DBName=zabbix
# Set: DBUser=zabbix
# Set: DBPassword=YOUR_PASSWORD

# 3. Restart
sudo systemctl restart zabbix-server
```

#### 🟡 FRONTEND "SERVER RUNNING: NO"

```bash
# 1. Check server process
ps aux | grep zabbix_server | grep -v grep

# 2. If not running
sudo systemctl restart zabbix-server

# 3. Check socket/port
netstat -tlnp | grep 10051

# 4. Check SELinux/AppArmor
getenforce  # should be Disabled or Permissive
sudo setenforce 0  # temp fix
```

#### 🟢 NO DATA FROM AGENTS

```bash
# 1. Check agent is running on target
systemctl status zabbix-agent

# 2. Test from server
zabbix_get -s <TARGET_IP> -k 'agent.ping'

# 3. Check firewall
sudo iptables -L -n | grep zabbix
# OR
sudo firewall-cmd --list-all | grep zabbix

# 4. Add agent to host in Zabbix UI
# Administration → Actions → Auto discovery → Enable
```

#### 🔵 ALERTS NOT SENDING

```bash
# 1. Test email from CLI
echo "Test" | sendmail -v recipient@email.com

# 2. Check media type config in UI
# Administration → Media Types → Email

# 3. Check alert queue
mysql -u zabbix -p -h localhost zabbix -e "SELECT * FROM alerts WHERE status=0 LIMIT 5;"

# 4. Restart alert manager
sudo systemctl restart zabbix-server
```

---

## 📊 PERFORMANCE OPTIMIZATION

### Quick Performance Tunes

```bash
# Edit zabbix_server.conf
sudo nano /etc/zabbix/zabbix_server.conf

# Add/increase:
StartPollers=10          # Default 5
StartPollersUnreachable=5  # Default 1
StartPingers=5           # For ICMP checks
CacheSize=256M           # Default 8M - increase for many hosts
```

```bash
# Restart after config change
sudo systemctl restart zabbix-server

# Monitor performance
mysql -u zabbix -p -h localhost zabbix -e "SHOW PROCESSLIST;"
```

---

## 📋 INVESTIGATION LOG

```
## EVIDENCE
- [ ] Zabbix server status: running/stopped
- [ ] Frontend URL accessible: yes/no
- [ ] Database connection: works/fails
- [ ] Memory usage: X GB / Y GB
- [ ] Disk space: X% used
- [ ] Last server log error: [paste]

## HYPOTHESIS
[Most likely root cause based on evidence]

## TEST
[Command to verify hypothesis]

## CONCLUSION
[Confirmed root cause]
[Fix applied]
[Verification command and result]
```

---

## 🚨 EMERGENCY COMMANDS

```bash
# STOP everything
sudo systemctl stop zabbix-server zabbix-agent

# START everything  
sudo systemctl start zabbix-server zabbix-agent

# FULL RESTART
sudo systemctl restart zabbix-server mysql nginx httpd

# VIEW REAL-TIME LOGS
sudo tail -f /var/log/zabbix/zabbix_server.log

# CHECK ALL SERVICES
sudo systemctl status zabbix-server zabbix-agent mysql nginx httpd --no-pager -l
```

---

## 🔗 Useful Links

| Resource | URL/Path |
|----------|----------|
| Zabbix Frontend | `http://your-server/zabbix` |
| Config File | `/etc/zabbix/zabbix_server.conf` |
| Server Log | `/var/log/zabbix/zabbix_server.log` |
| Agent Config | `/etc/zabbix/zabbix_agentd.conf` |
| Frontend Config | `/etc/zabbix/web/zabbix.conf.php` |

---

## 📁 Scripts Included

| Script | Purpose |
|--------|---------|
| `scripts/zabbix-diagnose.sh` | Full auto-diagnostic (run this first) |

---

**Remember: No assumptions. Only facts from live evidence.**
