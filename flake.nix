{
  description = "Trdthg's NixOS Flake";

  # 输入配置，即软件源
  inputs = {
    # Nixpkgs，即 NixOS 官方软件源
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nur
    nur.url = "github:nix-community/NUR";

    # trdthg-nur
    trdthgNur = {
      url = "github:trdthg/trdthg-nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # 输出配置，即 NixOS 系统配置
  outputs = { self, nixpkgs, home-manager, nur, trdthgNur, ... }: {
    # 定义一个名为 nixos 的系统
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # 自己的 nur
        ({
          nixpkgs.overlays = [
            (final: prev: {
              trdthgNur = trdthgNur.packages."${prev.system}";
            })
          ];
        })

        # configuration.nix
        ./profiles/trdthg/configuration.nix

        # home-manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.trdthg = import ./profiles/trdthg/home.nix;

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }

        # nur
        nur.nixosModules.nur
        ({ config, ... }: {
          environment.systemPackages = [
            # config.nur.repos.linyinfeng.clash-premium
            config.nur.repos.linyinfeng.clash-for-windows
            config.nur.repos.linyinfeng.wemeet
            # config.nur.repos.xddxdd.dingtalk
          ];
        })

      ];
    };

    # 你也可以在同一份 Flake 中定义好几个系统，NixOS 会根据主机名 Hostname 决定用哪个
    # nixosConfigurations."nixos2" = nixpkgs.lib.nixosSystem {
    #   system = "x86_64-linux";
    #   modules = [
    #     ./configuration2.nix
    #   ];
    # };
  };
}
