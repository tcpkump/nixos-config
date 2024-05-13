{
  programs.nixvim.globals.mapleader = " ";

  programs.nixvim.keymaps = [

    {
      key = "<leader>e";
      action = "<cmd>Neotree toggle filesystem reveal left<CR>";
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
      key = "gr";
      action = "<cmd>Telescope lsp_references<CR>";
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
      key = "<C-s>";
      action = "<cmd>w<CR>";
    }
    
    {
      key = "<leader>ti";
      action = "<cmd>lcd %:p:h<CR><cmd>!terraform init -upgrade -no-color<CR>";
    }

    {
      key = "<leader>tp";
      action = "<cmd>lcd %:p:h<CR><cmd>!terraform plan -no-color<CR>";
    }
  ];
}
