# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xemu
    #proton-ge-bin
    protonup-qt
    ferium
    ani-cli
    heroic
    pcsx2
    mangohud
    bottles
    wineWowPackages.stable
    (wine.override { wineBuild = "wine64"; })

    # wine-staging (version with experimental features)
    wineWowPackages.staging

    # winetricks (all versions)
    winetricks

    # native wayland support (unstable)
    wineWowPackages.waylandFull
    gamemode
    lutris

  ];
}

