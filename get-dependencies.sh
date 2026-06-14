#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm lttng-ust2.12 pcsclite

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano webkit2gtk-4.1-mini

# Comment this out if you need an AUR package
make-aur-package remote-desktop-manager

# If the application needs to be manually built that has to be done down here
mkdir -p ./AppDir/bin
cp -rv /usr/lib/devolutions/RemoteDesktopManager/* ./AppDir/bin

# app has a helper library that links to webkit2gtk4 instead of 4.1
# this library is 100% broken and prevents deployment
rm -f ./AppDir/bin/libWebView-4.0.so*

# this app ships its own ssh binary 🤨
# it depends on an outdated libcrypt.so.1
# it is totally broken on archlinux by default
# remove it, but I'm starting to think this app is totally broken in general
rm -f ./AppDir/bin/ssh
