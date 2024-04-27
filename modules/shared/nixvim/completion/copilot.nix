{
  programs.nixvim.plugins.copilot-cmp = {
    enable = true;
  };
  programs.nixvim.plugins.copilot-lua = {
    enable = true;
    suggestion = {enabled = false;};
    panel = {enabled = false;};
    filetypes = {
      yaml = true;
      markdown = true;
      help = false;
      gitcommit = false;
      gitrebase = false;
      hgcommit = false;
      svn = false;
      cvs = false;
      "." = false;
    };
  };
}
