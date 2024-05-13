{ ... }:

let
  home           = builtins.getEnv "HOME";
  xdg_configHome = "${home}/.config";
in
{
  "${xdg_configHome}/dunst_custom".source = ./config/dunst;
}
