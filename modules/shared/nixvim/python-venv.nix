{pkgs, ...}: {
  programs.nixvim = {
    plugins.dap.extensions.dap-python.enable = true;
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "venv-selector";
        src = pkgs.fetchFromGitHub {
          owner = "linux-cultist";
          repo = "venv-selector.nvim";
          rev = "9b1bfe5aea225853e14358f504c656d4af007035";
          hash = "sha256-XY4hHvslNginl+FxT7owjobInmyhRDwPtNaWOAPpOO0=";
        };
      })
    ];

    extraConfigLua = ''
      require('venv-selector').setup()
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>cv";
        action = "<cmd>VenvSelect<cr>";
        options = {
          desc = "Select pyhton venv";
        };
      }
    ];
  };
}
