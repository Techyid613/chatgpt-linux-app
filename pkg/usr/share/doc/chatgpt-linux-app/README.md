# ⭐ ChatGPT Linux App

A clean, native-feeling desktop launcher for ChatGPT on Linux.
Opens ChatGPT in a minimal Chrome “app-mode” window with its own isolated browser profile, plus optional tiling launchers (left / right / full screen / small tile).

This project is lightweight, fast, and works on any modern Linux desktop environment.

---

## ✅ Features

- Opens ChatGPT in Chrome App Mode (no tabs, no URL bar)
- Uses a dedicated Chrome/Chromium/Brave profile for persistent login
- Optional tiling launchers:
  - Left split
  - Right split
  - Full screen
  - Small tile
- Clean .desktop entries for app launchers
- Simple install & uninstall scripts
- Zero dependencies beyond Chrome + wmctrl

---

## 📦 Installation

### Manual installation (no root required)

chmod +x install.sh
./install.sh

This installs:

- Launch scripts → ~/.local/bin/
- Desktop entries → ~/.local/share/applications/
- Icon → ~/.local/share/icons/hicolor/scalable/apps/

Then search “ChatGPT” in your system launcher.

---

## 🚀 Usage

| Launcher | Behavior |
|---------|----------|
| ChatGPT | Standard Chrome app-window |
| ChatGPT (Left Tile) | Auto-tiles left |
| ChatGPT (Right Tile) | Auto-tiles right |
| ChatGPT (Full Screen) | Opens maximized |
| ChatGPT (Small Tile) | Opens in a small tile |

---

## 🔧 Requirements

- Google Chrome / Chromium / Brave
- wmctrl
- Any Linux desktop (GNOME, KDE, XFCE, Cinnamon, etc.)

Install wmctrl:

sudo apt install wmctrl

---

## 🧰 Planned Enhancements

- Auto browser detection
- Wayland support
- Zenity GUI layout picker
- Unified config file
- One launcher with saved layout

---

## 🏷️ GitHub Metadata

Description:
A lightweight Linux desktop launcher for ChatGPT using Chrome app mode, with optional tiling layouts.

Tags:
chatgpt linux launcher chrome chromium brave wmctrl desktop productivity

---

## 📄 License — GPLv3 (Strong Copyleft)

This project is licensed under the **GNU GPLv3**.  
Derivative work must remain open-source under GPLv3.

License text: https://www.gnu.org/licenses/gpl-3.0.txt

