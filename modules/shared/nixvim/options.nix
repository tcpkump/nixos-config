{
  programs.nixvim.opts = {
    updatetime = 100;

    spell = false;

    number = true;
    relativenumber = true;

    expandtab = true;
    shiftwidth = 2;
    tabstop = 2;

    ignorecase = true;
    incsearch = true;
    smartcase = true;
    wildmode = "list:longest";

    swapfile = false;
    undofile = true;

    splitright = true;
    splitbelow = true;
  };
}

