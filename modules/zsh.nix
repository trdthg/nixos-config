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

      # bin
      export PATH="$PATH:$HOME/bin"
      export PATH="$PATH:$HOME/.yarn/bin"
      # go
      # export GOPATH=$HOME/go
      export PATH=$GOPATH/bin:$PATH
      export PATH=$HOME/go/bin:$PATH
      # rust
      export PATH="$PATH:$HOME/.cargo/bin"
      # flutter
      # export PATH="$PATH:$HOME/bin/flutter/github/flutter/bin"

      # flutter chrome alias
      export CHROME_EXECUTABLE="google-chrome-stable";
      echo $LD_LIBRARY_PATH
      unset LD_LIBRARY_PATH

      TMUX_SESSION_NAME=$USER-tmux-session-$(echo "$(pwd)" | shasum | cut -f1 -d" ")
      if [[ -n "$PS1" ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]]; then
          tmux attach-session -t $TMUX_SESSION_NAME || tmux new-session -s $TMUX_SESSION_NAME
      fi
    '';
    shellAliases = {
      ll = "ls -l";
      gcn = "git clone";
      pcgu = "wl-copy $((wl-paste > ~/tmp/screenshot.png && picgo u ~/tmp/screenshot.png ) | tail -1)";
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
      theme = "ys";
    };
  };
}
