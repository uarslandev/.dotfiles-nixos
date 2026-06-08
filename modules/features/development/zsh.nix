{ self, inputs, ... }: {
  flake.nixosModules.zsh = { pkgs, ... }: {
    programs.zsh = {
      enable = true;

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;

      shellAliases = {
        ll = "ls -lah";
        la = "ls -A";
        dfs = "cd ~/.dotfiles";
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
      gcd = "git commit -m $(date +'%F_%T')";
      nixpkgs-help = "chrome /nix/store/arl0kk5jl0vjyvjj6sp4mhxjclj5d8ac-nixpkgs-manual/share/doc/nixpkgs/manual.html";
      backup = "pushd ~/.dotfiles; ga .; gcd; gp; popd";
        u = "pushd ~/.dotfiles; sudo nixos-rebuild switch --flake .#$(hostname); popd";
      };

      histSize = 10000;

      promptInit = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
      '';
    };

    users.defaultUserShell = pkgs.zsh;
  };
}