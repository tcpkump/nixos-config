{ pkgs }:

with pkgs; [
  python3
  pre-commit
  tenv
  terraform-docs
  kubectl
  google-cloud-sdk
  ansible
  go-jira

  pass-wayland

  saml2aws
  k9s

  podman
  podman-compose

  tmux-sessionizer

  # wayland screenshots
  grim
  slurp

  # archives
  zip
  unzip

  # utils
  ripgrep # recursively searches directories for a regex pattern
  jq # A lightweight and flexible command-line JSON processor
  fzf # A command-line fuzzy finder
  fd

  # networking tools
  mtr # A network diagnostic tool
  dnsutils  # `dig` + `nslookup`
  nmap # A utility for network discovery and security auditing

  # misc
  which
  tree
  gnupg
  gnumake
  fira-code-nerdfont

  # nix related
  #
  # it provides the command `nom` works just like `nix`
  # with more details log output
  nix-output-monitor

  btop  # replacement of htop/nmon
  iotop # io monitoring
  iftop # network monitoring
]
