{ self, inputs, ... }: {
  flake.nixosModules.ides = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      jetbrains.idea
      jetbrains.pycharm-professional
      jetbrains.datagrip
      jetbrains.webstorm
      jetbrains.clion
      vscode
    ];
    # Required for many IDE binaries and language servers to run on NixOS
    programs.nix-ld.enable = true;
  };
}