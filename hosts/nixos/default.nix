{ pkgs, ... }:

let user = "garrettleber"; in
{
  imports = [
    ../../modules/nixos/hardware-configuration.nix
    ../../modules/shared
    ../../modules/shared/cachix

    ./hyprland/hyprland.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 42;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    # Uncomment for AMD GPU
    # initrd.kernelModules = [ "amdgpu" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "uinput" ];
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    hostName = "centurion"; # Define your hostname.
    networkmanager.enable = true;
    #interfaces."%INTERFACE%".useDHCP = true;
  };

  services.openssh.enable = true;

  # Turn on flag for proprietary software
  nix = {
    nixPath = [ "nixos-config=/home/${user}/.local/share/src/nixos-config:/etc/nixos" ];
    settings.allowed-users = [ "${user}" ];
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  # Manages keys and such
  programs = {
    gnupg.agent.enable = true;

    # Needed for anything GTK related
    dconf.enable = true;

    # My shell
    zsh.enable = true;
  };

  services.xserver = {
    enable = true;
    displayManager = {
      gdm.enable = true;
      # autoLogin.enable = true;
      # autoLogin.user = "${user}";
    };
    desktopManager.gnome.enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  hardware.keyboard.qmk.enable = true;

  # # Workaround for gnome autologin:
  # systemd.services = {
  #   "getty@tty1".enable = false;
  #   "autovt@tty1".enable = false;
  # };

  nixpkgs.config.allowUnfree = true;

  services.printing.enable = true;

  sound.enable = true;

  hardware = {
    opengl.enable = true;
    pulseaudio.enable = false;
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # yubikey
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;

  # Add docker daemon
  virtualisation = {
    docker = {
      enable = true;
      logDriver = "json-file";
    };
  };

  # It's me, it's you, it's everyone
  users.users = {
    ${user} = {
      isNormalUser = true;
      extraGroups = [
        "wheel" # Enable ‘sudo’ for the user.
        "docker"
        "networkmanager"
      ];
      shell = pkgs.zsh;
      # openssh.authorizedKeys.keys = keys;
    };

    # root = {
    #   openssh.authorizedKeys.keys = keys;
    # };
  };

  # Don't require password for users in `wheel` group for these commands
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  fonts.packages = with pkgs; [
    dejavu_fonts
    feather-font # from overlay
    jetbrains-mono
    font-awesome
    noto-fonts
    noto-fonts-emoji
  ];

  environment.systemPackages = with pkgs; [
    gitAndTools.gitFull
    inetutils
  ];

  services.openvpn.servers = {
    dw-cloud = { config  = '' config /home/${user}/Sync/dw-cloud.ovpn ''; updateResolvConf = true; };
    internal-cloud = { config  = '' config /home/${user}/Sync/internal-cloud.ovpn ''; updateResolvConf = true; };
    vpn-us = { config  = '' config /home/${user}/Sync/vpn-us.ovpn ''; updateResolvConf = true; };
    personal = { config  = '' config /home/${user}/Sync/personal.ovpn ''; updateResolvConf = true; };
  };

  fileSystems."/mnt/shared" = {
    device = "unraid.imkumpy.in:/mnt/user/primary";
    fsType = "nfs";
    # options = [ "x-systemd.automount" "noauto" "x.systemd.idle-timeout=600" ];
  };

  system.stateVersion = "23.11"; # Don't change this
}
