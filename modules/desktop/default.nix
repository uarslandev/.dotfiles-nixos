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


#	services.xserver.windowManager.xmonad.haskellPackages = pkgs.haskell.packages.ghc98.override {
#         overrides = self: super: {
#           xmonad-contrib = self.callHackageDirect {
#              pkg = "xmonad-contrib";
#              ver = "0.18.1";
#              sha256 = "sha256-3N85ThXu3dhjWNAKNXtJ8rV04n6R+/rGeq5C7fMOefY=";
#           } {};
#         };
#       };

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
