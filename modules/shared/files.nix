{ ... }:

{
  # Initializes Emacs with org-mode so we can tangle the main config
  # ".emacs.d/init.el" = {
  #   text = builtins.readFile ../shared/config/emacs/init.el;
  # };
  ".jira.d".source = ../shared/config/jira;
}
