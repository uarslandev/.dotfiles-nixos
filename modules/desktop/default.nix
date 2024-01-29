# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
	services.xserver.enable = true;
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome = {
		enable = true;
	};

   #environment.sessionVariables.NIXOS_OZONE_WL = "1";



   environment.systemPackages = with pkgs; [
		dconf2nix
		gnome.gnome-tweaks
		gnome.gnome-terminal
		gnomeExtensions.arcmenu
		gnomeExtensions.gtile
		endeavour
		#xwaylandvideobridge
		xwayland
		kitty
		brightnessctl
		autotiling
		gnome.mutter
		arandr
		autorandr
		graphite-cursors
		graphite-gtk-theme
		numix-cursor-theme
		whitesur-cursors
		luna-icons
		tango-icon-theme
		numix-icon-theme
		sierra-breeze-enhanced
		pavucontrol
   ];
}
