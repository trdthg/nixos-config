#!/bin/sh

# cp ./pkgs/sway/config ~/.config/sway/config

case $1 in
"test")
  nixos-rebuild test --flake .
  ;;
"switch")
  nixos-rebuild switch --flake .
  ;;
esac
