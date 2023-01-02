{ config, pkgs, lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config =
      rec {
        modifier = "Mod4";
        # Use alacritty as default terminal
        # terminal = "alacritty";
        terminal = "kitty";
        left = "h";
        right = "l";
        up = "k";
        down = "j";

        defaultWorkspace = "workspace number 1";

        menu = '' wofi --show drun --lines=5 --prompt="" '';
        # menu = '' subemenu-run '';

        output = {
          eDP-1 = {
            pos = "0,0";
            mode = "2560x1600@60Hz";
          };
        };

        input = {
          "1267:12600:MSFT0001:00_04F3:3138_Touchpad" = {
            left_handed = "enabled";
            tap = "enabled";
            natural_scroll = "enabled";
            dwt = "enabled";
            accel_profile = "flat"; # disable mouse acceleration (enabled by default; to set it manually, use "adaptive" instead of "flat")
            pointer_accel = "0.5"; # set mouse sensitivity (between -1 and 1)
          };
        };

        floating = {
          modifier = "Mod4";
        };

        keybindings = {
          # "${modifier}+End" = "";

          # implement window switcher based on wofi
          # "${modifier}+Tab" = "exec ${wofiWindowJump}";

          # power menu
          # "${modifier}+F1" = "exec ${wofiPower}";

          # # clipboard history
          # "${modifier}+c" = "exec ${pkgs.clipman}/bin/clipman pick --tool wofi";

          ## Output pressed keycode using xev:
          ## nix-shell -p xorg.xev --run "xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"
          ## fn+F1    c:121   XF86AudioMute
          # "XF86AudioMute" = ''exec ${pamixer} --toggle-mute && ( ${pamixer} --get-mute && ${mywob} 0 ) || ${mywob} $(${pamixer} --get-volume)'';
          "XF86AudioMute" = '' exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle' '';
          ## fn+F2    c:122   XF86AudioLowerVolume
          # "XF86AudioLowerVolume" = ''exec ${pamixer} --allow-boost --unmute --decrease 2 && ${mywob} $(${pamixer} --get-volume)'';
          "XF86AudioLowerVolume" = '' exec 'pactl set-sink-volume @DEFAULT_SINK@ -10%' '';
          ## fn+F3    c:123   XF86AudioRaiseVolume
          # "XF86AudioRaiseVolume" = ''exec ${pamixer} --allow-boost --unmute --increase 2 && ${mywob} $(${pamixer} --get-volume)'';
          "XF86AudioRaiseVolume" = '' exec 'pactl set-sink-volume @DEFAULT_SINK@ +10%' '';
          ## fn+F4    c:198   XF86AudioMicMute
          # "XF86AudioMicMute" = ''exec ${pamixer} --default-source --toggle-mute && ( ${pamixer} --default-source --get-mute && ${mywob} 0 ) || ${mywob} $(${pamixer} --default-source --get-volume)'';
          ## fn+F5    c:232   XF86MonBrightnessDown
          # "--locked XF86MonBrightnessDown" = ''exec ${mywob} $(${brightnessctl} set 5%- | ${sed} -En 's/.*\(([0-9]+)%\).*/\1/p')'';
          ## fn+F6    c:233   XF86MonBrightnessUp
          # "--locked XF86MonBrightnessUp" = ''exec ${mywob} $(${brightnessctl} set +5% | ${sed} -En 's/.*\(([0-9]+)%\).*/\1/p')'';

          "XF86MonBrightnessDown" = "exec light -U 10";
          "XF86MonBrightnessUp" = "exec light -A 10";

          ## fn+F7    c:235   XF86Display
          ## fn+F8    c:246   XF86WLAN
          ## fn+F9    c:179   XF86Tools
          ## fn+F10   c:225   XF86Search
          ## fn+F11   c:128   XF86LaunchA
          ## fn+F12   c:152   XF86Explorer
          # "XF86Calculator" = "exec ${pkgs.gnome.gnome-calculator}/bin/gnome-calculator";
          # "XF86???Lock" = "";
          # "XF86HomePage" = "exec ${pkgs.firefox-wayland}/bin/firefox";
          # "XF86???FOLDER" = "";

          ## Screenshot
          "${modifier}+Print" = "exec grim -g \"$(slurp)\" - | wl-copy";
          # "${modifier}+Print" = '' exec grim  -g "$(slurp)" /tmp/$(date +'%H:%M:%S.png') - | wl-copy '';

          # "Print" = "exec ${grimshot} --notify save screen $(${xdg-user-dir} PICTURES)/$(TZ=utc date +'screenshot_%Y-%m-%d-%H%M%S.%3N.png')"; # All visible outputs
          # "Shift+Print" = "exec ${grimshot} --notify save area $(${xdg-user-dir} PICTURES)/$(TZ=utc date +'screenshot_%Y-%m-%d-%H%M%S.%3N.png')"; # Manually select a region
          # "Alt+Print" = "exec ${grimshot} --notify save active $(${xdg-user-dir} PICTURES)/$(TZ=utc date +'screenshot_%Y-%m-%d-%H%M%S.%3N.png')"; # Currently active window
          # "Shift+Alt+Print" = "exec ${grimshot} --notify save window $(${xdg-user-dir} PICTURES)/$(TZ=utc date +'screenshot_%Y-%m-%d-%H%M%S.%3N.png')"; # Manually select a window
          # "Ctrl+Print" = "exec ${grimshot} --notify copy screen";
          # "Ctrl+Shift+Print" = "exec ${grimshot} --notify copy area";
          # "Ctrl+Alt+Print" = "exec ${grimshot} --notify copy active";
          # "Ctrl+Shift+Alt+Print" = "exec ${grimshot} --notify copy window";

          ## Screen recording
          # "${modifier}+Print" = "exec wayrecorder --notify screen";
          # "${modifier}+Shift+Print" = "exec wayrecorder --notify --input area";
          # "${modifier}+Alt+Print" = "exec wayrecorder --notify --input active";
          # "${modifier}+Shift+Alt+Print" = "exec wayrecorder --notify --input window";
          # "${modifier}+Ctrl+Print" = "exec wayrecorder --notify --clipboard --input screen";
          # "${modifier}+Ctrl+Shift+Print" = "exec wayrecorder --notify --clipboard --input area";
          # "${modifier}+Ctrl+Alt+Print" = "exec wayrecorder --notify --clipboard --input active";
          # "${modifier}+Ctrl+Shift+Alt+Print" = "exec wayrecorder --notify --clipboard --input window";

          # "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl -s previous";
          # "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl -s next";
          # "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl -s play-pause";
          # "XF86AudioStop" = "exec ${pkgs.playerctl}/bin/playerctl -s stop";
          # "Control+XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl -s position 30-";
          # "Control+XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl -s position 30+";
          # "Control+XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl -s stop";

          # Start a terminal
          "${modifier}+Return" = "exec ${terminal}";

          # Kill focused window
          "${modifier}+Shift+q" = "kill";

          # Start your launcher
          "${modifier}+d" = "exec ${menu}";

          # Reload the configuration file
          "${modifier}+Shift+c" = "reload";

          # Exit sway (logs you out of your Wayland session)
          "${modifier}+Shift+e" = '' exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit' '';

          # "${modifier}+Escape" = "exec ${locksway}";
          # "${modifier}+Shift+Escape" = "exec ${locksway}";
          # "${modifier}+Shift+F1" = "exec ${pkgs.sway}/bin/swaynag -t warning -f 'Myosevka Proportional' -m 'Exit sway?' -b 'Yes' '${swaymsg} exit'";

          #
          # Layout stuff:
          #
          # You can "split" the current object of your focus with
          # $mod+b or $mod+v, for horizontal and vertical splits
          # respectively.
          "${modifier}+b" = "splith";
          "${modifier}+v" = "splitv";

          # Switch the current container between different layout styles
          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";

          "${modifier}+r" = "mode resize"; #??? or resize mode

          # Make the current focus fullscreen
          "${modifier}+f" = "fullscreen toggle";

          # Toggle the current focus between tiling and floating mode
          "${modifier}+Shift+space" = "floating toggle";


          # Swap focus between the tiling area and the floating area
          "${modifier}+space" = "focus mode_toggle";

          # Move focus to the parent container
          "${modifier}+a" = "focus parent";

          #
          # Scratchpad:
          #
          # Sway has a "scratchpad", which is a bag of holding for windows.
          # You can send windows there and get them back later.

          # Move the currently focused window to the scratchpad

          # "${modifier}+Shift+minus" = "exec ${outputScale} -.1";
          # "${modifier}+Shift+equal" = "exec ${outputScale} +.1";
          "${modifier}+Shift+minus" = "move scratchpad";
          # "${modifier}+Shift+Ctrl+equal" = "scratchpad show";

          # Show the next scratchpad window or hide the focused scratchpad window.
          # If there are multiple scratchpad windows, this command cycles through them.
          "${modifier}+minus" = "scratchpad show";

          "${modifier}+${left}" = "focus left";
          "${modifier}+${down}" = "focus down";
          "${modifier}+${up}" = "focus up";
          "${modifier}+${right}" = "focus right";
          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";

          "${modifier}+Shift+${left}" = "move left";
          "${modifier}+Shift+${down}" = "move down";
          "${modifier}+Shift+${up}" = "move up";
          "${modifier}+Shift+${right}" = "move right";
          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          # "${modifier}+a" = "workspace back_and_forth";
          # "${modifier}+l" = "workspace prev";
          # "${modifier}+y" = "workspace next";
          # "${modifier}+Prior" = "workspace prev"; # PgUp
          # "${modifier}+Next" = "workspace next"; # PgDown
          # "${modifier}+Ctrl+${left}" = "workspace prev";
          # "${modifier}+Ctrl+${right}" = "workspace next";
          # "${modifier}+Ctrl+Left" = "workspace prev";
          # "${modifier}+Ctrl+Right" = "workspace next";

          # Move whole workspace to other output
          "${modifier}+Alt+${up}" = "move workspace to output up";
          "${modifier}+Alt+${down}" = "move workspace to output down";
          "${modifier}+Alt+${left}" = "move workspace to output left";
          "${modifier}+Alt+${right}" = "move workspace to output right";
          "${modifier}+Alt+Up" = "move workspace to output up";
          "${modifier}+Alt+Down" = "move workspace to output down";
          "${modifier}+Alt+Left" = "move workspace to output left";
          "${modifier}+Alt+Right" = "move workspace to output right";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 10";
          # Note: workspaces can have any name you want, not just numbers.
          # We just use 1-10 as the default.
        };

        modes =
          {
            resize = {
              Down = "resize grow height 10 px";
              Left = "resize shrink width 10 px";
              Right = "resize grow width 10 px";
              Up = "resize shrink height 10 px";

              h = "resize shrink width 10 px";
              j = "resize grow height 10 px";
              k = "resize shrink height 10 px";
              l = "resize grow width 10 px";

              Escape = "mode default";
              Return = "mode default";
            };
          };

        bars = [
          {
            command = "swaybar_command waybar";
          }
        ];

        startup = [
          { command = "cfw"; }
          # { command = "fcitx5"; }
          { command = "wlpinyin"; }
          { command = "blueman-manager"; }
          { command = "systemctl --user import-environment"; }
          { command = "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK"; }
          { command = "dbus-sway-environment"; }
          { command = "configure-gtk"; }
          {
            command = '' \
              swayidle -w \
              timeout 600 'swaylock -f -c 000000' \
              timeout 1200 'swaymsg " output * dpms off "' \
              resume 'swaymsg " output * dpms on "' \
              before-sleep 'swaylock -f -c 000000'
            '';
          }
        ];
      };
  };
}
