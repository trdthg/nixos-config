# rm ~/.config/sway/config
# mv -f ./pkgs/sway/config ~/.config/sway/config

case $1 in
"test")
  nixos-rebuild test -I ./configuration.nix --flake .
  ;;
"switch")
  nixos-rebuild switch -I ./configuration.nix --flake .
  ;;
esac
