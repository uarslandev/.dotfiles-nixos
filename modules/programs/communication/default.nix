# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
services.zerotierone = {
  enable = true;
  joinNetworks = [
    "52b337794ff81812"
  ];
};
  environment.systemPackages = with pkgs; [
	vesktop
	qbittorrent
	slack
	zoom-us
	thunderbird
	youtube-music
	google-chrome
	tor-browser
  ];
}

