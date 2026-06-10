{ inputs, ... }:
{

  flake.nixosModules.cli =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ripgrep
        fd
        gh
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
        rsync
        just
        git
        lazygit
      ];
    };
}
