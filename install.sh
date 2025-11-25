#!/bin/bash

set -e

echo "----------------------------------------"
echo "        ChatGPT Linux Installer"
echo "----------------------------------------"
echo ""

# -----------------------------
# 1. Check for Google Chrome
# -----------------------------
if ! command -v google-chrome >/dev/null 2>&1; then
    echo "⚠️  Google Chrome is not installed."
    echo "   This app requires Chrome App Mode."
    echo ""
    echo "Please install Google Chrome first:"
    echo "https://www.google.com/chrome/"
    echo ""
    exit 1
fi

# -----------------------------
# 2. Required dependencies
# -----------------------------
REQUIRED_PKGS=("wmctrl" "x11-utils")
OPTIONAL_PKGS=("xdotool" "zenity")

echo "Checking required packages..."
MISSING=()

for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! dpkg -s "$pkg" >/dev/null 2>&1; then
        MISSING+=("$pkg")
    fi
done

if [ ${#MISSING[@]} -ne 0 ]; then
    echo ""
    echo "The following required packages are missing:"
    printf '  - %s\n' "${MISSING[@]}"
    echo ""
    read -p "Install them now? (y/n): " INSTALL_REQ

    if [[ "$INSTALL_REQ" =~ ^[Yy]$ ]]; then
        sudo apt update
        sudo apt install -y "${MISSING[@]}"
    else
        echo "Cannot continue without required dependencies. Exiting."
        exit 1
    fi
fi

# optional
echo ""
echo "Checking optional recommended packages..."
MISSING_OPT=()

for pkg in "${OPTIONAL_PKGS[@]}"; do
    if ! dpkg -s "$pkg" >/dev/null 2>&1; then
        MISSING_OPT+=("$pkg")
    fi
done

if [ ${#MISSING_OPT[@]} -ne 0 ]; then
    echo ""
    echo "Optional packages missing (recommended for better functionality):"
    printf '  - %s\n' "${MISSING_OPT[@]}"
    echo ""
    read -p "Install optional packages? (y/n): " INSTALL_OPT

    if [[ "$INSTALL_OPT" =~ ^[Yy]$ ]]; then
        sudo apt update
        sudo apt install -y "${MISSING_OPT[@]}"
    fi
fi

# -----------------------------
# 3. Ask for layout mode
# -----------------------------
echo ""
echo "Choose your default window layout:"
echo "  1) Left Split"
echo "  2) Right Split"
echo "  3) Full Screen"
echo "  4) Normal Window"
echo ""
read -p "Select (1-4): " CHOICE

case "$CHOICE" in
    1) LAYOUT="left" ;;
    2) LAYOUT="right" ;;
    3) LAYOUT="full" ;;
    4) LAYOUT="normal" ;;
    *) echo "Invalid selection. Defaulting to normal."; LAYOUT="normal" ;;
esac

echo ""
echo "Saving layout preference: $LAYOUT"
mkdir -p "$HOME/.config"
echo "$LAYOUT" > "$HOME/.config/chatgpt-layout"

# -----------------------------
# 4. Install files
# -----------------------------
echo ""
echo "Installing ChatGPT launcher and desktop entry..."
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/icons"

cp chatgpt.sh "$HOME/.local/bin/chatgpt"
chmod +x "$HOME/.local/bin/chatgpt"

cp chatgpt.desktop "$HOME/.local/share/applications/"
cp chatgpt.svg "$HOME/.local/share/icons/chatgpt.svg"

update-desktop-database "$HOME/.local/share/applications/"

echo ""
echo "----------------------------------------"
echo " Installation Complete!"
echo " You can now launch ChatGPT from:"
echo "   • Your application menu"
echo "   • Your app grid"
echo ""
echo "To change the layout later, edit:"
echo "   $HOME/.config/chatgpt-layout"
echo "----------------------------------------"
