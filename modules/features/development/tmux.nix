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

          # Delete current tab (window) with prefix + X
          bind-key X kill-window

          # Vim-style pane selection (prefix + hjkl)
          bind-key h select-pane -L
          bind-key j select-pane -D
          bind-key k select-pane -U
          bind-key l select-pane -R

          # Increase repeat timeout for repeatable bindings (e.g. pane resizing) to 1.5 seconds
          set -g repeat-time 1500

          # Vim-style pane resizing (prefix + Alt + hjkl, repeatable)
          bind-key -r M-h resize-pane -L 2
          bind-key -r M-j resize-pane -D 2
          bind-key -r M-k resize-pane -U 2
          bind-key -r M-l resize-pane -R 2

          # Send current pane to a new tab (window) with prefix + b
          bind-key b break-pane

          # Switch tabs easily with Shift + Left/Right arrow keys (no prefix needed)
          bind-key -n S-Left previous-window
          bind-key -n S-Right next-window

          # Sessionizer: run tmux-sessionizer inside a new tmux window
          bind-key -r C-f run-shell "tmux neww tmux-sessionizer"

          # F12 toggles local tmux keybindings off/on for nested/remote sessions
          bind -n F12 set prefix None \; set key-table off \; set status-left " #[fg=colour203]● [REMOTE] " \; set status-style bg=colour236,fg=colour245 \; refresh-client -S
          bind -T off F12 set -u prefix \; set -u key-table \; set -u status-left \; set -u status-style \; refresh-client -S
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
