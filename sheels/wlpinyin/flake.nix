{
  description = "my project description";

  inputs = {
    # Nixpkgs，即 NixOS 官方软件源
    nixpkgs.url = "github:NixOS/nixpkgs/22.11";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

  };
  outputs = { self, nixpkgs, nixpkgs-unstable, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          unstable-pkgs = nixpkgs-unstable.legacyPackages.${system};
        in
        {
          devShells.default = import ./shell.nix {
            inherit pkgs;
            inherit unstable-pkgs;
          };
        }
      );
}
