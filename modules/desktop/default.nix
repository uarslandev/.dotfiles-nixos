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

  xdg.portal = {
    enable = true;
    # For GNOME or GTK apps, you'll want these:
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    # If you're using KDE, use this instead:
    # extraPortals = [ pkgs.xdg-desktop-portal-kde ];
  };


  environment.systemPackages = with pkgs; [
        # Xmonad
        picom
        stack
        xmobar
        lxappearance
        feh
        plasma5Packages.kdeconnect-kde
        rofi
        flameshot
        glib
        networkmanagerapplet
        arandr
        pavucontrol
        autorandr
        brightnessctl
        alacritty
        i3lock-color
        dunst

        # Hyprland
#        xdg-desktop-portal-hyprland
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
