{ self, inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.tmux = inputs.wrapper-modules.wrappers.tmux.wrap {
        inherit pkgs;

        prefix = "C-a";

        terminal = "screen-256color";
        terminalOverrides = "xterm-256color:RGB";
        mouse = true;
        baseIndex = 1;
        paneBaseIndex = 1;
        escapeTime = 0;

        configAfter = ''
          # Status bar styling
          set -g status-style bg=default
          set -g status-left-length 20
          set -g status-right ""

          # Easy tab (window) management
          # Create new tab with prefix + t or prefix + c (opens in current pane path)
          bind-key t new-window -c "#{pane_current_path}"
          bind-key c new-window -c "#{pane_current_path}"

          # Delete current tab (window) with prefix + k or prefix + X
          bind-key k kill-window
          bind-key X kill-window

          # Send current pane to a new tab (window) with prefix + b
          bind-key b break-pane

          # Switch tabs easily with Shift + Left/Right arrow keys (no prefix needed)
          bind-key -n S-Left previous-window
          bind-key -n S-Right next-window

          # Sessionizer: run tmux-sessionizer inside a new tmux window
          bind-key -r C-f run-shell "tmux neww tmux-sessionizer"
        '';
      };
    };

  flake.nixosModules.tmux =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.tmux
      ];
    };
}
