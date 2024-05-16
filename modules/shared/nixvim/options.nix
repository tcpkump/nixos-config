{
  programs.nixvim.opts = {
    background = "";
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

    guicursor = [
        "n-v-c-sm:block"
        "i-ci-ve:ver25"
        "r-cr-o:hor20"
        "i:blinkoff750-blinkon750-Cursor/lCursor" # insert mode: blinking settings
    ];
  };
}

