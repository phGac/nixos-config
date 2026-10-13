#!/bin/sh

CURRENT_DIR=$(pwd)
NIX_DIR="$CURRENT_DIR/nixos"
DESTINATION_DIR="/etc/nixos"
#CURRENT_HOSTNAME=""

if [ -f "./host" ]; then
    CURRENT_HOSTNAME=$(<./host)
else
    echo "host file does not exist. Create it for set current host."
fi

if [ ! -d "$DESTINATION_DIR" ]; then
    echo "Destination directory does not exist. Creating it..."
    mkdir -p "$DESTINATION_DIR"
fi

sudo rm -rf "$DESTINATION_DIR/*" || ''
sudo cp -r "$NIX_DIR/." "$DESTINATION_DIR"

cd "$DESTINATION_DIR" || exit
#sudo nix flake update
sudo nixos-rebuild switch --flake "$DESTINATION_DIR#$CURRENT_HOSTNAME"

sudo cp "$DESTINATION_DIR/flake.lock" "$NIX_DIR/flake.lock"
