{ config, pkgs, lib, ... }:

{
	services.xserver.enable = true;
    services.xserver.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
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
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

 environment.systemPackages = with pkgs; [
        # Xmonad
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

        # Hyprland
        xdg-desktop-portal-hyprland
        kitty
        swww
        swaylock-effects
        hypridle
        wl-clipboard
        waybar
        hyprshot
        nwg-look
        hyprpicker
        wofi
   ];
}
