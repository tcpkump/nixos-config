{
  programs.nixvim.plugins.lsp-format.enable = true;
  programs.nixvim.plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    sources.formatting = {

      packer.enable = true;
      packer.package = null;

      puppet_lint.enable = true;

      terraform_fmt.enable = true;
      terraform_fmt.package = null;

      goimports.enable = true;
      gofmt.enable = true;
    };
    sources.diagnostics = {

      puppet_lint.enable = true;

      tfsec.enable = true;
    };
  };
}
