#!/bin/bash
# Zabbix Full Auto-Diagnostic Script
# Run this FIRST when troubleshooting Zabbix

set -e

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║         🕵️ ZABBIX SUPER AGENT - FULL DIAGNOSTIC              ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo " $1"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

print_ok() {
    echo -e "${GREEN}[✅ OK]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[⚠️  WARN]${NC} $1"
}

print_fail() {
    echo -e "${RED}[❌ FAIL]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[ℹ️  INFO]${NC} $1"
}

#############################################
# SECTION 1: ZABBIX SERVER
#############################################
print_header "1️⃣  ZABBIX SERVER STATUS"

if systemctl is-active --quiet zabbix-server 2>/dev/null; then
    print_ok "Zabbix server is RUNNING"
    systemctl status zabbix-server --no-pager | head -5
else
    print_fail "Zabbix server is STOPPED"
    echo "Last 20 log lines:"
    tail -20 /var/log/zabbix/zabbix_server.log 2>/dev/null || echo "Log file not found"
fi

echo ""
echo "Zabbix processes:"
ps aux | grep zabbix_server | grep -v grep || echo "No zabbix_server process found"

#############################################
# SECTION 2: FRONTEND
#############################################
print_header "2️⃣  ZABBIX FRONTEND STATUS"

# Check if frontend is accessible
if curl -s -o /dev/null -w "%{http_code}" http://localhost/zabbix/index.php 2>/dev/null | grep -q "200"; then
    print_ok "Frontend is accessible (HTTP 200)"
elif curl -s -o /dev/null -w "%{http_code}" http://localhost/zabbix/index.php 2>/dev/null | grep -q "302"; then
    print_ok "Frontend is accessible (HTTP 302 redirect - normal)"
else
    CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/zabbix/index.php 2>/dev/null || echo "000")
    print_warn "Frontend returned HTTP $CODE"
fi

# Check web server
for svc in nginx apache2 httpd; do
    if systemctl is-active --quiet $svc 2>/dev/null; then
        print_ok "$svc is running"
    fi
done

# Check PHP-FPM
if systemctl is-active --quiet php-fpm 2>/dev/null; then
    print_ok "PHP-FPM is running"
fi

#############################################
# SECTION 3: DATABASE
#############################################
print_header "3️⃣  DATABASE STATUS"

for db_svc in mysql mariadb postgresql; do
    if systemctl is-active --quiet $db_svc 2>/dev/null; then
        print_ok "$db_svc is RUNNING"
        
        # Quick query test
        if [ "$db_svc" = "postgresql" ]; then
            sudo -u postgres psql -c "SELECT 1;" 2>/dev/null && print_ok "PostgreSQL query works" || print_warn "PostgreSQL query failed"
        else
            mysql -e "SELECT 1;" 2>/dev/null && print_ok "MySQL query works" || print_warn "MySQL query failed"
        fi
    fi
done

# Check Zabbix database exists
if mysql -e "USE zabbix; SELECT COUNT(*) FROM hosts;" 2>/dev/null; then
    print_ok "Zabbix database is accessible"
else
    print_fail "Cannot access Zabbix database"
fi

#############################################
# SECTION 4: MEMORY & DISK
#############################################
print_header "4️⃣  MEMORY & DISK"

echo "Memory usage:"
free -h | grep -E "Mem|Swap"

echo ""
echo "Disk usage:"
df -h / | tail -1

# Check if low on memory
MEM_AVAILABLE=$(free -m | grep Mem | awk '{print $7}')
if [ "$MEM_AVAILABLE" -lt 500 ]; then
    print_warn "Low memory: ${MEM_AVAILABLE}MB available"
else
    print_ok "Memory OK: ${MEM_AVAILABLE}MB available"
fi

# Check disk space
DISK_USED=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ "$DISK_USED" -gt 90 ]; then
    print_fail "Disk nearly full: ${DISK_USED}% used"
elif [ "$DISK_USED" -gt 80 ]; then
    print_warn "Disk getting full: ${DISK_USED}% used"
else
    print_ok "Disk OK: ${DISK_USED}% used"
fi

