{ config, pkgs, lib, ... }:

{
	services.xserver.enable = true;
	services.xserver.displayManager.lightdm.enable = true;
	services.xserver.desktopManager.gnome = {
		enable = true;
	};

	services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
	extraPackages = hp: [ hp.xmonad hp.xmonad-contrib hp.xmonad-extras hp.xmonad-utils];
  };

   environment.systemPackages = with pkgs; [
		picom
		stack
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
