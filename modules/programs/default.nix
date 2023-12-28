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
	./scripts
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  nixpkgs.config.permittedInsecurePackages = [
                "electron-25.9.0"
              ];
  programs = {
    zsh.enable = true;
	fzf.fuzzyCompletion = true;
	direnv.enable = true;
	thunar.enable = true;
  };
  services = {
	gvfs.enable = true;
	tlp.enable = true;
	power-profiles-daemon.enable = false;
	autorandr.enable = true;
  };
}

