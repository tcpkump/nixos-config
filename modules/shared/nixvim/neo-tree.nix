{
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    closeIfLastWindow = true;
    buffers.followCurrentFile.enabled = true;
    buffers.followCurrentFile.leaveDirsOpen = true;
    filesystem.filteredItems.alwaysShow = [ 
      ".gitignore"
      ".gitattributes"
      ".pre-commit-config.yaml"
      ".terraform"
      ".terraform.lock.hcl"
    ];
  };
}
