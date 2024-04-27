{ pkgs, ... }: {
  imports = [
    ./completion/cmp.nix
    ./completion/copilot.nix
    ./completion/nvim-autopairs.nix

    ./motion/comment.nix
    ./motion/harpoon.nix
    ./motion/surround.nix

    ./snippets/luasnip.nix

    ./colorscheme.nix
    ./git.nix
    ./helm.nix
    ./indent-blankline.nix
    ./keymaps.nix
    ./lsp.nix
    ./neo-tree.nix
    ./none-ls.nix
    ./options.nix
    ./telescope.nix
    ./tmux-navigator.nix
    ./treesitter.nix
    ./trouble.nix
    ./which-key.nix
  ];

  programs.nixvim.enable = true;
}