{ self, inputs, ... }:
{
  perSystem =
    { pkgs, self', ... }:
    {
      packages.tmux-sessionizer = pkgs.writeShellScriptBin "tmux-sessionizer" ''
        RECENT_FILE="$HOME/.local/share/tmux-recent"
        mkdir -p "$(dirname "$RECENT_FILE")"
        touch "$RECENT_FILE"

        if [[ $# -eq 1 ]]; then
            selected=$1
        else
            # Scan repositories dynamically up to depth 4, fallback to directories up to depth 2 if none found
            repos=$(${pkgs.findutils}/bin/find ~/ -name '.*' -not -name '.git' -prune -o -name .git -type d -exec dirname {} \; 2>/dev/null)
            if [[ -n "$repos" ]]; then
                all_dirs="$repos"
            else
                all_dirs=$(${pkgs.findutils}/bin/find ~/ -maxdepth 2 -name '.*' -prune -o -type d -print 2>/dev/null)
            fi
            selection_out=$( (cat "$RECENT_FILE"; echo "$all_dirs") | awk 'NF && !seen[$0]++' | ${pkgs.fzf}/bin/fzf --prompt="Select session (Del to delete): " --height=40% --reverse --expect=del)
            
            if [[ -z "$selection_out" ]]; then
                exit 0
            fi

            key=$(echo "$selection_out" | head -n 1)
            selected=$(echo "$selection_out" | tail -n +2)

            if [[ -z "$selected" ]]; then
                exit 0
            fi

            if [[ "$key" == "del" ]]; then
                selected=$(realpath "$selected")
                if grep -qF "$selected" "$RECENT_FILE"; then
                    echo -n "Are you sure you want to delete '$selected' from recents? (y/N): "
                    read -r answer < /dev/tty
                    if [[ "$answer" =~ ^[Yy]$ ]]; then
                        grep -vF "$selected" "$RECENT_FILE" > "$RECENT_FILE.tmp"
                        mv "$RECENT_FILE.tmp" "$RECENT_FILE"
                        echo "Deleted '$selected' from recents."
                    else
                        echo "Deletion cancelled."
                    fi
                    sleep 1
                fi
                exec "$0" "$@"
            fi
        fi

        selected=$(realpath "$selected")

        # Update recent sessions list
        echo "$selected" | cat - "$RECENT_FILE" | awk '!seen[$0]++' > "$RECENT_FILE.tmp" && mv "$RECENT_FILE.tmp" "$RECENT_FILE"

        selected_name=$(basename "$selected" | tr . _)
        if [[ -z "$TMUX" ]]; then
            if ! ${pkgs.tmux}/bin/tmux has-session -t "$selected_name" 2>/dev/null; then
                ${pkgs.tmux}/bin/tmux new-session -s "$selected_name" -c "$selected"
            else
                ${pkgs.tmux}/bin/tmux attach-session -t "$selected_name"
            fi
        else
            if ! ${pkgs.tmux}/bin/tmux has-session -t "$selected_name" 2>/dev/null; then
                ${pkgs.tmux}/bin/tmux new-session -ds "$selected_name" -c "$selected"
            fi
            ${pkgs.tmux}/bin/tmux switch-client -t "$selected_name"
        fi
      '';

      packages.tmux-ssh-sessionizer = pkgs.writeShellScriptBin "tmux-ssh-sessionizer" ''
        RECENT_FILE="$HOME/.local/share/tmux-ssh-recent"
        mkdir -p "$(dirname "$RECENT_FILE")"
        touch "$RECENT_FILE"

        NEW_CONN_LABEL="[New Connection]"

        # Use fzf --expect to capture Delete key
        selection_out=$( (echo "$NEW_CONN_LABEL"; cat "$RECENT_FILE") | ${pkgs.fzf}/bin/fzf --prompt="Select SSH session (Del to delete): " --height=40% --reverse --expect=del)

        if [[ -z "$selection_out" ]]; then
            exit 0
        fi

        key=$(echo "$selection_out" | head -n 1)
        selection=$(echo "$selection_out" | tail -n +2)

        if [[ -z "$selection" ]]; then
            exit 0
        fi

        if [[ "$key" == "del" ]]; then
            if [[ "$selection" != "$NEW_CONN_LABEL" ]]; then
                echo -n "Are you sure you want to delete '$selection'? (y/N): "
                read -r answer < /dev/tty
                if [[ "$answer" =~ ^[Yy]$ ]]; then
                    grep -vF "$selection" "$RECENT_FILE" > "$RECENT_FILE.tmp"
                    mv "$RECENT_FILE.tmp" "$RECENT_FILE"
                    echo "Deleted '$selection'."
                else
                    echo "Deletion cancelled."
                fi
                sleep 1
                exec "$0" "$@"
            else
                exec "$0" "$@"
            fi
        fi

        if [[ "$selection" == "$NEW_CONN_LABEL" ]]; then
            # Step 1: Select Host
            # Use grep -h to prevent multi-file filename prefixes
            hosts=$(grep -h -i "^Host " ~/.ssh/config ~/.ssh/config.d/* 2>/dev/null | awk '{print $2}' | grep -v '\*' | sort -u)
            if [[ -z "$hosts" ]]; then
                echo "No hosts found in ~/.ssh/config. Please enter host manually:"
                read -r host < /dev/tty
            else
                host=$(echo "$hosts" | ${pkgs.fzf}/bin/fzf --prompt="Select host: " --height=40% --reverse)
            fi

            if [[ -z "$host" ]]; then
                exit 0
            fi

            # Step 2: Query remote directories
            echo "Connecting to $host to find repositories/folders..."
            
            # Pass command as argument and keep stdout/stderr attached to terminal
            remote_cmd="repos=\$(find ~/ -maxdepth 4 -name .git -type d -exec dirname {} \\; 2>/dev/null); if [ -n \"\$repos\" ]; then echo \"\$repos\"; else find ~/ -maxdepth 2 -type d 2>/dev/null; fi"
            
            # Capture output first, and redirect stderr to a temp file.
            # This hides harmless warnings (like "not a terminal" from cloudflared) if successful,
            # but prints them if the connection actually fails.
            err_file=$(mktemp)
            remote_dirs=$(ssh -F ~/.ssh/config -o ConnectTimeout=15 "$host" "sh -c '$remote_cmd'" 2> "$err_file")

            if [[ -z "$remote_dirs" ]]; then
                echo "Connection failed or no directories found." >&2
                if [[ -s "$err_file" ]]; then
                    cat "$err_file" >&2
                fi
                rm -f "$err_file"
                sleep 5
                exit 0
            fi
            rm -f "$err_file"

            remote_dir=$(echo "$remote_dirs" | ${pkgs.fzf}/bin/fzf --prompt="Select remote directory: " --height=40% --reverse)

            if [[ -z "$remote_dir" ]]; then
                exit 0
            fi

            selected_host="$host"
            selected_dir="$remote_dir"
        else
            selected_host=$(echo "$selection" | cut -d':' -f1)
            selected_dir=$(echo "$selection" | cut -d':' -f2-)
        fi

        # Update recent sessions list
        entry="$selected_host:$selected_dir"
        echo "$entry" | cat - "$RECENT_FILE" | awk '!seen[$0]++' > "$RECENT_FILE.tmp" && mv "$RECENT_FILE.tmp" "$RECENT_FILE"

        # Determine session name
        dir_base=$(basename "$selected_dir")
        clean_host=$(echo "$selected_host" | tr '.:/ ' '----')
        clean_dir=$(echo "$dir_base" | tr '.:/ ' '----')
        session_name="ssh-$clean_host-$clean_dir"

        # Use system ssh command with explicit config file (stored as array to avoid shell quoting issues)
        ssh_cmd=(ssh -F "$HOME/.ssh/config" -t "$selected_host" "cd '$selected_dir' 2>/dev/null || cd ~; exec \$SHELL -l")
        if [[ -z "$TMUX" ]]; then
            if ! ${pkgs.tmux}/bin/tmux has-session -t "$session_name" 2>/dev/null; then
                ${pkgs.tmux}/bin/tmux new-session -s "$session_name" "''${ssh_cmd[@]}"
            else
                ${pkgs.tmux}/bin/tmux attach-session -t "$session_name"
            fi
        else
            if ! ${pkgs.tmux}/bin/tmux has-session -t "$session_name" 2>/dev/null; then
                ${pkgs.tmux}/bin/tmux new-session -ds "$session_name" "''${ssh_cmd[@]}"
            fi
            ${pkgs.tmux}/bin/tmux switch-client -t "$session_name"
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
          gcd = "git commit -m \"\$(nixos-generation-ordinal) - \$(hostname)\"";
          nixpkgs-help = "chrome /nix/store/arl0kk5jl0vjyvjj6sp4mhxjclj5d8ac-nixpkgs-manual/share/doc/nixpkgs/manual.html";
          backup = "pushd ~/.dotfiles; ga .; gcd; gp; popd";
          u = "pushd ~/.dotfiles; sudo nixos-rebuild switch --flake .#$(hostname); popd";
          ssh = "TERM=xterm-256color ssh";
          wrapper-path = "nix eval --impure --raw --expr '(builtins.getFlake \"/home/umut/.dotfiles\").inputs.wrapper-modules.outPath'";
          tss = "tmux-ssh-sessionizer";
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

          # Helper to get the NixOS generation ordinal or fallback to date
          nixos-generation-ordinal() {
            local link
            if [[ -L /nix/var/nix/profiles/system ]]; then
              link=$(readlink /nix/var/nix/profiles/system)
              local gen=''${link#system-}
              gen=''${gen%-link}
              local suffix="th"
              case $gen in
                *1[0-9]) suffix="th" ;;
                *1) suffix="st" ;;
                *2) suffix="nd" ;;
                *3) suffix="rd" ;;
              esac
              echo "$gen$suffix"
            else
              date +'%F_%T'
            fi
          }

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
            tmux-sessionizer < /dev/tty > /dev/tty 2>/dev/tty
            zle redisplay
          }
          zle -N tmux-sessionizer-widget
          bindkey '^f' tmux-sessionizer-widget

          # bind ctrl+g to tmux-ssh-sessionizer
          tmux-ssh-sessionizer-widget() {
            zle -I
            tmux-ssh-sessionizer < /dev/tty > /dev/tty 2>/dev/tty
            zle redisplay
          }
          zle -N tmux-ssh-sessionizer-widget
          bindkey '^g' tmux-ssh-sessionizer-widget

          # Finalize p10k
          (( ! ''${+functions[p10k]} )) || p10k finalize
        '';

        runtimePkgs = [
          self'.packages.neovim
          self'.packages.git
          self'.packages.tmux
          self'.packages.tmux-sessionizer
          self'.packages.tmux-ssh-sessionizer
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
          gcd = "git commit -m \"\$(nixos-generation-ordinal) - \$(hostname)\"";
          nixpkgs-help = "chrome /nix/store/arl0kk5jl0vjyvjj6sp4mhxjclj5d8ac-nixpkgs-manual/share/doc/nixpkgs/manual.html";
          backup = "pushd ~/.dotfiles; ga .; gcd; gp; popd";
          u = "pushd ~/.dotfiles; sudo nixos-rebuild switch --flake .#$(hostname); popd";
          ssh = "TERM=xterm-256color ssh";
          wrapper-path = "nix eval --impure --raw --expr '(builtins.getFlake \"/home/umut/.dotfiles\").inputs.wrapper-modules.outPath'";
          tss = "tmux-ssh-sessionizer";
        };

        interactiveShellInit = ''
          # Powerlevel10k Prompt
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

          # Helper to get the NixOS generation ordinal or fallback to date
          nixos-generation-ordinal() {
            local link
            if [[ -L /nix/var/nix/profiles/system ]]; then
              link=$(readlink /nix/var/nix/profiles/system)
              local gen=''${link#system-}
              gen=''${gen%-link}
              local suffix="th"
              case $gen in
                *1[0-9]) suffix="th" ;;
                *1) suffix="st" ;;
                *2) suffix="nd" ;;
                *3) suffix="rd" ;;
              esac
              echo "$gen$suffix"
            else
              date +'%F_%T'
            fi
          }

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
            tmux-sessionizer < /dev/tty > /dev/tty 2>/dev/tty
            zle redisplay
          }
          zle -N tmux-sessionizer-widget
          bindkey '^f' tmux-sessionizer-widget

          # bind ctrl+g to tmux-ssh-sessionizer
          tmux-ssh-sessionizer-widget() {
            zle -I
            tmux-ssh-sessionizer < /dev/tty > /dev/tty 2>/dev/tty
            zle redisplay
          }
          zle -N tmux-ssh-sessionizer-widget
          bindkey '^g' tmux-ssh-sessionizer-widget

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
        self.packages.${pkgs.stdenv.hostPlatform.system}.tmux-ssh-sessionizer
      ];
    };
}
