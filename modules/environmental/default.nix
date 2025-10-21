# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
  environment = {
   sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";

	XMONAD_CONFIG_DIR = "$XDG_CONFIG_HOME/xmonad";
    XMONAD_CACHE_DIR = "$XDG_CONFIG_HOME/xmonad";
    XMONAD_DATA_DIR = "$XDG_CONFIG_HOME/xmonad";

    #Fix Modrinth
    WEBKIT_DISABLE_DMABUF_RENDERER = "1";
	
    # Not officially in the specification
    XDG_BIN_HOME    = "$HOME/.local/bin";
    PATH = [
      "$HOME/.npm-global/bin"
      "${XDG_BIN_HOME}"
    ];
  };
  variables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
  };
 };
}
