{ config, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    style = ''

      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif Source Code Pro;
          font-size: 12px;
          border: none;
          border-radius: 0;
      }

      window#waybar {
          background-color: black;
          border-bottom: 0px solid rgba(10, 114, 125, 0.5);
          color: #ffffff;
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      /*
      window#waybar.empty {
          background-color: transparent;
      }
      window#waybar.solo {
          background-color: #FFFFFF;
      }
      */

      window#waybar.termite {
          background-color: #3F3F3F;
      }

      window#waybar.chromium {
          background-color: #000000;
          border: none;
      }

      button {
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;
          /* Avoid rounded borders under each button name */
          border: none;
          border-radius: 7;
          margin: 3;
          margin-left: 3;
          margin-right: 3;
          opacity: 1;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
          background: inherit;
      }

      #workspaces button {
          padding: 0 5px;
          background-color: transparent;
          color: #ffffff;
      }

      #workspaces button:hover {
          background: #dddddd;
          color: #000000;
      }

      #workspaces button.focused {
          background-color: #ffffff;
          color: #000000;
      }

      #workspaces button.urgent {
          background-color: #eb4d4b;
      }

      #mode {
          background-color: #64727D;
          border-bottom: 0px solid #ffffff;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #mpd {
          padding: 0 8px;
          color: #ffffff;
      }

      #window,
      #workspaces {
          margin: 0 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #clock {
          background-color: #64727D;
      }

      #battery {
          background-color: #ffffff;
          color: #000000;
      }

      #battery.charging, #battery.plugged {
          color: #ffffff;
          background-color: #26A65B;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }

      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      label:focus {
          background-color: #000000;
      }

      #cpu {
          background-color: #2ecc71;
          color: #000000;
      }

      #memory {
          background-color: #9b59b6;
      }

      #disk {
          background-color: #964B00;
      }

      #backlight {
          background-color: #90b1b1;
          color: #000000;
      }

      #network {
          background-color: #2980b9;
      }

      #network.disconnected {
          background-color: #f53c3c;
      }

      #pulseaudio {
          background-color: #f1c40f;
          color: #000000;
      }

      #pulseaudio.muted {
          background-color: #90b1b1;
          color: #2a5c45;
      }

      #wireplumber {
          background-color: #fff0f5;
          color: #000000;
      }

      #wireplumber.muted {
          background-color: #f53c3c;
      }

      #custom-media {
          background-color: #66cc99;
          color: #2a5c45;
          min-width: 100px;
      }

      #custom-media.custom-spotify {
          background-color: #66cc99;
      }

      #custom-media.custom-vlc {
          background-color: #ffa000;
      }

      #temperature {
          background-color: #f0932b;
          color: #000000;
      }

      #temperature.critical {
          background-color: #eb4d4b;
      }

      #tray {
          background-color: black;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #eb4d4b;
      }

      #idle_inhibitor {
          background-color: #2d3436;
      }

      #idle_inhibitor.activated {
          background-color: #ecf0f1;
          color: #2d3436;
      }

      #mpd {
          background-color: #66cc99;
          color: #2a5c45;
      }

      #mpd.disconnected {
          background-color: #f53c3c;
      }

      #mpd.stopped {
          background-color: #90b1b1;
      }

      #mpd.paused {
          background-color: #51a37a;
      }

      #language {
          background: #00b093;
          color: #740864;
          padding: 0 5px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state {
          background: #97e1ad;
          color: #000000;
          padding: 0 0px;
          margin: 0 5px;
          min-width: 16px;
      }

      #keyboard-state > label {
          padding: 0 5px;
      }

      #keyboard-state > label.locked {
          background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad {
          background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad.empty {
      	background-color: transparent;
      }

    '';
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        # width = 1280;
        # spacing = 4;

        # output = [
        #   "eDP-1"
        #   "HDMI-A-1"
        # ];

        modules-left = [
          "cpu"
          "memory"
          "temperature"
          "idle_inhibitor"
          # "sway/mode"
          # "custom/media"
          # "keyboard-state"
        ];
        modules-center = [
          "sway/workspaces"
          # "sway/window"
          # "wlr/taskbar"
          # "sway/scratchpad"
          # "custom/hello-from-waybar"
        ];
        modules-right = [
          # "custom/mymodule#with-css-id"
          # "mpd"
          # "keyboard-state"
          "pulseaudio"
          "network"
          "backlight"
          "battery"
          "battery#bat2"
          "clock"
          "tray"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };

        "sway/mode" = {
          "format" = '' <span style="italic">mode: {}</span> '';
          "format-alt" = '' <span style="italic">mode: {}</span> '';
        };

        "keyboard-state" = {
          "numlock" = true;
          "capslock" = true;
          "format" = "{name}-{icon}";
          "format-alt" = "{name}-{icon}";
          "format-icons" = {
            "locked" = "Lock";
            "unlocked" = "Unlock";
          };
        };

        "sway/scratchpad" = {
          "format" = "{icon} {count}";
          "show-empty" = false;
          "format-icons" = [ "" "" ];
          "tooltip" = true;
          "tooltip-format" = "{app}: {title}";
        };

        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };
        "tray" = {
          "spacing" = 10;
        };
        "clock" = {
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "format-alt" = "{:%Y-%m-%d}";
        };
        "cpu" = {
          "format" = " {usage}%";
          "tooltip" = false;
          "format-alt" = " {usage}%";
        };
        "memory" = {
          "format" = " {}% ";
          "format-alt" = " {}% ";
        };
        "temperature" = {
          "critical-threshold" = 60;
          "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
          "format" = "{icon} {temperatureC}°C";
          "format-alt" = "{icon} {temperatureC}°C";
          "format-icons" = [ "" "" "" ];
        };
        "backlight" = {
          "format" = "{icon} {percent}%";
          "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
          "format-alt" = "{icon} {percent}%";
        };
        "battery" = {
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{icon} {capacity}%";
          "format-charging" = " {capacity}%";
          "format-plugged" = " {capacity}% ";
          "format-alt" = "{icon} {time}";
          "format-icons" = [ "" "" "" "" "" ];
        };
        "battery#bat2" = {
          "bat" = "BAT2";
        };
        "network" = {
          "format-wifi" = "  {essid} ({signalStrength}%)";
          "format-ethernet" = " {ipaddr}/{cidr}";
          "tooltip-format" = " {ifname} via {gwaddr}";
          "format-linked" = " {ifname} (No IP)";
          "format-disconnected" = "⚠ Disconnected";
          "format-alt" = "  {ifname}: {ipaddr}/{cidr}";
        };

        "pulseaudio" = {
          "format" = "{icon} {volume}% {format_source}";
          "format-bluetooth" = "{icon} {volume}%  {format_source}";
          "format-bluetooth-muted" = " {icon} {format_source}";
          "format-muted" = " {format_source}";
          "format-source" = " {volume}%";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ "" "" "" ];
          };
          "on-click" = "pavucontrol";
        };

        "custom/media" =
          {
            "format" = "{icon} {}";
            "format-alt" = "{icon} {}";
            "return-type" = "json";
            "max-length" = 40;
            "format-icons" = {
              "spotify" = "";
              "default" = "🎜";
            };
            "escape" = true;
            "exec" = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
          };

        "custom/hello-from-waybar" = {
          format = "hello {}";
          max-length = 40;
          interval = "once";
          exec = pkgs.writeShellScript "hello-from-waybar" ''
            echo "from within waybar"
          '';
        };
      };
    };
  };
}


# // Modules configuration
# // "sway/workspaces"= {
# //     "disable-scroll"= true
# //     "all-outputs"= true
# //     "format"= "{name}= {icon}"
# //     "format-icons"= {
# //         "1"= ""
# //         "2"= ""
# //         "3"= ""
# //         "4"= ""
# //         "5"= ""
# //         "urgent"= ""
# //         "focused"= ""
# //         "default"= ""
# //     }
# // }
