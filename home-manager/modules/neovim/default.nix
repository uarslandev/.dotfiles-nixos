{ config, pkgs, ... }:

{
  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    enable = true;
    extraConfig = ''
      set number relativenumber
      set tabstop=4
      set shiftwidth=4
      set softtabstop=4
      set autoindent
    '';
  };
}
