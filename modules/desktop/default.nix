# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
	services.xserver.enable = true;
	services.xserver.displayManager.lightdm.enable = true;
	services.xserver.desktopManager.gnome = {
		enable = true;
	};
	 #services.xserver.windowManager.xmonad.config = builtins.readFile ../path/to/xmonad.h;
	 services.xserver.windowManager = {
		 xmonad = {
			 enable = true;
			 enableContribAndExtras = true;
			 extraPackages = haskellPackages: [
				 haskellPackages.dbus
					 haskellPackages.List
					 haskellPackages.monad-logger
			 ];
		 };
	 };



   #environment.sessionVariables.NIXOS_OZONE_WL = "1";

   environment.systemPackages = with pkgs; [
		xmobar
		lxappearance
		feh
		rofi
		flameshot
		networkmanagerapplet
		arandr
		pavucontrol
		autorandr
		brightnessctl
		alacritty
		i3lock-color
		dunst
   ];
}
