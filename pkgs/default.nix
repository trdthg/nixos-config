{ config
, pkgs
, ...
}:
let
  # android = pkgs.callPackage ./android.nix { };
  getip = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/getip";
    executable = true;
    text =
      let
        A = 42;
      in
      ''
        ip addr | grep inet | grep -v 127.0.0.1 | grep -v inet6 | grep `ip route | grep '^default' | awk '{print $5}'` | awk '{print $2}' | awk -F '/' '{print $1}'
      '';
  };
in
{
  imports = [
    ./docker.nix
  ];

  xdg.mime.defaultApplications = {
    "application/pdf" = "firefox.desktop";
    "image/png" = [
      "swayimg"
      # "sxiv.desktop"
      # "gimp.desktop"
    ];
    "image/jpg" = [
      "swayimg"
    ];
  };

  xdg.portal = {
    enable =  true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [
      # pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common.default = "*";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    getip

    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    tree
    wget
    unzip
    lsof

    ninja
    cmake
    just
    gettext

    # ffmpeg
    # v4l-utils

    appimage-run
    pulseaudioFull

    # texlive.combined.scheme-full

    # Android
    # android-tools
    # android.platform-tools

    #
    # add ranger file icon support
    #
    # git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
    # echo "default_linemode devicons" >> $HOME/.config/ranger/rc.conf
    # ranger
    # kitty can preview images in ranger
    # remember to write `set preview_images_method kitty` in ~/.config/ranger/rc.conf
    kitty
    yazi

    # a img viwer
    swayimg
    bottom
    pkgs.htop

    # fhs
    (
      let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSUserEnv (base // {
        name = "fhs";
        targetPkgs = pkgs: (
          # pkgs.buildFHSUserEnv 只提供一个最小的 FHS 环境，缺少很多常用软件所必须的基础包
          # 所以直接使用它很可能会报错
          #
          # pkgs.appimageTools 提供了大多数程序常用的基础包，所以我们可以直接用它来补充
          (base.targetPkgs pkgs) ++ [
            pkgs.pkg-config
            pkgs.ncurses
            # 如果你的 FHS 程序还有其他依赖，把它们添加在这里
            pkgs.curl
          ]
        );
        profile = "export FHS=1";
        runScript = "bash";
        extraOutputsToInstall = [ "dev" ];
      })
    )
  ] ++ (import ./sway.nix {
    config = config;
    pkgs = pkgs;
  }).extraPackages;

  environment.variables = {
    # ANDROID_HOME = "${android.androidsdk}/libexec/android-sdk";
    # PATH = "$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools";
    # ANDROID_AVD_HOME = "$HOME/.android/avd";
    # JAVA_HOME = pkgs.jdk11;
  };
}
