{
  programs.nixvim.plugins.harpoon = {
    enable = true;
    enableTelescope = true;
    keymaps = {
      addFile = "<leader><Space>a";
      toggleQuickMenu = "<leader><Space>e";
      navNext = "<C-n>";
      navPrev = "<C-p>";
    };
  };
}
