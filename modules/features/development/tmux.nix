{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.tmux = inputs.wrapper-modules.wrappers.tmux.wrap {
      inherit pkgs;

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
      '';
    };
  };

  flake.nixosModules.tmux = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.tmux
    ];
  };
}
