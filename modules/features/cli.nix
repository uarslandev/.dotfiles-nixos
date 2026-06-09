{
  flake.nixosModules.cli = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      ripgrep fd fzf eza bat jq yq
      unzip zip rsync wget curl
      tree btop fastfetch just gh
    ];
  };
}