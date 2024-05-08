{ pkgs, ...}:
let user = "garrettleber"; in

{
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
  home-manager.users.${user}.home = {
    file.".config/swaylock/config".source = ./swaylock.conf;
    packages = with pkgs; [
      swaylock-effects
      swayidle
    ];
  };
}
