test:
  sudo nixos-rebuild test --flake . --upgrade --keep-going --max-jobs 16

switch:
  sudo nixos-rebuild switch --flake . --upgrade --keep-going --max-jobs 16
