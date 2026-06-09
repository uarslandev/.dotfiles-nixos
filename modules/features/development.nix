{
  flake.nixosModules.development = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      vscode
      jetbrains.pycharm-oss
      gcc
      gnumake
      python3
      nodejs
      go
    ];
  };
}