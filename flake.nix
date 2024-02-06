{
  description = "Trdthg's NixOS Flake";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org/"
      # replace official cache with a mirror located in China
      "https://mirrors.ustc.edu.cn/nix-channels/store"
    ];

    # nix community's cache server
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # 输入配置，即软件源
  inputs = {
    # Nixpkgs，即 NixOS 官方软件源
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/xxxx";

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

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # 输出配置，即 NixOS 系统配置
  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , nur
    , trdthgNur
    , nix-ld
    , ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      unstable = import nixpkgs-unstable
        {
          inherit system;
        };
    in
    {
      # 定义一个名为 nixos 的系统
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # inherit system;
        specialArgs = { inherit unstable; };
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
            home-manager.extraSpecialArgs = {
              inherit unstable;
            };
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }

          # nur
          nur.nixosModules.nur
          ({ config, ... }: {
            environment.systemPackages = [
              # config.nur.repos.linyinfeng.clash-premium
              # config.nur.repos.linyinfeng.clash-for-windows
              # config.nur.repos.linyinfeng.wemeet
              # config.nur.repos.xddxdd.dingtalk
              # config.nur.repos.xddxdd.wechat-uos
            ];
          })

          nix-ld.nixosModules.nix-ld
          {
            programs.nix-ld.dev.enable = true;
          }
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
