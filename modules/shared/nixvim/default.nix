{ pkgs, ... }: {
  imports = [
    ./completion/cmp.nix
    ./completion/copilot.nix
    ./completion/nvim-autopairs.nix

    ./motion/comment.nix
    ./motion/harpoon.nix
    ./motion/surround.nix

    ./chatgpt.nix
    ./colorscheme.nix
    ./git.nix
    ./helm.nix
    ./hover.nix
    ./indent-blankline.nix
    ./keymaps.nix
    ./lsp.nix
    ./lualine.nix
    ./neo-tree.nix
    ./none-ls.nix
    ./options.nix
    ./python-venv.nix
    ./smart-splits.nix
    ./telescope.nix
    ./treesitter.nix
    ./trouble.nix
    ./welcome.nix
    ./which-key.nix
    ./wiki.nix
  ];

  programs.nixvim.enable = true;
  programs.nixvim.defaultEditor = true;
}
