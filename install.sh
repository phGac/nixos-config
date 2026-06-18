#!/bin/sh

CURRENT_DIR=$(pwd)
NIX_DIR="$CURRENT_DIR/nixos"
DESTINATION_DIR="/etc/nixos"

if [ ! -d "$DESTINATION_DIR" ]; then
    echo "Destination directory does not exist. Creating it..."
    mkdir -p "$DESTINATION_DIR"
fi

sudo rm -rf "$DESTINATION_DIR/*" || ''
sudo cp -r "$NIX_DIR/." "$DESTINATION_DIR"

cd "$DESTINATION_DIR" || exit
sudo nix flake update
sudo nixos-rebuild switch --flake "$DESTINATION_DIR#nixos"
