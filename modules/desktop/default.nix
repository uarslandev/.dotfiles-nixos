{ config, pkgs, lib, ... }:

{
	services.xserver.enable = true;
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer']
      '';
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    
    environment.systemPackages = with pkgs; [
      dconf2nix
      xwayland
		gnome.gnome-tweaks
        gnome.gnome-terminal
        xdg-desktop-portal
        mutter43
        xdg-desktop-portal-gnome 
        xdg-desktop-portal-gtk
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
