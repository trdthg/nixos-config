{ config
, pkgs
, ...
}:
# let
#   android = pkgs.callPackage ./android.nix { };
# in
{
  imports = [
    ./java.nix
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
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common.default = "*";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
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
