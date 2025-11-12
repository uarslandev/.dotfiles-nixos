# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
  imports = [
    ./packages
    ./gaming
    ./communication
    ./development
    ./productivity
    ./resolve
    ./samba
    ./scripts
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    extraPackages = with pkgs; [
      gamescope
      gamemode
    ];
  };

  programs = {
    #zsh.enable = true;
    fzf.fuzzyCompletion = true;
    #xss-lock.enable = true;
    direnv.enable = true;
  };
  services = {
    gvfs.enable = true;
    flatpak.enable = true;
    printing = {
      enable = true;
      drivers = with pkgs; [ gutenprint hplip samsung-unified-linux-driver brlaser ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}

