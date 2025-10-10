# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arduino
    arduino-cli
    conda
	arduino-core
	gdb
	gh
	ghidra
	git
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
    ida-free
    jdk17
    python3
    qalculate-gtk
    unityhub
    zulu21
  ];
}
