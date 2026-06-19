{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, lib, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };

      systemd.tmpfiles.rules = [
        "d /home/umut/.config/kitty 0755 umut users - -"
        "f /home/umut/.config/kitty/kitty.conf 0644 umut users - include current-theme.conf\n"
        "d /home/umut/.config/niri 0755 umut users - -"
        "f /home/umut/.config/niri/monitor.kdl 0644 umut users - -"
        "f /home/umut/.config/niri/noctalia.kdl 0644 umut users - -"
        "L+ /home/umut/.config/noctalia - umut users - /home/umut/.dotfiles/modules/features/desktop/noctalia"
      ];
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    let
      moveOrMonitor = pkgs.writers.writePython3Bin "niri-move-or-monitor" { doCheck = false; } ''
        import sys
        import json
        import subprocess

        def run_niri_cmd(args):
            subprocess.run(["${pkgs.niri}/bin/niri", "msg", "action"] + args)

        def main():
            if len(sys.argv) < 2:
                sys.exit(1)
            direction = sys.argv[1].lower()
            res = subprocess.run(["${pkgs.niri}/bin/niri", "msg", "--json", "windows"], capture_output=True, text=True)
            if res.returncode != 0:
                sys.exit(1)
            windows = json.loads(res.stdout)
            focused_win = next((w for w in windows if w.get("is_focused")), None)
            if not focused_win:
                sys.exit(0)
            layout = focused_win.get("layout")
            if not layout or focused_win.get("is_floating"):
                run_niri_cmd([f"move-window-to-monitor-{direction}"])
                sys.exit(0)
            pos = layout.get("pos_in_scrolling_layout")
            if not pos or len(pos) < 2:
                run_niri_cmd([f"move-window-to-monitor-{direction}"])
                sys.exit(0)
            col, row = pos[0], pos[1]
            workspace_id = focused_win.get("workspace_id")
            if direction == "up":
                if row > 1:
                    run_niri_cmd(["move-window-up"])
                else:
                    run_niri_cmd(["move-window-to-monitor-up"])
            elif direction == "down":
                col_windows = []
                for w in windows:
                    if w.get("workspace_id") == workspace_id:
                        w_layout = w.get("layout")
                        if w_layout:
                            w_pos = w_layout.get("pos_in_scrolling_layout")
                            if w_pos and w_pos[0] == col:
                                col_windows.append(w_pos[1])
                max_row = max(col_windows) if col_windows else row
                if row < max_row:
                    run_niri_cmd(["move-window-down"])
                else:
                    run_niri_cmd(["move-window-to-monitor-down"])

        if __name__ == "__main__":
            main()
      '';
    in
    {
      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;

        disableConfigValidation = true;

        extraSettings = [
          { include = "/home/umut/.config/niri/monitor.kdl"; }
          { include = "/home/umut/.config/niri/noctalia.kdl"; }
        ];

        settings = {

          spawn-at-startup = [
            (lib.getExe self'.packages.myNoctalia)
            "${pkgs.fcitx5}/bin/fcitx5 -d"
            "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store"
            "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store"
          ];

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          input.keyboard.xkb = {
            layout = "de";
            variant = "us";
          };
          prefer-no-csd = true;

          cursor = {
            xcursor-theme = "Adwaita";
            xcursor-size = 10;
          };

          layout.gaps = 10;
          layout.border.width = 1.0;
          layout.focus-ring.width = 0.0;

          window-rules = [
            {
              geometry-corner-radius = 12;
              clip-to-geometry = true;
            }
          ];

          binds = {

            # ───── Apps ─────

            "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;

            "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";

            "Mod+E".spawn-sh = lib.getExe pkgs.kdePackages.dolphin;

            "Mod+V".spawn-sh =
              "${lib.getExe pkgs.kitty} --class cliphist-picker sh -c '${pkgs.cliphist}/bin/cliphist list | ${pkgs.fzf}/bin/fzf | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy'";

            # ───── Session Management ─────

            "Mod+Shift+E".quit = { };

            "Mod+Alt+L".spawn-sh = "${
              inputs.qylock.packages.${pkgs.stdenv.hostPlatform.system}.qylock-quickshell
            }/bin/qylock-lock";

            # ───── Window Control ─────

            "Mod+Q".close-window = { };
            "Mod+Shift+Q".close-window = { };

            "Mod+F".fullscreen-window = { };
            "Mod+Space".toggle-window-floating = { };
            "Mod+Shift+Space".switch-focus-between-floating-and-tiling = { };

            # ───── Focus (Columns + Windows) ─────

            "Mod+H".focus-column-or-monitor-left = { };
            "Mod+L".focus-column-or-monitor-right = { };
            "Mod+J".focus-window-or-monitor-down = { };
            "Mod+K".focus-window-or-monitor-up = { };

            # Arrow navigation

            "Mod+Left".focus-column-or-monitor-left = { };
            "Mod+Right".focus-column-or-monitor-right = { };
            "Mod+Down".focus-window-or-monitor-down = { };
            "Mod+Up".focus-window-or-monitor-up = { };

            # ───── Move Windows & Columns ─────

            "Mod+Shift+H".move-column-left-or-to-monitor-left = { };
            "Mod+Shift+L".move-column-right-or-to-monitor-right = { };
            "Mod+Shift+J".spawn-sh = "${lib.getExe moveOrMonitor} down";
            "Mod+Shift+K".spawn-sh = "${lib.getExe moveOrMonitor} up";
            "Mod+Shift+Down".spawn-sh = "${lib.getExe moveOrMonitor} down";
            "Mod+Shift+Up".spawn-sh = "${lib.getExe moveOrMonitor} up";

            # ───── Column Stacking ─────

            "Mod+BracketLeft".consume-or-expel-window-left = { };
            "Mod+BracketRight".consume-or-expel-window-right = { };

            # ───── Monitors ─────

            "Mod+Ctrl+H".focus-monitor-left = { };
            "Mod+Ctrl+L".focus-monitor-right = { };
            "Mod+Ctrl+K".focus-monitor-up = { };
            "Mod+Ctrl+J".focus-monitor-down = { };

            "Mod+Ctrl+Left".focus-monitor-left = { };
            "Mod+Ctrl+Right".focus-monitor-right = { };
            "Mod+Ctrl+Up".focus-monitor-up = { };
            "Mod+Ctrl+Down".focus-monitor-down = { };

            "Mod+Ctrl+Shift+H".move-column-to-monitor-left = { };
            "Mod+Ctrl+Shift+L".move-column-to-monitor-right = { };
            "Mod+Ctrl+Shift+K".move-column-to-monitor-up = { };
            "Mod+Ctrl+Shift+J".move-column-to-monitor-down = { };

            "Mod+Ctrl+Shift+Left".move-column-to-monitor-left = { };
            "Mod+Ctrl+Shift+Right".move-column-to-monitor-right = { };
            "Mod+Ctrl+Shift+Up".move-column-to-monitor-up = { };
            "Mod+Ctrl+Shift+Down".move-column-to-monitor-down = { };

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
            "Mod+Page_Down".focus-workspace-down = { };
            "Mod+Page_Up".focus-workspace-up = { };
            "Mod+Shift+Page_Down".move-column-to-workspace-down = { };
            "Mod+Shift+Page_Up".move-column-to-workspace-up = { };

            # Alternative index-relative bindings using Comma and Period
            "Mod+Comma".focus-workspace-down = { };
            "Mod+Period".focus-workspace-up = { };
            "Mod+Shift+Comma".move-column-to-workspace-down = { };
            "Mod+Shift+Period".move-column-to-workspace-up = { };

            # ───── Column Width Control ─────

            "Mod+Minus".set-column-width = "-10%";
            "Mod+Equal".set-column-width = "+10%";
            "Mod+R".set-column-width = "100%";
            "Mod+W".switch-preset-column-width = { };
            "Mod+M".maximize-column = { };

            # Remove if unsupported in your version.

            # "Mod+C".center-column = {};

            # "Mod+Shift+R".reset-window-height = {};

            # ───── Screenshots ─────

            "Print".screenshot = { };
            "Ctrl+Print".screenshot-screen = { };
            "Alt+Print".screenshot-window = { };

            # ───── Effects / Safety / UI ─────

            "Mod+F1".show-hotkey-overlay = { };
            "Mod+Tab".toggle-overview = { };
            "Mod+Escape".toggle-keyboard-shortcuts-inhibit = { };
            "Mod+Ctrl+Space".do-screen-transition = { }; # Adjusted from Shift+Space to avoid conflict

            # ───── Media Keys ─────

            "XF86MonBrightnessUp".spawn-sh = "${lib.getExe pkgs.brightnessctl} set +5%";

            "XF86MonBrightnessDown".spawn-sh = "${lib.getExe pkgs.brightnessctl} set 5%-";

            "XF86AudioRaiseVolume".spawn-sh =
              "${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 5%+";

            "XF86AudioLowerVolume".spawn-sh =
              "${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 5%-";

            "XF86AudioMute".spawn-sh =
              "${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SINK@ toggle";

            "XF86AudioPlay".spawn-sh = "${lib.getExe pkgs.playerctl} play-pause";

            "XF86AudioNext".spawn-sh = "${lib.getExe pkgs.playerctl} next";

            "XF86AudioPrev".spawn-sh = "${lib.getExe pkgs.playerctl} previous";
          };
        };
      };
    };
}
