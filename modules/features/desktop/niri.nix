{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;

      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard.xkb.layout = "us,ua";

        layout.gaps = 5;
        binds = {

        # ───── Apps ─────

        "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;

        "Mod+S".spawn-sh =
        "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";

        "Mod+E".spawn-sh = lib.getExe pkgs.kdePackages.dolphin;

        # ───── Session Management ─────

        "Mod+Shift+E".quit = {};

        # ───── Window Control ─────

        "Mod+Q".close-window = {};
        "Mod+Shift+Q".close-window = {};

        "Mod+F".fullscreen-window = {};
        "Mod+Space".toggle-window-floating = {};
        "Mod+Shift+Space".switch-focus-between-floating-and-tiling = {};

        # ───── Focus (Columns + Windows) ─────

        "Mod+H".focus-column-left = {};
        "Mod+L".focus-column-right = {};
        "Mod+J".focus-window-down = {};
        "Mod+K".focus-window-up = {};

        # Arrow navigation

        "Mod+Left".focus-column-left = {};
        "Mod+Right".focus-column-right = {};
        "Mod+Down".focus-window-down = {};
        "Mod+Up".focus-window-up = {};

        # ───── Move Windows & Columns ─────

        "Mod+Shift+H".move-column-left = {};
        "Mod+Shift+L".move-column-right = {};
        "Mod+Shift+J".move-window-down = {};
        "Mod+Shift+K".move-window-up = {};

        # ───── Column Stacking ─────

        "Mod+BracketLeft".consume-or-expel-window-left = {};
        "Mod+BracketRight".consume-or-expel-window-right = {};

        # ───── Monitors ─────

        "Mod+Ctrl+H".focus-monitor-left = {};
        "Mod+Ctrl+L".focus-monitor-right = {};

        "Mod+Ctrl+Left".focus-monitor-left = {};
        "Mod+Ctrl+Right".focus-monitor-right = {};

        "Mod+Ctrl+Shift+H".move-column-to-monitor-left = {};
        "Mod+Ctrl+Shift+L".move-column-to-monitor-right = {};

        "Mod+Ctrl+Shift+Left".move-column-to-monitor-left = {};
        "Mod+Ctrl+Shift+Right".move-column-to-monitor-right = {};

        # ───── Workspaces ─────

        "Mod+1".focus-workspace = 1;
        "Mod+2".focus-workspace = 2;
        "Mod+3".focus-workspace = 3;
        "Mod+4".focus-workspace = 4;
        "Mod+5".focus-workspace = 5;
        "Mod+6".focus-workspace = 6;
        "Mod+7".focus-workspace = 7;
        "Mod+8".focus-workspace = 8;
        "Mod+9".focus-workspace = 9;
        "Mod+0".focus-workspace = 10;

        "Mod+Shift+1".move-column-to-workspace = 1;
        "Mod+Shift+2".move-column-to-workspace = 2;
        "Mod+Shift+3".move-column-to-workspace = 3;
        "Mod+Shift+4".move-column-to-workspace = 4;
        "Mod+Shift+5".move-column-to-workspace = 5;
        "Mod+Shift+6".move-column-to-workspace = 6;
        "Mod+Shift+7".move-column-to-workspace = 7;
        "Mod+Shift+8".move-column-to-workspace = 8;
        "Mod+Shift+9".move-column-to-workspace = 9;
        "Mod+Shift+0".move-column-to-workspace = 10;

        # Vertical workspace navigation/moving (Uncommented and matched to Niri syntax)
        "Mod+Page_Down".focus-workspace-down = {};
        "Mod+Page_Up".focus-workspace-up = {};
        "Mod+Shift+Page_Down".move-column-to-workspace-down = {};
        "Mod+Shift+Page_Up".move-column-to-workspace-up = {};
        
        # Alternative index-relative bindings using Comma and Period
        "Mod+Comma".focus-workspace-down = {};
        "Mod+Period".focus-workspace-up = {};
        "Mod+Shift+Comma".move-column-to-workspace-down = {};
        "Mod+Shift+Period".move-column-to-workspace-up = {};

        # ───── Column Width Control ─────

        "Mod+Minus".set-column-width = "-10%";
        "Mod+Equal".set-column-width = "+10%";
        "Mod+R".set-column-width = "100%";
        "Mod+W".switch-preset-column-width = {};
        "Mod+M".maximize-column = {};

        # Remove if unsupported in your version.

        # "Mod+C".center-column = {};

        # "Mod+Shift+R".reset-window-height = {};

        # ───── Screenshots ─────

        "Print".screenshot = {};
        "Ctrl+Print".screenshot-screen = {};
        "Alt+Print".screenshot-window = {};

        # ───── Effects / Safety / UI ─────

        "Mod+F1".show-hotkey-overlay = {};
        "Mod+Tab".toggle-overview = {};
        "Mod+Escape".toggle-keyboard-shortcuts-inhibit = {};
        "Mod+Ctrl+Space".do-screen-transition = {}; # Adjusted from Shift+Space to avoid conflict

        # ───── Media Keys ─────

        "XF86MonBrightnessUp".spawn-sh =
        "${lib.getExe pkgs.brightnessctl} set +5%";

        "XF86MonBrightnessDown".spawn-sh =
        "${lib.getExe pkgs.brightnessctl} set 5%-";

        "XF86AudioRaiseVolume".spawn-sh =
        "${lib.getExe pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";

        "XF86AudioLowerVolume".spawn-sh =
        "${lib.getExe pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";

        "XF86AudioMute".spawn-sh =
        "${lib.getExe pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

        "XF86AudioPlay".spawn-sh =
        "${lib.getExe pkgs.playerctl} play-pause";

        "XF86AudioNext".spawn-sh =
        "${lib.getExe pkgs.playerctl} next";

        "XF86AudioPrev".spawn-sh =
        "${lib.getExe pkgs.playerctl} previous";
        };
      };
    };
  };
}