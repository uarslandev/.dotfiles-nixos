{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode
    jetbrains.pycharm-community
    gcc
    gnumake
    python3
    nodejs
    go
  ];
}