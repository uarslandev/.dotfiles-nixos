{ config, pkgs, lib, ... }:

{
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "kitty.desktop"
      ];
    };
  };
  environment = {
    sessionVariables = rec {
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_STATE_HOME  = "$HOME/.local/state";

      XMONAD_CONFIG_DIR = "$XDG_CONFIG_HOME/xmonad";
      XMONAD_CACHE_DIR  = "$XDG_CONFIG_HOME/xmonad";
      XMONAD_DATA_DIR   = "$XDG_CONFIG_HOME/xmonad";

      # Fix Modrinth rendering
      WEBKIT_DISABLE_DMABUF_RENDERER = "1";

      # Custom bin location
      XDG_BIN_HOME = "$HOME/.local/bin";
      PATH = [
        "$HOME/.npm-global/bin"
        "${XDG_BIN_HOME}"
      ];

      # DaVinci Resolve AMD GPU / ROCm / Rusticl
      ROC_ENABLE_PRE_VEGA      = "1";
      DRI_PRIME                 = "1";
      QT_QPA_PLATFORM           = "xcb";
    };

    variables = {
      EDITOR   = "nvim";
      TERMINAL = "kitty";
      BROWSER = "firefox";
      TERM = "kitty";
    };
  };
}

