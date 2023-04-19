# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [
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
    package = pkgs.nixUnstable;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = ''
        --delete-older-than 14d
      '';
    };
    extraOptions = ''

    '';
  };

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };
  nixpkgs.config.permittedInsecurePackages = [
    "python3.10-poetry-1.2.2"
  ];

  networking = {
    # Define your hostname.
    hostName = "nixos";


    firewall = {
      # Or disable the firewall altogether.
      enable = false;
      # Open ports in the firewall.
      allowedTCPPorts = [ 7890 ];
      allowedUDPPorts = [ 7890 ];
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
    nameservers = [ "1.1.1.1" "8.8.8.8" "8.8.4.4" ];
    extraHosts =
      ''
        # 127.0.0.1 55e19a41e9ef
      '';
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://192.168.1.105:7890";
  networking.proxy.default = "http://127.0.0.1:7890";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain,::1";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

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

  #
  # video, audio and bluetooth
  #
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio = {
  #   enable = true;
  #   extraModules = [ ];
  #   package = pkgs.pulseaudioFull;
  # };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.polkit.enable = true;
  services.dbus.enable = true;
  services.gnome.gnome-keyring.enable = true;

  #
  # font and input
  #
  # i18n.inputMethod = {
  #   enabled = "fcitx5";
  #   fcitx5.enableRimeData = true;
  #   fcitx5.addons = with pkgs; [
  #     fcitx5-rime
  #     fcitx5-chinese-addons
  #   ];
  #   # enabled = "ibus";
  #   # ibus.engines = with pkgs.ibus-engines; [
  #   #   libpinyin
  #   # ];
  # };

  fonts = {
    enableDefaultFonts = true;
    fontconfig = {
      defaultFonts = {
        serif = [ "noto-fonts" "noto-fonts-emoji" "Noto Sans CJK SC" "WenQuanYi Zen Hei" ];
        sansSerif = [ "noto-fonts" "noto-fonts-emoji" "Noto Sans CJK SC" "WenQuanYi Zen Hei" ];
        monospace = [ "JetBrainsMono NerdFont" "Noto Sans Mono CJK SC" ];
      };
    };
    fonts = with pkgs; [
      font-awesome
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      nerdfonts
      # (nerdfonts.override { fonts = [ "DroidSansMono" ]; })

      # for steam chinese font
      wqy_zenhei
    ];
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
    extraGroups = [ "wheel" "video" "audio" "docker" "adbusers" "libvirtd" ]; # Enable 'sudo' for the user.
    packages = with pkgs; [
      cifs-utils

      glib
      glibc
      # for nix-ld lldb
      zlib

      nixpkgs-fmt
      gnumake
      cmake
      ninja
      meson
      pkg-config
      jq
      steam-run

      #
      alsa-oss

      docker-compose

      pkgs.trdthgNur.wlpinyin

      firefox
      google-chrome
      tdesktop
      vscode

      clash
      code-server
      frp

      p7zip
      zip

      tokei
      zellij
      # yuzu-ea
      # steam and gamepad
      steam
      xboxdrv

      neofetch
      # wdisplays
      # wlr-randr
      # thunderbird
    ] ++ (import ../../pkgs/development.nix {
      config = config;
      pkgs = pkgs;
    }).extraPackages;
  };

  # programs.nix-ld.enable = true;
  environment.variables = {
    NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.stdenv.cc.cc
    ];
    NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
    LD_LIBRARY_PATH = ''$LD_LIBRARY_PATH:${
      pkgs.lib.makeLibraryPath  [
        pkgs.zlib
      ]
    }'';
  };


  environment.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";

    # Set the default browser to Firefox.
    # BROWSER = "firefox";
    # BROWSER = "chromium";
    BROWSER = "google-chrome";

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
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;

  services.logind.lidSwitch = "ignore";
  # Custom services
  services.frpc.enable = true;
  services.vscode-server.enable = true;
  services.clash.enable = true;

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
  system.stateVersion = "22.11"; # Did you read the comment?

}
