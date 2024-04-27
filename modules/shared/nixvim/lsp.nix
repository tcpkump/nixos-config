{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      ansiblels.enable = true;
      bashls.enable = true;
      dockerls.enable = true;
      gopls.enable = true;
      helm-ls.enable = true;
      jsonls.enable = true;
      nixd.enable = true;
      perlpls.enable = true;
      phpactor.enable = true;
      pyright.enable = true;
      rust-analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
      sqls.enable = true;
      terraformls.enable = true;
      tsserver.enable = true;
      yamlls.enable = true;
    };
    keymaps = {
      silent = true;
      diagnostic = {
        "<leader>do" = "open_float";
        "[d" = "goto_prev";
        "]d" = "goto_next";
      };
      lspBuf = {
        "gd" = "definition";
        "gt" = "type_definition";
        "K" = "hover";
        "<leader>ca" = "code_action";
        "<leader>rn" = "rename";
      };
    };
  };
}
