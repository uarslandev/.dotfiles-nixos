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

          # ───── Window control ─────
          "Mod+Q".close-window = {};
          "Mod+Shift+Q".close-window = {};

          "Mod+F".fullscreen-window = {};
          "Mod+Space".toggle-window-floating = {};

          # ───── Focus (columns + windows) ─────
          "Mod+H".focus-column-left = {};
          "Mod+L".focus-column-right = {};
          "Mod+J".focus-window-down = {};
          "Mod+K".focus-window-up = {};

          # Arrow navigation (same logic as HJKL)
          "Mod+Left".focus-column-left = {};
          "Mod+Right".focus-column-right = {};
          "Mod+Down".focus-window-down = {};
          "Mod+Up".focus-window-up = {};

          # ───── Move windows ─────
          "Mod+Shift+J".move-window-down = {};
          "Mod+Shift+K".move-window-up = {};

          # ───── Monitors ─────
          "Mod+Ctrl+H".focus-monitor-left = {};
          "Mod+Ctrl+L".focus-monitor-right = {};

          "Mod+Shift+H".move-column-to-monitor-left = {};
          "Mod+Shift+L".move-column-to-monitor-right = {};

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

          # ───── Column width control (THIS fixes your “half screen browser” issue) ─────
          "Mod+Shift+Left".set-column-width = "-10%";
          "Mod+Shift+Right".set-column-width = "+10%";
          "Mod+Shift+R".set-column-width = "100%";

          # ───── Media keys ─────
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