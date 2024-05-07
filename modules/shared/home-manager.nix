{ config, pkgs, lib, ... }:

let
    name = "Garrett Leber";
    user = "garrettleber";
    email = "garrett.leber@openvpn.net";
    inherit (lib.hm) dag;
in {
  imports = [
    ./nixvim/default.nix
  ];

  services.syncthing = {
    enable = true;
  };

  programs = {
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
      matchBlocks = {
        "bastion" = dag.entryBefore ["*.dwopenvpn.net"] {
          hostname = "bastion1.prod.dwopenvpn.net";
          user = "garrett_leber";
          forwardAgent = true;
        };
        "ansiblejumphost.*.dwopenvpn.net" = dag.entryBefore ["*.dwopenvpn.net"] {
          user = "garrett_leber";
          forwardAgent = true;
          proxyJump = "bastion";
        };
        "*.dwopenvpn.net" = {
          user = "brian";
          forwardAgent = true;
          proxyJump = "bastion";
        };

        "*.ec.devopenvpn.net" = {
          user = "root";
          forwardAgent = true;
        };

        "awscosts nagios2" = dag.entryBefore ["*.openvpn.in"] {
          hostname = "%h.prod.aws.openvpn.in";
          user = "garrett_leber";
          forwardAgent = true;
          proxyJump = "bastion";
        };
        "awscosts.lab" = dag.entryBefore ["*.openvpn.in"] {
          hostname = "%h.aws.openvpn.in";
          user = "garrett_leber";
          forwardAgent = true;
          proxyJump = "bastion";
        };
        "airflow.shared-dev" = dag.entryBefore ["*.openvpn.in"] {
          hostname = "%h.aws.openvpn.in";
          user = "garrett_leber";
          forwardAgent = true;
          proxyJump = "bastion";
        };
        "*.openvpn.in" = {
          user = "garrett.leber";
          forwardAgent = true;
        };

        "*.devopenvpn.in" = {
          user = "garrett.leber";
          forwardAgent = true;
        };

        "*.imkumpy.in" = {
          user = "lab";
          identityFile = "~/.ssh/mbp_personal";
          forwardAgent = true;
        };
      };
    };

    git = {
      enable = true;
      userName = "Garrett Leber";
      userEmail = "garrett.leber@openvpn.net";
      lfs.enable = true;
      difftastic.enable = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    awscli.enable = true;
    go.enable = true;

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
        "tfi" = "terraform init -upgrade";
        "tfp" = "terraform plan";
        "tfa" = "terraform apply";
        "tfd" = "terraform destroy";
        "tff" = "terraform fmt -recursive";

        "k" = "kubectl";

        "endless" = "less +G";
        "tailf" = "tail -f";

        "awslab" = "saml2aws login --force --skip-prompt --session-duration=28800 --role arn:aws:iam::817264447024:role/sso-lab-admin";
        "awsprod" = "saml2aws login --force --skip-prompt --session-duration=28800 --role arn:aws:iam::444663524611:role/sso-prod-admin";
        "awssharedprod" = "saml2aws login --force --skip-prompt --session-duration=28800 --role arn:aws:iam::543714519113:role/sso-shared-prod-admin";
        "awsshareddev" = "saml2aws login --force --skip-prompt --session-duration=28800 --role arn:aws:iam::497854349903:role/sso-shared-dev-admin";
        "awssuat" = "saml2aws login --force --skip-prompt --session-duration=28800 --role arn:aws:iam::636898119407:role/sso-uat-admin";

        "eks-dev-web" = "saml2aws login --force --skip-prompt --session-duration=28800 --role arn:aws:iam::817264447024:role/sso-lab-admin && aws eks update-kubeconfig --region us-west-1 --name us-west-1-dev-saas";
        "eks-uat-products" = "saml2aws login --force --skip-prompt --session-duration=28800 --role arn:aws::iam:636898119407:role/sso-uat-admin && aws eks update-kubeconfig --region us-west-1 --name us-west-1-uat-products";
        "eks-prod-web" = "saml2aws login --force --skip-prompt --session-duration=28800 --role arn:aws:iam::444663524611:role/sso-prod-admin && aws eks update-kubeconfig --region us-west-1 --name us-west-1-prod-web";
      };

      envExtra = ''
        export ZSH_TMUX_AUTOSTART=true
        export LANG=en_US.UTF-8
        unset LC_ALL
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
