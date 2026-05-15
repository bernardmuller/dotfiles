{ lib, pkgs, config, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec = [ "pkill --signal SIGUSR2 waybar" ];
    # bind = [ "SUPER, B, exec, pkill --signal SIGUSR1 waybar" ];
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [
      {
        layer = "top";
        height = 8;
        margin-right = 8;
        margin-left = 8;
        margin-top = 8;

        modules-left = [ "hyprland/workspaces" ];
        "hyprland/workspaces" = {
          persistent-workspaces."*" = 4;
        };

        modules-center = [ "hyprland/window" ];
        "hyprland/window" = {
          separate-outputs = true;
        };

        modules-right = [
          "tray"
          "pulseaudio"
          "cpu"
          "memory"
          "network"
          "backlight"
          "clock"
        ];

        tray = {
          reverse-direction = true;
          spacing = 5;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "{format_source} 󰸈";
          format-bluetooth = "󰋋 󰂯 {volume}%";
          format-bluetooth-muted = "󰟎 󰂯";
          # format-source       = "󰍬";
          # format-source-muted = "󰍭";
          format-icons.default = [ "󰕿" "󰖀" "󰕾" ];
        };

        backlight = {
          format = "{icon} {percent}%";
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
        };

        cpu.format = " {usage}%";
        memory.format = "  {}%";

        network = {
          format-disconnected = " ";
          format-ethernet = " {ipaddr}/{cidr}";
          format-wifi = " {signalStrength}%";
        };

        clock.tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      }
    ];

   style = # css
      ''
        * {
          border: none;
          border-radius: 4px;
          font-family: "JetBrainsMono Nerd Font";
        }
        .modules-right {
          margin-right: 8px;
        }
        #waybar {
          background: #1d2021;
          color: #ebdbb2;
        }
        #workspaces button:nth-child(1)  { color: #fb4934; }
        #workspaces button:nth-child(2)  { color: #fe8019; }
        #workspaces button:nth-child(3)  { color: #fabd2f; }
        #workspaces button:nth-child(4)  { color: #b8bb26; }
        #workspaces button:nth-child(5)  { color: #8ec07c; }
        #workspaces button:nth-child(6)  { color: #83a598; }
        #workspaces button:nth-child(7)  { color: #d3869b; }
        #workspaces button:nth-child(8)  { color: #d65d0e; }
        #workspaces button:nth-child(9)  { color: #a89984; }
        #workspaces button:nth-child(10) { color: #bdae93; }
        #workspaces label {
          font-family: "azukifontLB";
        }
        #workspaces button.empty {
          color: #504945;
        }
        #tray, #pulseaudio, #backlight, #cpu, #memory, #network, #clock {
          margin-left: 20px;
        }
      ''; 
  };
} 
