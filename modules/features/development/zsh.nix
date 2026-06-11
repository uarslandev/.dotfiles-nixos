{ self, inputs, ... }: {
  perSystem = { pkgs, self', ... }: {
    packages.zsh = inputs.wrapper-modules.wrappers.zsh.wrap {
      inherit pkgs;

      zshAliases = {
        ll = "ls -lah";
        la = "ls -A";
        dfs = "cd ~/.dotfiles";
        b = "backup";
        n = "nvim";
        wip = "git add . && git commit -m 'wip' && git push";
        nix-search = "nix search nixpkgs";
        nix-update = "nix flake update";
        ta = "tmux attach -t";
        tn = "tmux new -s";
        tls = "tmux ls";
        tk = "tmux kill-session -t";
        t = "tmux";
        ga = "git add";
        gb = "git branch -a";
        gc = "git commit -m";
        gp = "git push";
        sd = "backup && shutdown now";
        gcd = "git commit -m $(date +'%F_%T')";
        nixpkgs-help = "chrome /nix/store/arl0kk5jl0vjyvjj6sp4mhxjclj5d8ac-nixpkgs-manual/share/doc/nixpkgs/manual.html";
        backup = "pushd ~/.dotfiles; ga .; gcd; gp; popd";
        u = "pushd ~/.dotfiles; sudo nixos-rebuild switch --flake .#$(hostname); popd";
        ssh = "TERM=xterm-256color ssh";
      };

      zshrc.content = ''
        # Powerlevel10k Prompt
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

        # Interactive Shell Initialization
        # Use emacs keybindings even if EDITOR is set to vi
        bindkey -e

        # Movement
        bindkey "^[[1;5C" forward-word                # Ctrl+Right
        bindkey "^[[1;5D" backward-word               # Ctrl+Left
        bindkey "^[[1;3C" forward-word                # Alt+Right
        bindkey "^[[1;3D" backward-word               # Alt+Left
        bindkey "^[[H" beginning-of-line              # Home
        bindkey "^[[F" end-of-line                    # End
        bindkey "^[[3~" delete-char                   # Delete
        bindkey "^[[3;5~" kill-word                   # Ctrl+Delete
        bindkey "^[[3;3~" kill-word                   # Alt+Delete
        bindkey "^[[3;2~" backward-kill-word          # Shift+Delete
        bindkey "^H" backward-kill-word               # Ctrl+Backspace
        bindkey "^[^?" backward-kill-word             # Alt+Backspace
        bindkey "^[[Z" reverse-menu-complete          # Shift+Tab

        # Make word navigation behave more like bash
        WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
      '';

      runtimePkgs = [
        self'.packages.neovim
        pkgs.fzf
        pkgs.tmux
        pkgs.git
        pkgs.ripgrep
        pkgs.fd
      ];
    };
  };

  flake.nixosModules.zsh = { pkgs, ... }: {
    programs.zsh.enable = true;
    users.defaultUserShell = self.packages.${pkgs.stdenv.hostPlatform.system}.zsh;
  };
}
