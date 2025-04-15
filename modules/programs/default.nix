# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
  imports = [
	./packages
#	./gaming
	./communication
	./development
    ./productivity
#    ./resolve
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
	xss-lock.enable = true;
	direnv.enable = true;
    thunar.enable = true;
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
	power-profiles-daemon.enable = true;
	logind = {
	lidSwitch = "ignore";
      extraConfig = ''
        HandlePowerKey=ignore
        HandleSuspendKey=ignore
        HandleHibernateKey=ignore
        HandleLidSwitchDocked=ignore
    '';
  };
};
}