#############################################
# SECTION 5: NETWORK & PORTS
#############################################
print_header "5️⃣  NETWORK & PORTS"

echo "Zabbix server port (10051):"
if netstat -tlnp 2>/dev/null | grep -q 10051; then
    print_ok "Port 10051 is LISTENING"
    netstat -tlnp | grep 10051
elif ss -tlnp 2>/dev/null | grep -q 10051; then
    print_ok "Port 10051 is LISTENING (ss)"
    ss -tlnp | grep 10051
else
    print_fail "Port 10051 is NOT listening"
fi

echo ""
echo "Database port (3306):"
if netstat -tlnp 2>/dev/null | grep -q 3306; then
    print_ok "MySQL port 3306 is LISTENING"
elif ss -tlnp 2>/dev/null | grep -q 3306; then
    print_ok "MySQL port 3306 is LISTENING (ss)"
fi

echo ""
echo "Web server ports (80/443):"
netstat -tlnp 2>/dev/null | grep -E ':80|:443' || ss -tlnp 2>/dev/null | grep -E ':80|:443'

#############################################
# SECTION 6: ZABBIX LOG ERRORS
#############################################
print_header "6️⃣  RECENT ERRORS IN LOG"

if [ -f /var/log/zabbix/zabbix_server.log ]; then
    ERROR_COUNT=$(tail -100 /var/log/zabbix/zabbix_server.log 2>/dev/null | grep -ci "error\|critical\|cannot\|failed" || echo "0")
    if [ "$ERROR_COUNT" -gt 0 ]; then
        print_warn "Found $ERROR_COUNT potential errors in last 100 log lines"
        echo ""
        echo "Recent errors:"
        tail -50 /var/log/zabbix/zabbix_server.log 2>/dev/null | grep -i "error\|critical\|cannot\|failed" | tail -10
    else
        print_ok "No errors in recent log"
    fi
else
    print_info "Log file not found at /var/log/zabbix/zabbix_server.log"
fi

#############################################
# SECTION 7: AGENT CONNECTIVITY TEST
#############################################
print_header "7️⃣  QUICK AGENT TEST"

# Get first Zabbix agent host from DB if available
AGENT_IP=$(mysql -N -e "SELECT interface_ip FROM interfaces WHERE type=1 LIMIT 1;" zabbix 2>/dev/null)
if [ -n "$AGENT_IP" ]; then
    echo "Testing agent at: $AGENT_IP"
    if command -v zabbix_get &>/dev/null; then
        RESULT=$(zabbix_get -s "$AGENT_IP" -k 'agent.ping' 2>&1)
        if [ "$RESULT" = "1" ]; then
            print_ok "Agent at $AGENT_IP is responding"
        else
            print_warn "Agent responded but with: $RESULT"
        fi
    else
        print_info "zabbix_get not installed, skipping agent test"
    fi
else
    print_info "No agents configured or DB not accessible"
fi

#############################################
# SUMMARY
#############################################
print_header "📋 SUMMARY & RECOMMENDATIONS"

SERVER_RUNNING=$(systemctl is-active --quiet zabbix-server 2>/dev/null && echo "yes" || echo "no")
DB_RUNNING=$(mysql -e "SELECT 1;" 2>/dev/null && echo "yes" || echo "no")
DISK_OK=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

echo "Quick Status:"
echo "  Server:   $( [ "$SERVER_RUNNING" = "yes" ] && echo -e "${GREEN}RUNNING${NC}" || echo -e "${RED}STOPPED${NC}" )"
echo "  Database: $( [ "$DB_RUNNING" = "yes" ] && echo -e "${GREEN}ACCESSIBLE${NC}" || echo -e "${RED}UNREACHABLE${NC}" )"
echo "  Disk:     $( [ "$DISK_OK" -lt 80 ] && echo -e "${GREEN}${DISK_OK}% used${NC}" || echo -e "${RED}${DISK_OK}% used${NC}" )"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " DIAGNOSTIC COMPLETE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "To view full server log: sudo tail -f /var/log/zabbix/zabbix_server.log"
echo "To restart server:       sudo systemctl restart zabbix-server"
echo ""
