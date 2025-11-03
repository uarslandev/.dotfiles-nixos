# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:
let
  oldPkgs = import (builtins.fetchTarball {
    url = "https://channels.nixos.org/nixos-24.05/nixexprs.tar.xz";
    sha256 = "1f8j7fh0nl4qmqlxn6lis8zf7dnckm6jri4rwmj0qm1qivhr58lv";
  }) { 
      system = "x86_64-linux";  # Explicitly set your system architecture
    };
in
  {
  environment.systemPackages = with pkgs; [
    arduino
    podman
    podman-desktop
    postgresql
    gemini-cli-bin
    mongodb
    docker-client
    mongodb-cli
    mongodb-compass
    #bc
    #bcompare
    sshfs
    arduino-cli
    arduino-core
    gdb
    gh
    #ida-free
    ghidra
    gitFull
    insomnia
    jetbrains-toolbox
    maven
    ngrok
    nmap
    nodejs
    python3Packages.pip
    python3Packages.virtualenv
    vscode
    bc
    espeak-ng
    jdk17
    python3
    qalculate-gtk
    unityhub
    zulu21
  ];

}
