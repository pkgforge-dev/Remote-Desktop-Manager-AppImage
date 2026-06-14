#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
# pacman -Syu --noconfirm PACKAGESHERE

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano webkit2gtk-4.1-mini

# Comment this out if you need an AUR package
make-aur-package remote-desktop-manager

# If the application needs to be manually built that has to be done down here
mkdir -p ./AppDir/bin
cp -rv /usr/lib/devolutions/RemoteDesktopManager/* ./AppDir/bin
