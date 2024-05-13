{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      ChatGPT-nvim
      nui-nvim
    ];

    extraConfigLua = ''
      require('chatgpt').setup({
        openai_params = {
          model = "gpt-4o"
        }
      })
    '';

    keymaps = [
      {
        key = "<leader>ac";
        action = "<cmd>ChatGPT<cr>";
        options = {
          desc = "ChatGPT";
        };
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>ai";
        action = "<cmd>ChatGPTEditWithInstruction<cr>";
        options = {
          desc = "ChatGPT with instruction";
        };
      }

      {
        mode = [ "n" "v" ];
        key = "<leader>ax";
        action = "<cmd>ChatGPTRun explain_code<CR>";
        options = {
          desc = "ChatGPT explain code";
        };
      }
    ];
  };
}

