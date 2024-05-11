{
  programs.nixvim.plugins = {
    luasnip = {
      enable = true;
      extraConfig = {
        enable_autosnippets = false;
        store_selection_keys = "<Tab>";
      };
    };
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        preselect = "cmp.PreselectMode.None";
        matching.disallow_partial_fuzzy_matching = false;
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        window = {
          completion = {
            border = "single";
            scrollbar = false;
            scrolloff = 2;
          };
          documentation = {
            border = "single";
          };
        };
        sources = [
          {name = "copilot";}
          {name = "nvim_lsp";}
          {name = "luasnip";}
          {name = "calc";}
          {name = "emoji";}
          {name = "treesitter";}
          {name = "nerdfont";}
          {name = "git";}
          {name = "fuzzy-path";}
          {name = "path";}
          {name = "buffer";}
        ];
        mapping = {
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-e>" = "cmp.mapping.abort()";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<CR>" = "cmp.mapping.confirm({ select = false })";
          "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
        };
      };
    };
  };
}
