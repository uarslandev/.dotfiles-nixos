{ inputs, ... }: {

    flake.nixosModules.cli = {pkgs, ...}: {
        environment.systemPackages = with pkgs; [
            ripgrep
            fd
            fzf
            eza
            bat
            jq
            yq
            unzip
            zip
            wget
            curl
            tree
            btop
            fastfetch
            git
            rsync
            just
        ];
    };
}