# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
	vesktop
	slack
	zoom-us
	zerotierone
	teamspeak_client
	thunderbird
	youtube-music
	google-chrome
	firefox
	chromium
  ];
}

