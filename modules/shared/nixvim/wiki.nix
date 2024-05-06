{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      (pkgs.vimUtils.buildVimPlugin {
        name = "kiwi";
        src = pkgs.fetchFromGitHub {
          owner = "serenevoid";
          repo = "kiwi.nvim";
          rev = "1a625771e3d3d9f50ca28a4501c11842f6c1ec1e";
          hash = "sha256-aXM6oDxR5TX/aDpF3yH4a3XWnAYqFMSNh9SngNlSMWU=";
        };
      })
      plenary-nvim
    ];

    extraConfigLua = ''
      require('kiwi').setup()
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>ww";
        action = "<cmd>lua require(\"kiwi\").open_wiki_index()<cr>";
        options = {
          desc = "Open Wiki Index";
        };
      }
    ];
  };
}
