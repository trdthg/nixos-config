test:
  sudo nixos-rebuild test --upgrade-all --flake . --max-jobs 16 --keep-going

switch:
  sudo nixos-rebuild switch --upgrade-all --flake . --max-jobs 16 --keep-going

update:
  sudo nix flake update

delete-old-generations:
	sudo nix-env -p /nix/var/nix/profiles/system --delete-generations 1
list-generations:
	sudo nix-env -p /nix/var/nix/profiles/system --list-generations
clean-garbage:
	# nix-collect-garbage  --delete-old
	# nix-collect-garbage  --delete-generations 1 2 3
	sudo nix-collect-garbage -d
query-pkg-dependence pkg:
	# /nix/store/1zssgssx3p3lv2yqal0dk1n2d1xz5vrs-wlpinyin-0.1.0.drv
	nix-store --query --roots {{pkg}}
delete-pkg pkg:
	nix-store --delete --ignore-liveness {{ pkg }}