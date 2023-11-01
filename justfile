# 	I can confirm nix-store --repair-path on the path above did work around the issue for me (until next gc?); I didn't need to downgrade to nix_2_17, at least while the path is available.

# @qbit
# qbit last month
# I can confirm nix-store --repair-path on the path above did work around the issue for me (until next gc?); I didn't need to downgrade to nix_2_17, at least while the path is available.

# Re the path, are you sure the next one isn't a different bash output? At first I thought it didn't work because there was -info and -man variations.

test:
    sudo NIXPKGS_ALLOW_INSECURE=1 nixos-rebuild test --upgrade-all --flake . --impure --max-jobs 16 --keep-going

switch:
    sudo NIXPKGS_ALLOW_INSECURE=1 nixos-rebuild switch --upgrade-all --flake . --impure --max-jobs 16 --keep-going

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
    sudo nix-store --query --roots {{pkg}}
delete-pkg pkg:
    sudo nix-store --delete --ignore-liveness {{ pkg }}
