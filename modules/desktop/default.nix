{ config, pkgs, lib, ... }:

{
	services.xserver.enable = true;
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;
    
    environment.systemPackages = with pkgs; [
      	dconf2nix
		gnome.gnome-tweaks
        gnome.gnome-terminal
        gnome-network-displays
		gnomeExtensions.arcmenu
		gnomeExtensions.gtile
		gnomeExtensions.dash-to-dock
		endeavour
		xwayland
		gnome.mutter
		graphite-cursors
		graphite-gtk-theme
		numix-cursor-theme
		whitesur-cursors
		pavucontrol
   ];
}
