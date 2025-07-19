#!/bin/bash

LOG_DIR=/.antzbot mkdir -p "$LOG_DIR"

Load Telegram config if present

if [ -f "$CONFIG_FILE" ]; then source "$CONFIG_FILE" fi

send_telegram() { local msg="$1" if [[ -n "$BOT_TOKEN" && -n "$CHAT_ID" ]]; then curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" 
-d chat_id="${CHAT_ID}" 
-d text="$(echo -e "$msg")" > /dev/null fi }

while true; do clear echo "==========================================" echo "     🔥 ATTACK ON ANTZ - Tool Launcher 🔥" echo "==========================================" echo " 1) Nmap - Network scanner" echo " 2) Hydra - Login brute force" echo " 3) SQLmap - SQLi automation" echo " 4) Nikto - Web vuln scanner" echo " 5) Wireshark (GUI) - Sniffer" echo " 6) Aircrack-ng - WiFi hacking" echo " 7) Whois - Domain info" echo " 8) Netdiscover - LAN scanner" echo " 9) WhatWeb - Web tech stack" echo "10) Dirb - Directory brute-forcer" echo "11) Recon-ng - Recon toolkit" echo "12) DNSenum - DNS mapping" echo "13) WafW00f - Firewall detector" echo "14) Netcat listener" echo "15) Show logs" echo "16) Clear logs" echo "17) Update tools" echo "18) Exit" echo "------------------------------------------" read -p "Choose [1-18]: " choice timestamp=$(date +%Y-%m-%d_%H-%M-%S) logfile="$LOG_DIR/antz-$timestamp.log"

case $choice in 1) read -p "Target: " t; result=$(nmap -A "$t");; 2) echo "Run hydra manually: hydra -l admin -P rockyou.txt <IP> http-get"; continue;; 3) read -p "Target URL: " url; result=$(sqlmap -u "$url" --batch);; 4) read -p "Website: " site; result=$(nikto -h "$site");; 5) echo "Launching Wireshark GUI..."; wireshark & disown; continue;; 6) aircrack-ng; continue;; 7) read -p "Domain/IP: " who; result=$(whois "$who");; 8) result=$(netdiscover -r 192.168.1.0/24 -P -N);; 9) read -p "Website: " web; result=$(whatweb "$web");; 10) read -p "Target site: " dirbsite; result=$(dirb "$dirbsite");; 11) recon-ng; continue;; 12) read -p "Domain: " dns; result=$(dnsenum "$dns");; 13) read -p "Website: " waf; result=$(wafw00f "$waf");; 14) read -p "Port to listen on: " port; nc -lvp "$port"; continue;; 15) less "$LOG_DIR"/.log; continue;; 16) rm -f "$LOG_DIR"/.log && echo "Logs cleared."; sleep 2; continue;; 17) apt update && apt upgrade -y; continue;; 18) echo "Goodbye, soldier of Antz."; exit 0;; *) echo "Invalid option"; sleep 1; continue;; esac
#!/bin/bash

echo "🔥 ATTACK ON ANTZ"
echo "1) Run Nmap"
echo "2) Exit"
read -p "Choice: " opt

case $opt in
  1) read -p "Target IP: " ip; nmap -A "$ip";;
  2) echo "Goodbye Antz"; exit 0;;
  *) echo "Invalid option";;
esac

echo "$result" | tee "$logfile" send_telegram "\ud83d\udd27 $choice result:\n$(echo "$result" | head -n 20)" echo "\nLog saved: $logfile" read -p "Press Enter to return to menu..." done

