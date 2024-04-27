{
  programs.nixvim.globals.mapleader = " ";

  programs.nixvim.keymaps = [

    {
      key = "<leader>e";
      action = "<cmd>Neotree toggle<CR>";
      mode = "n";
    }

    {
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<CR>";
      mode = "n";
    }

    {
      key = "<leader>fw";
      action = "<cmd>Telescope live_grep<CR>";
      mode = "n";
    }

    {
      key = "p";
      action = "\"_dP";
      mode = "v";
    }

    {
      key = "<leader>y";
      action = "\"+y";
    }

    {
      key = "<leader>d";
      action = "\"_d";
    }

    {
      key = "<leader>p";
      action = "\"+p";
    }

    {
      key = "<S-H>";
      action = "<cmd>bprev<CR>";
      mode = "n";
    }

    {
      key = "<S-L>";
      action = "<cmd>bnext<CR>";
      mode = "n";
    }

    {
      key = "<C-s>";
      action = "<cmd>w<CR>";
    }

    {
      key = "<leader>cd";
      action = "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>";
      mode = "n";
    }
  ];
}
