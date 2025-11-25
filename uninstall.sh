#!/bin/bash
set -e

echo "----------------------------------------"
echo "       ChatGPT Linux Uninstaller"
echo "----------------------------------------"
echo ""

# Check if dpkg package exists
if dpkg -s chatgpt-linux-app >/dev/null 2>&1; then
    echo "It looks like the chatgpt-linux-app .deb package is installed."
    echo "The recommended way to remove it is:"
    echo ""
    echo "  sudo dpkg -r chatgpt-linux-app"
    echo ""
    read -p "Do you still want to remove per-user files? (y/n): " ANS
    if [[ ! "$ANS" =~ ^[Yy]$ ]]; then
        echo "Aborting per-user uninstall."
        exit 0
    fi
fi

echo "Removing per-user files..."

rm -f "$HOME/.local/bin/chatgpt"
rm -f "$HOME/.local/share/applications/chatgpt.desktop"
rm -f "$HOME/.local/share/icons/chatgpt.svg"
rm -f "$HOME/.config/chatgpt-layout"
rm -rf "$HOME/.config/chatgpt-profile"

update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null || true

echo ""
echo "Done."
echo "If you installed via .deb and still see entries, run:"
echo "  sudo dpkg -r chatgpt-linux-app"
echo "----------------------------------------"
