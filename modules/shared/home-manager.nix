{ config, pkgs, lib, ... }:

let name = "Garrett Leber";
    user = "garrettleber";
    email = "lebergarrett@gmail.com"; in
{
  imports = [
    ./nixvim/default.nix
  ];

  programs = {
    ssh = {
      enable = true;

      extraConfig = lib.mkMerge [
        ''
          Host github.com
            Hostname github.com
            IdentitiesOnly yes
        ''
        (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
          ''
            IdentityFile /home/${user}/.ssh/id_github
          '')
        (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
          ''
            IdentityFile /Users/${user}/.ssh/id_github
          '')
      ];
    };

    git = {
      enable = true;
      userName = "Garrett Leber";
      userEmail = "lebergarrett@gmail.com";
    };

    alacritty = {
      enable = true;
      settings = {
        shell.program = "zsh";
        font.size = 14;
        font = {
          normal.family = "FiraCode Nerd Font Mono";
        };
        window.padding = {
          x = 4;
          y = 4;
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
        export ZSH_TMUX_AUTOSTART=true
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
