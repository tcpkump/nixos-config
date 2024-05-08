{ ...}:
let user = "garrettleber"; in

{
  home-manager.users.${user}.programs.waybar = {
    enable = true;
    style = ./waybar-style.css;
    settings = {
      mainBar = {
        height = 41; # Waybar height (to be removed for auto height)
        spacing = 0; # Gaps between modules (0px)
        modules-left = ["hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = [
          "network"
          "pulseaudio"
          "cpu"
          "memory"
          "disk"
          "temperature"
          "battery"
          "tray"
        ];

        # Modules configuration
        "hyprland/workspaces" = {
            "on-click" = "activate";
            "disable-scroll" = true;
            "all-outputs" = true;
            "warp-on-scroll" = false;
        };
        tray = {
            "spacing" = 10;
        };
        clock = {
            "timezone" = "America/Indiana/Indianapolis";
            "format" = "{:%a %b %e %I:%M:%S %p}";
            "interval" = 1;
            "tooltip-format" = "<tt><small>{calendar}</small></tt>";
            "format-alt" = "{:%Y-%m-%d}";
        };
        pulseaudio = {
            "format" = "{volume}% {icon} {format_source}";
            "format-bluetooth" = "{volume}% {icon}";
            "format-muted" = "";
            "format-source" = " {volume}% ";
            "format-source-muted" = " ";
            "format-icons" = {
                "headphone" = "";
                "hands-free" = "";
                "headset" = "";
                "phone" = "";
                "portable" = "";
                "car" = "";
                "default" = ["" ""];
            };
            "scroll-step" = 1;
            "on-click" = "pavucontrol";
            "ignored-sinks" = ["Easy Effects Sink"];
        };
        cpu = {
            "format" = "{usage}% ";
            "tooltip" = true;
        };
        memory = {
            "format" = "{}% ";
        };
        disk = {
            "format" = "{percentage_used}% ";
        };
        temperature = {
            "critical-threshold" = 80;
            "format" = "{temperatureC}°C {icon}";
            "format-icons" = ["" "" ""];
        };
        battery = {
            "states" = {
                "warning" = 30;
                "critical" = 15;
            };
            "format" = "{capacity}% {icon}";
            "format-charging" = "{capacity}% ";
            "format-plugged" = "{capacity}% ";
            "format-alt" = "{time} {icon}";
            "format-icons" = ["" "" "" "" ""];
        };
        network = {
            "format-wifi" = "{essid} ({signalStrength}%) ";
            "format-ethernet" = "{ipaddr} ";
            "tooltip-format" = "{ifname} via {gwaddr} ";
            "format-linked" = "{ifname} (No IP) ";
            "format-disconnected" = "Disconnected ⚠";
            "format-alt" = "{ifname} = {ipaddr}/{cidr}";
        };
      };
    };
  };
}

