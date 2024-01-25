# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  	vscode
	python3
	python3Packages.pip
	python3Packages.virtualenv
	arduino-core
	arduino
	arduino-cli
	jetbrains-toolbox
	git
	ghidra
	gdb
	nmap
	ngrok
	insomnia
	maven
	nodejs
	jdk17
	qalculate-gtk
  ];
}

