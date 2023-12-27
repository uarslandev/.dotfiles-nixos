# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  	libreoffice
	davinci-resolve
	glibc
	gimp
	obs-studio
	blender
	kdenlive
	calibre
	texstudio
	texliveFull
	inkscape
  ];
}

