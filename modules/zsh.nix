{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    initExtra = ''
      export GTK_IM_MODULE=ibus
      export XMODIFIERS=@im=ibus
      export QT_IM_MODULE=ibus

      # export GDK_SCALE=2
      # export GDK_DPI_SCALE=0.5

      export MOZ_ENABLE_WAYLAND=1

      export PATH="$PATH:$HOME/bin"

      # flutter chrome alias
      export CHROME_EXECUTABLE="google-chrome-stable";

    '';
    shellAliases = {
      ll = "ls -l";
      # update = "sudo nixos-rebuild switch";
      chrome = "google-chrome-stable --enable-features=UseOzonePlatform --ozone-platform=wayland --password-store=basic";
    };
    history = {
      size = 10000;
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        # { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "python" "man" ];
      theme = "mira";
    };
  };
}
