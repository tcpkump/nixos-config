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
    file = shared-files // import ./files.nix { inherit user; };
    stateVersion = "23.11";
  };

  services = {
    # Auto mount devices
    udiskie.enable = true;
  };

  # programs = shared-programs // {};
  programs.zsh.initExtra = ''
    function vpn() {
        case "$1" in
            connect)
                if [[ -n "$2" ]]; then
                    # Disconnect all sessions first
                    vpn disconnect
                    
                    # Start a new VPN session
                    echo "Connecting to $2..."
                    openvpn3 session-start --config ~/Sync/"$2.ovpn"
                else
                    echo "Please specify a VPN profile name to connect."
                fi
                ;;

            disconnect)
                echo "Disconnecting all VPN sessions..."
                # Fetch the session paths and disconnect each session
                local sessions=$(openvpn3 sessions-list | grep -oP 'Path: \K/net/openvpn/v3/sessions/\S+')
                for session in $sessions; do
                    openvpn3 session-manage --session-path="$session" --disconnect
                done
                ;;

            list)
                echo "Available VPN profiles:"
                ls ~/Sync/*.ovpn | sed 's|^.*/||; s|\.ovpn$||'
                ;;

            *)
                echo "Usage: vpn [connect <name> | disconnect | list]"
                ;;
        esac
    }
  ''
  ;

}
