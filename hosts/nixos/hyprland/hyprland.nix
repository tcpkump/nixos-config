{ pkgs, ... }:

let user = "garrettleber"; in
{
  imports = [
    ./swaylock/swaylock.nix
    ./waybar/waybar.nix
  ];

  programs.hyprland.enable = true;
  home-manager.users.${user} = {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;

      systemd.enable = true; # Whether to enable hyprland-session.target on hyprland startup
      systemd.variables = ["--all"]; # for swayidle

      extraConfig = builtins.readFile ./hyprland.conf;
    };
    programs.wofi.enable = true;
    services.dunst = {
      enable = true;
      settings = {
        global = {
          follow = "mouse";
          geometry = "300x30-5+60";
          frame_width = 1;
          frame_color = "#4287f5";
          sort = "yes";
          font = "Fira Mono 10";
          line_height = 0;
          markup = "full";
          format = "<b>%a</b>\n<i>%s</i>\n%b";
          alignment = "center";
          vertical_alignment = "center";
          word_wrap = "no";
          ellipsize = "middle";
          ignore_newline = "no";
          stack_duplicates = true;
          hide_duplicate_count = true;
          browser = "firefox -new-tab";
          corner_radius = 15;

          mouse_left_click = "close_current";
          mouse_right_click = "do_action";
          mouse_middle_click = "do_action";
        };
        urgency_normal = {
          background = "#202632";
          foreground = "#ffffff";
          timeout = 5;
        };
        urgency_critical = {
          background = "#ffffff";
          foreground = "#db0101";
          timeout = 0;
        };
        play_sound = {
          summary = "*";
          script = "~/.config/dunst_custom/alert.sh";
        };
      };
    };
    services.easyeffects.enable = true;

    # set cursor size and dpi for 4k monitor
    xresources.properties = {
      "Xcursor.size" = 16;
      "Xft.dpi" = 172;
    };

    services.kanshi = {
      enable = true;
      settings = [
        {
          profile.name = "docked";
          profile.outputs = [
            {
              criteria = "DP-2";
              scale = 1.5;
              status = "enable";
            }
            {
              criteria = "eDP-1";
              scale = 1.25;
              status = "enable";
            }
          ];
          profile.exec = [
            "${pkgs.hyprland}/bin/hyprctl dispatch moveworkspacetomonitor \"1 DP-2\""
            "${pkgs.hyprland}/bin/hyprctl dispatch moveworkspacetomonitor \"2 DP-2\""
            "${pkgs.hyprland}/bin/hyprctl dispatch moveworkspacetomonitor \"3 DP-2\""
            "${pkgs.hyprland}/bin/hyprctl dispatch moveworkspacetomonitor \"4 DP-2\""
            "${pkgs.hyprland}/bin/hyprctl dispatch moveworkspacetomonitor \"5 DP-2\""
          ];
        }
        {
          profile.name = "undocked";
          profile.outputs = [
            {
              criteria = "eDP-1";
              scale = 1.0;
            }
          ];
        }
      ];
    };
  };
}
