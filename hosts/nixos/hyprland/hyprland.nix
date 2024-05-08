{ ... }:

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

      # Optional
      # Whether to enable hyprland-session.target on hyprland startup
      systemd.enable = true;

      extraConfig = builtins.readFile ./hyprland.conf;
    };
    programs.wofi.enable = true;
    services.dunst.enable = true;
    services.easyeffects.enable = true;

    # set cursor size and dpi for 4k monitor
    xresources.properties = {
      "Xcursor.size" = 16;
      "Xft.dpi" = 172;
    };
  };
}
