{ config, pkgs, lib, ... }:

{
	services.xserver.enable = true;
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      haskellPackages = pkgs.haskell.packages.ghc98;
      extraPackages = hpkgs: [
        hpkgs.xmonad_0_18_0
        hpkgs.xmonad-extras
        hpkgs.xmonad-contrib_0_18_1
      ]; 
    };
    services.xserver.desktopManager.gnome = {
      enable = true;
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer']
      '';
    };

 #   environment.sessionVariables.NIXOS_OZONE_WL = "1";
    
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

      dconf2nix
      xwayland
      xdg-desktop-portal
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
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
