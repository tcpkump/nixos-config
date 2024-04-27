{
  programs.nixvim.plugins.helm.enable = true;
  programs.nixvim.plugins.lsp.onAttach = ''
    if client.name == "yamlls" then
      if vim.api.nvim_get_option_value("filetype", { buf = buffer }) == "helm" then
        vim.schedule(function()
          vim.cmd("LspStop ++force yamlls")
        end)
      end
    end
  '';
}
