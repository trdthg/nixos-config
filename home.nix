{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "trdthg";
  home.homeDirectory = "/home/trdthg";

  #home.packages = [                               1
    # pkgs.htop
  #];

  programs.zsh = {
    enable = true;
    initExtra = ''
      export GTK_IM_MODULE=ibus
      export XMODIFIERS=@im=ibus
      export QT_IM_MODULE=ibus
      ibus-daemon -d -x

      # export GDK_SCALE=2
      # export GDK_DPI_SCALE=0.5

      export MOZ_ENABLE_WAYLAND=1
    '';
    shellAliases = {
      ll = "ls -l";
      # update = "sudo nixos-rebuild switch";
      chrome = "google-chrome-stable --enable-features=UseOzonePlatform --ozone-platform=wayland";
    };
    history = {
      size = 10000;
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        # { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "python" "man"];
      theme = "mira";
    };
  };

  programs.git = {
    enable = true;
    userName = "trdthg";
    userEmail = "trdthg47@gmail.com";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
