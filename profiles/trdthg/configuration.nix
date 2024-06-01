# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../pkgs/default.nix
    ../../services/default.nix
  ];

  # For mount.cifs, required unless domain name resolution is not needed.
  # fileSystems."/mnt/Share" = {
  #   device = "//192.168.1.100";
  #   fsType = "cifs";
  #   options = [ "x-systemd.automount" "noauto" ];
  # };

  nix = {
    package = pkgs.git;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      trusted-users = [ "trdthg" ];
    };
    # pkgs.nixVersions.nix_2_17;
    gc = {
      automatic = true;
      dates = "weekly";
      options = ''
        --delete-older-than 14d
      '';
    };
    extraOptions = "\n";
  };

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
    permittedInsecurePackages = [ "nodejs-16.20.2" ];
    packageOverrides = pkgs: {
      # warp-beta = import (fetchTarball "https://github.com/imadnyc/nixpkgs/archive/refs/heads/warp-terminal-initial-linux.zip") {
      #   config = config.nixpkgs.config;
      # };
    };
  };

  networking = {
    # Define your hostname.
    hostName = "nixos";

    interfaces = {
      wlp1s0.ipv4.addresses = [
        {
          address = "192.168.0.23";
          prefixLength = 24;
        }
      ];
    };
    firewall = {
      # Or disable the firewall altogether.
      enable = false;
      # Open ports in the firewall.
      allowedTCPPorts = [
        80
        443
        7500
        7890
      ];
      allowedTCPPortRanges = [
        {
          from = 50000;
          to = 51000;
        }
        {
          from = 8000;
          to = 8010;
        }
      ];
      allowedUDPPortRanges = [
        # { from = 8000; to = 8010; }
      ];
    };
    #     extraCommands = ''
    # iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 172.17.0.1:80
    # iptables -t nat -A POSTROUTING -p tcp -d 172.17.0.1 --dport 80 -j SNAT --to-source 192.168.12.87

    # Pick only one of the below networking options.
    networkmanager = {
      enable = true; # Easiest to use and most distros use this by default.
    };

    wireless = {
      enable = false; # Enables wireless support via wpa_supplicant.
      networks = {
        "trdthg-lg".psk = "12345678";

        # "408GreatWall".psk = "408408408";
        # "408".psk = "504504504";
        "405".psk = "bigdatab405";

        "Bonbon_5G".psk = "BonBon20150920";
        "bonbon".psk = "BonBon816";

        "TP-LINK_7A1F".psk = "4602yyds";

        "hy13911345854".psk = "hy13911345854";

        "Xiaomi_B7A8".psk = "hk123456";
      };
    };
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
      "1.1.1.1"
    ];
    extraHosts = ''
      140.82.113.4 github.com
    '';
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  networking.proxy.default = "http://127.0.0.1:17890";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain,::1";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  #
  # Fix sway home-manager problems
  #
  # Fix pointer can't display
  hardware.opengl = {
    enable = true;
    driSupport = true;
    # steam client need this
    driSupport32Bit = true;
    # extraPackages = with pkgs; [
    #   libGL
    # ];
    # setLdLibraryPath = true;
  };

  # Fix swaylock can't unlock
  # Allow swaylock to unlock the computer for us
  security.pam.services.swaylock = {
    text = "auth include login";
  };
  # security.pki.certificateFiles = [ /etc/ssl/certs/mycert.pem ];
  #
  # video, audio and bluetooth
  #
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable sound.
  # sound.enable = true;
  hardware.pulseaudio = {
    enable = false;
    extraModules = [ ];
    package = pkgs.pulseaudioFull;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.polkit.enable = true;

  services.dbus.enable = true;
  #
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  #
  # font and input
  #
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      # fcitx5-rime
      fcitx5-chinese-addons
    ];
    # enabled = "ibus";
    # ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
  };

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      font-awesome
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      source-han-sans
      source-han-serif

      nerdfonts
      # (nerdfonts.override { fonts = [ "DroidSansMono" ]; })

      # for steam chinese font
      wqy_zenhei
    ];
    # fontconfig = {
    #   defaultFonts = {
    #     emoji = [ "Noto Color Emoji" ];
    #     monospace = [
    #       "Noto Sans Mono CJK SC"
    #       "Sarasa Mono SC"
    #       "DejaVu Sans Mono"
    #     ];
    #     sansSerif = [
    #       "Noto Sans CJK SC"
    #       "Source Han Sans SC"
    #       "DejaVu Sans"
    #       "WenQuanYi Zen Hei"
    #     ];
    #     serif = [
    #       "Noto Serif CJK SC"
    #       "Source Han Serif SC"
    #       "DejaVu Serif"
    #       "WenQuanYi Zen Hei"
    #     ];
    #   };
    # };
  };

  #
  # shell, pkgs and env
  #
  users.defaultUserShell = pkgs.zsh;
  programs.light.enable = true;

  programs.zsh.enable = true;
  # users.defaultUserShell = pkgs.zsh;
  users.users.trdthg.shell = pkgs.zsh;
  programs.adb.enable = true;
  # add a shell to /etc/shells
  environment.shells = with pkgs; [ zsh ];

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.trdthg = {
    isNormalUser = true;
    home = "/home/trdthg";
    password = "1789";
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "docker"
      "adbusers"
      "libvirtd"
      # 访问串口权限
      "dialout"
      # lxc
      "lxd"
    ]; # Enable 'sudo' for the user.

    packages = with pkgs; [
      # --------------------------- nix
      nixfmt-rfc-style
      nixd

      #---------------------------- system
      # polkit
      polkit_gnome
      alsa-oss
      cifs-utils
      # gnome.gnome-shell-extensions
      # gnomeExtensions.appindicator

      #---------------------------- basic libs
      # glib
      # glibc
      libclang
      # for nix-ld lldb
      zlib
      # xz # libzima
      # for rust and libcrypto
      openssl
      # openssl_1_1
      # libxcrypt
      # libxcrypt-legacy

      #---------------------------- build tool/env
      gnumake
      cmake
      # ninja
      # meson
      pkg-config
      jq
      file
      steam-run
      docker-compose

      #---------------------------- user app
      pkgs.trdthgNur.wlpinyin

      firefox
      google-chrome
      tdesktop
      vlc
      simple-http-server
      # realvnc-vnc-viewer
      obs-studio
      localsend
      warp-terminal
      fastfetch
      libvirt
      virt-manager
      virt-viewer

      # texlive.combined.scheme-full
      # wdisplays
      # wlr-randr
      # thunderbird
      # vscode
      # vscode-fhs

      # --------------------------- services
      clash-meta
      # code-server
      frp
      webssh

      # --------------------------- tools
      p7zip
      zip
      dig
      minicom
      socat

      tokei
      # zellij
      imgcat
      dust
      tmux
      tmate
      ripgrep
      bat
      autocorrect
      wayvnc

      # --------------------------- develop
      # bash
      nodePackages.bash-language-server
      shellcheck

      # c
      gcc
      gdb
      clang
      clang-tools
      lldb

      # go
      go
      gopls
      grpcurl
      protobuf
      protoc-gen-go-grpc
      delve

      # rust openssl
      rustup
      cargo
      # rust-analyzer

      # zig
      zig
      zls

      # perl
      perl536Packages.PLS

      # openssl
      # expat
      # fontconfig

      # flutter
      # dart

      # js/ts
      nodejs_20
      yarn
      bun
      nodePackages.pnpm
      nodePackages.typescript
      # deno

      # python
      python310
      # rye
      # pyright
      # poetry

      # java
      # maven
      # this doesn't automatically add JAVA_HOME to the environment
      # latest jdk for vscode java lsp, jdk17 on write,
      # jdk17

      # haskell
      # stack
      # haskellPackages.ghcup
      # haskellPackages.hls

      # (vscode-with-extensions.override {
      #   vscodeExtensions = with vscode-extensions; [
      #     ms-vscode.cpptools
      #     llvm-vs-code-extensions.vscode-clangd
      #   ];
      # })
    ];
  };

  # programs.nix-ld.enable = true;
  environment.variables = {
    # LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
    NIXPKGS_ALLOW_INSECURE = "1";
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";

    # Set the default browser to Firefox.
    # BROWSER = "firefox";
    # BROWSER = "chromium";
    BROWSER = "google-chrome";
    # for default apps, plrease refer to  ~/.config/mimeapps.list
    DEFAULT_BROWSER = "google-chrome";

    # set gtk protal
    GTK_USE_PORTAL = "1";
    USE_GTK_PORTAL = "1";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    extraConfig = ''
      AcceptEnv LD_LIBRARY_PATH LD_PRLEOAD ASDSASDDS
    '';
  };

  services.logind.lidSwitch = "ignore";
  # Custom services
  services.frpc.enable = true;
  # services.vscode-server.enable = true;
  services.clash.enable = true;
  services.swayheadless.enable = true;
  services.wayvnc.enable = true;
  services.webssh.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "unstable"; # Did you read the comment?
}
