{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      hover-nvim
    ];

    extraConfigLua = ''
      require("hover").setup {
        init = function()
          require("hover.providers.lsp")
        end,
        preview_opts = {
            border = 'rounded'
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true,
      }

      -- Setup keymaps
      vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})

      --vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
      --vim.keymap.set("n", "<C-p>", function() require("hover").hover_switch("previous") end, {desc = "hover.nvim (previous source)"})
      --vim.keymap.set("n", "<C-n>", function() require("hover").hover_switch("next") end, {desc = "hover.nvim (next source)"})
    '';
  };
}
