#!/usr/bin/env bash
set -euo pipefail

VERSION="1.0.0"
PKG="chatgpt-linux-app"
BUILD="pkg"

rm -rf "$BUILD"
mkdir -p "$BUILD/DEBIAN"
mkdir -p "$BUILD/usr/bin"
mkdir -p "$BUILD/usr/share/applications"
mkdir -p "$BUILD/usr/share/icons/hicolor/scalable/apps"
mkdir -p "$BUILD/usr/share/doc/$PKG"

# Copy executables
install -Dm755 chatgpt.sh "$BUILD/usr/bin/chatgpt"
install -Dm755 chatgpt-left.sh "$BUILD/usr/bin/chatgpt-left"
install -Dm755 chatgpt-right.sh "$BUILD/usr/bin/chatgpt-right"
install -Dm755 chatgpt-full.sh "$BUILD/usr/bin/chatgpt-full"
install -Dm755 chatgpt-tile.sh "$BUILD/usr/bin/chatgpt-tile"

# Desktop entries
install -Dm644 chatgpt.desktop "$BUILD/usr/share/applications/chatgpt.desktop"
install -Dm644 chatgpt-left.desktop "$BUILD/usr/share/applications/chatgpt-left.desktop"
install -Dm644 chatgpt-right.desktop "$BUILD/usr/share/applications/chatgpt-right.desktop"
install -Dm644 chatgpt-full.desktop "$BUILD/usr/share/applications/chatgpt-full.desktop"

# Icon
install -Dm644 chatgpt.svg "$BUILD/usr/share/icons/hicolor/scalable/apps/chatgpt.svg"

# README
install -Dm644 README.md "$BUILD/usr/share/doc/$PKG/README.md"

# Control file
cat > "$BUILD/DEBIAN/control" << CONTROL
Package: $PKG
Version: $VERSION
Section: utils
Priority: optional
Architecture: all
Maintainer: Anonymous <none>
Description: Linux desktop launcher for ChatGPT using Chrome App Mode
 Provides multiple tiling launch modes and a native-feeling launcher experience.
CONTROL

# Build .deb
dpkg-deb --build "$BUILD" "${PKG}_${VERSION}_all.deb"

echo
echo "====================================="
echo "  BUILD COMPLETE"
echo "  Output: ${PKG}_${VERSION}_all.deb"
echo "====================================="
