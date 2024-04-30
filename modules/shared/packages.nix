{ pkgs }:

with pkgs; [
  python3
  pre-commit
  terraform
  terraform-docs
  kubectl
  google-cloud-sdk

  podman
  podman-compose

  tmux-sessionizer

  # archives
  zip
  unzip

  # utils
  ripgrep # recursively searches directories for a regex pattern
  jq # A lightweight and flexible command-line JSON processor
  fzf # A command-line fuzzy finder

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
