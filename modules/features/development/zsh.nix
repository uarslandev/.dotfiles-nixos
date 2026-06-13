{ self, inputs, ... }:
{
  perSystem =
    { pkgs, self', ... }:
    {
      packages.tmux-sessionizer = pkgs.writeShellScriptBin "tmux-sessionizer" ''
        if [[ $# -eq 1 ]]; then
            selected=$1
        else
            selected=$( ${pkgs.findutils}/bin/find ~/Repos ~/Projects ~/Github ~/Gitlab -mindepth 1 -maxdepth 1 -type d 2>/dev/null | ${pkgs.fzf}/bin/fzf )
        fi

        if [[ -z $selected ]]; then
            exit 0
        fi

        selected_name=$(basename "$selected" | tr . _)
        tmux_running=$(pgrep tmux)

        if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
            ${pkgs.tmux}/bin/tmux new-session -s "$selected_name" -c "$selected"
            exit 0
        fi

        if ! ${pkgs.tmux}/bin/tmux has-session -t "$selected_name" 2>/dev/null; then
            ${pkgs.tmux}/bin/tmux new-session -ds "$selected_name" -c "$selected"
        fi

        if [[ -z $TMUX ]]; then
            ${pkgs.tmux}/bin/tmux attach-session -t "$selected_name"
        else
            ${pkgs.tmux}/bin/tmux switch-client -t "$selected_name"
        fi
      '';

      # Portable Zsh package for use with 'nix run' on other systems
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
          # Powerlevel10k requirement: unset prompt_cr
          unsetopt prompt_cr

          # Enable Powerlevel10k instant prompt.
          if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
            source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
          fi

          # Powerlevel10k Prompt
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

          # Use emacs keybindings even if EDITOR is set to vi
          bindkey -e

          # Movement
          bindkey "^[[1;5C" forward-word
          bindkey "^[[1;5D" backward-word
          bindkey "^[[1;3C" forward-word
          bindkey "^[[1;3D" backward-word
          bindkey "^[[H" beginning-of-line
          bindkey "^[[F" end-of-line
          bindkey "^[[3~" delete-char
          bindkey "^[[3;5~" kill-word
          bindkey "^[[3;3~" kill-word
          bindkey "^[[3;2~" backward-kill-word
          bindkey "^H" backward-kill-word
          bindkey "^[^?" backward-kill-word
          bindkey "^[[Z" reverse-menu-complete

          # Make word navigation behave more like bash
          WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

          # bind ctrl+f to tmux-sessionizer
          tmux-sessionizer-widget() {
            zle -I
            tmux-sessionizer
            zle redisplay
          }
          zle -N tmux-sessionizer-widget
          bindkey '^f' tmux-sessionizer-widget

          # Finalize p10k
          (( ! ''${+functions[p10k]} )) || p10k finalize
        '';

        runtimePkgs = [
          self'.packages.neovim
          self'.packages.git
          self'.packages.tmux
          self'.packages.tmux-sessionizer
          pkgs.gemini-cli
          pkgs.antigravity-cli
          pkgs.claude-code
          pkgs.fzf
          pkgs.ripgrep
          pkgs.fd
        ];
      };
    };

  flake.nixosModules.zsh =
    { pkgs, ... }:
    {
      programs.zsh = {
        enable = true;

        # Disable default NixOS prompt init which sets prompt_cr
        promptInit = "";

        shellInit = ''
          # This runs at the very top of /etc/zshrc
          if [[ -o interactive ]]; then
            # Powerlevel10k requirement: unset prompt_cr
            unsetopt prompt_cr

            # Enable Powerlevel10k instant prompt.
            if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
              source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
            fi
          fi
        '';

        shellAliases = {
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

        interactiveShellInit = ''
          # Powerlevel10k Prompt
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

          # Use emacs keybindings even if EDITOR is set to vi
          bindkey -e

          # Movement
          bindkey "^[[1;5C" forward-word
          bindkey "^[[1;5D" backward-word
          bindkey "^[[1;3C" forward-word
          bindkey "^[[1;3D" backward-word
          bindkey "^[[H" beginning-of-line
          bindkey "^[[F" end-of-line
          bindkey "^[[3~" delete-char
          bindkey "^[[3;5~" kill-word
          bindkey "^[[3;3~" kill-word
          bindkey "^[[3;2~" backward-kill-word
          bindkey "^H" backward-kill-word
          bindkey "^[^?" backward-kill-word
          bindkey "^[[Z" reverse-menu-complete

          # Make word navigation behave more like bash
          WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

          # bind ctrl+f to tmux-sessionizer
          tmux-sessionizer-widget() {
            zle -I
            tmux-sessionizer
            zle redisplay
          }
          zle -N tmux-sessionizer-widget
          bindkey '^f' tmux-sessionizer-widget

          # Finalize p10k
          (( ! ''${+functions[p10k]} )) || p10k finalize
        '';
      };

      users.defaultUserShell = pkgs.zsh;
      users.users.umut.shell = pkgs.zsh;

      environment.systemPackages = [
        pkgs.fzf
        pkgs.ripgrep
        pkgs.fd
        self.packages.${pkgs.stdenv.hostPlatform.system}.tmux-sessionizer
      ];
    };
}
