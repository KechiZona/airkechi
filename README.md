# airkechi

**airkechi** is a lightweight Bash script that automates Wi-Fi deauthentication attacks.  
It scans nearby networks, lets you select a target access point, gathers connected devices, and kicks them off the network with continuous deauth packets.

> ⚠️ This tool is intended **only for educational and authorized penetration testing purposes**. Unauthorized use is illegal and unethical.

---

## ✨ Features

- Scans nearby Wi-Fi networks  
- Lets you select target BSSID and channel  
- Collects connected device MACs automatically  
- Performs infinite deauthentication attacks  
- Cleans up all temporary files after Ctrl+C  
- Fully interactive CLI interface  

---

## 🚀 Installation

```bash
git clone https://github.com/kechizona/airkechi.git
cd airkechi
chmod +x airkechi.sh
````

---

## 🛠️ Requirements

* Bash
* aircrack-ng suite
* Wireless adapter that supports **monitor mode** and **packet injection**

Install aircrack-ng:

```bash
# Debian/Ubuntu
sudo apt install aircrack-ng

# Fedora
sudo dnf install aircrack-ng

# Arch Linux
sudo pacman -S aircrack-ng
```

---

## ⚡ Usage

```bash
sudo ./airkechi.sh
```

Script will guide you through:

* Selecting your Wi-Fi interface (e.g., wlan1)
* Choosing the target network
* Setting the deauth packet count (e.g., 10 or 0 for infinite)
* Performing the attack

After pressing `Ctrl+C`, it:

* Stops monitor mode
* Deletes all files except `airkechi.sh`

---

## 📂 Output

The following temporary files are created during use:

* `targets-01.csv`
* `macs.txt`

They are automatically deleted after the attack ends.

---

## 📜 License

MIT License — see [LICENSE](LICENSE) for details.

---

## 👤 Author

* **KechiZona**
* GitHub: [@kechizona](https://github.com/kechizona)

---

## ❗ Disclaimer

This tool is provided for educational and ethical hacking purposes only.
**You are solely responsible** for how you use it. Always get permission before testing any network.
