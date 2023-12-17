# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
   services.xserver.windowManager.i3 = {
   enable = true;
 };

 programs.hyprland = {
	enable = true;
	enableNvidiaPatches = true;
	xwayland.enable = true;
 };

 environment.sessionVariables = {
		WLR_NO_HARDWARE_CURSORS = "1";
		NIXOS_OZONE_WL = "1";
 };

 hardware = {
	opengl.enable = true;
	nvidia.modesetting.enable = true;
 };
 security.pam.services.swaylock = {};


 services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # kanshi systemd service
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };


   environment.systemPackages = with pkgs; [
    alacritty # gpu accelerated terminal
	wlr-randr
	kanshi
	wofi
	waybar
    wayland
	xwayland
	xwaylandvideobridge
    xdg-utils # for opening default programs when clicking links
    glib # gsettings
    dracula-theme # gtk theme
    gnome3.adwaita-icon-theme  # default gnome cursors
    swaylock-fancy
    swayidle
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    bemenu # wayland clone of dmenu
    mako # notification system developed by swaywm maintainer
    wdisplays # tool to configure displays
	kitty

		dmenu
		termite
		arandr
		autorandr
		flameshot
		rofi
		networkmanagerapplet
		brightnessctl
		picom
		dunst
		playerctl
		sxhkd
		i3lock-color
		feh
		graphite-cursors
		graphite-gtk-theme
		numix-cursor-theme
		apple-cursor
		volumeicon
		whitesur-cursors
		luna-icons
		tango-icon-theme
		numix-icon-theme
		polybar
		sierra-breeze-enhanced
		lxappearance
		pavucontrol
   ];
}
