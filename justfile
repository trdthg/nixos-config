test:
  sudo nixos-rebuild test --upgrade-all --flake . --max-jobs 16 --keep-going

switch:
  sudo nixos-rebuild switch --upgrade-all --flake . --max-jobs 16 --keep-going

update:
  sudo nix flake update