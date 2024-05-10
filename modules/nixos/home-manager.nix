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
    vpn () {
        local cmd=$1
        local service_name=$2

        # Function to list VPN services
        list_vpn_services () {
            systemctl list-units --type=service --all | grep -o 'openvpn-[^ ]*.service'
        }

        case $cmd in
            list)
                echo "Available VPN services:"
                list_vpn_services
                ;;
            connect)
                if ! systemctl list-units --type=service --all | grep -q "$service_name"; then
                    echo "Unknown VPN service: $service_name"
                    return 1
                fi
                echo "Connecting to $service_name..."
                sudo systemctl stop 'openvpn-*.service'
                sudo systemctl start "$service_name"
                ;;
            disconnect)
                echo "Disconnecting all VPN services..."
                sudo systemctl stop 'openvpn-*.service'
                ;;
            *)
                echo "Unknown command: $cmd"
                echo "Available commands: list, connect, disconnect"
                return 1
                ;;
        esac
    }
''
;

}
