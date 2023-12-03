# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
   services.xserver.windowManager.xmonad = {
   enable = true;
   enableContribAndExtras = true;
   extraPackages = haskellPackages: [
      haskellPackages.dbus
      haskellPackages.List
      haskellPackages.monad-logger
    ];
 };

   environment.systemPackages = with pkgs; [
		dmenu
		trayer
		arandr
		autorandr
		gnome.gnome-terminal
		flameshot
		rofi
		brightnessctl
		picom
		dunst
		playerctl
		i3lock-color
		feh
		graphite-cursors
		graphite-gtk-theme
		numix-cursor-theme
		apple-cursor
		whitesur-cursors
		luna-icons
		tango-icon-theme
		numix-icon-theme
		xmobar
		polybar
		sierra-breeze-enhanced
		lxappearance
		pavucontrol
   ];
}
