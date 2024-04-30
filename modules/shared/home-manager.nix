{ config, pkgs, lib, ... }:

let name = "Garrett Leber";
    user = "garrettleber";
    email = "lebergarrett@gmail.com"; in
{
  imports = [
    ./nixvim/default.nix
  ];

  services.syncthing = {
    enable = true;
  };

  programs = {
    ssh = {
      enable = true;
      extraConfig = ''
        Host *
            AddressFamily inet

        Host bastion
            User garrett_leber
            HostName bastion1.prod.dwopenvpn.net
            ForwardAgent yes
            AddKeysToAgent yes

        Host ansiblejumphost.*.dwopenvpn.net
            User garrett_leber
            ForwardAgent yes
            AddKeysToAgent yes
            StrictHostKeyChecking no
            ProxyJump bastion

        Host *.dwopenvpn.net
            User brian
            ForwardAgent yes
            AddKeysToAgent yes
            StrictHostKeyChecking no
            ProxyJump bastion

        Host *.ec.devopenvpn.net
            User root
            ForwardAgent yes
            AddKeysToAgent yes
            StrictHostKeyChecking no

        # BEGIN DW AWS Ansible-managed hosts

        Host awscosts nagios2
            HostName %h.prod.aws.openvpn.in
            User garrett_leber
            ForwardAgent yes
            AddKeysToAgent yes
            StrictHostKeyChecking no
            ProxyJump bastion

        Host awscosts.lab
            HostName %h.aws.openvpn.in
            User garrett_leber
            ForwardAgent yes
            AddKeysToAgent yes
            StrictHostKeyChecking no
            ProxyJump bastion

        Host airflow.shared-dev
            HostName %h.aws.openvpn.in
            User garrett_leber
            ForwardAgent yes
            AddKeysToAgent yes
            StrictHostKeyChecking no
            ProxyJump bastion

        # END DW AWS Ansible-managed hosts

        Host *.openvpn.in
            User garrett.leber
            ForwardAgent yes
            AddKeysToAgent yes
            StrictHostKeyChecking no

        Host *.devopenvpn.in
            User garrett.leber
            ForwardAgent yes
            AddKeysToAgent yes
            StrictHostKeyChecking no
      '';
    };

    git = {
      enable = true;
      userName = "Garrett Leber";
      userEmail = "lebergarrett@gmail.com";
      lfs.enable = true;
      difftastic.enable = true;
    };

    awscli.enable = true;

    alacritty = {
      enable = true;
      settings = {
        shell.program = "zsh";
        font.size = 14;
        font = {
          normal.family = "FiraCode Nerd Font Mono";
        };
        window = {
          padding = {
            x = 4;
            y = 4;
          };
          option_as_alt = "OnlyLeft";
        };
      };
    };

    tmux = {
      enable = true;
      extraConfig = builtins.readFile ./config/tmux.conf;
      tmuxinator.enable = true;
    };

    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "onehalf.minimal";
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        "vim" = "nvim";

        "ls" = "ls --color=auto";
        "ll" = "ls -lhF --color=auto";
        "la" = "ls -lhFa --color=auto";
        "lh" = "ls -ld .?* --color=auto";

        "tf" = "terraform";
        "tfi" = "terraform init";
        "tfp" = "terraform plan";
        "tfa" = "terraform apply";
        "tfd" = "terraform destroy";
        "tff" = "terraform fmt -recursive";

        "k" = "kubectl";

        "endless" = "less +G";
        "tailf" = "tail -f";

        "tx" = "tmuxinator";
        "txs" = "tmuxinator start";
        "txo" = "tmuxinator open";
        "txn" = "tmuxinator new";
        "txl" = "tmuxinator list --newline";
      };

      envExtra = ''
        # export ZSH_TMUX_AUTOSTART=true
      '';

      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";

      oh-my-zsh = {
        enable = true;
        plugins = [
          "aliases"
          "git"
          "colorize"
          "extract"
          "tmux"
          "ssh-agent"
        ];
      };
    };
  };
}
