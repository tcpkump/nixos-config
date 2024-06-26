{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  firefox
  slack

  # Security and authentication
  yubikey-agent
  libfido2
  pass-wayland

  # wayland screenshots
  grim
  slurp
  swappy
  wl-clipboard

  # App and package management
  gnumake
  home-manager

  vlc
  obs-studio

  # Audio tools
  pavucontrol # Pulse audio controls

  # Text and terminal utilities
  tree
  killall

  google-chrome

  # Music and entertainment
  spotify

  # for wayland/hyprland screensharing
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk

  # for testing dunst notification
  libnotify
]
