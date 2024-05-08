{ config, pkgs, lib, nixvim, ... }:

let
  user = "garrettleber";
  # xdg_configHome  = "/home/${user}/.config";
  shared-files = import ../shared/files.nix { inherit config pkgs; };

in
{
  imports = [
    ../shared/home-manager.nix
  ];

  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = pkgs.callPackage ./packages.nix {};
    file = shared-files; /* // import ./files.nix { inherit user; }; */
    stateVersion = "23.11";
  };

  services = {
    # Auto mount devices
    udiskie.enable = true;
  };

  # programs = shared-programs // {};


}
