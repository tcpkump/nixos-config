{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  firefox
  slack

  # Security and authentication
  yubikey-agent

  # App and package management
  gnumake
  home-manager

  vlc

  # Audio tools
  pavucontrol # Pulse audio controls

  # Text and terminal utilities
  tree

  google-chrome

  # Music and entertainment
  spotify
]
