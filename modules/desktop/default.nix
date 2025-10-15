{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";
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
    kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
    kdePackages.kcalc # Calculator
    kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
    kdePackages.kclock # Clock app
    kdePackages.kcolorchooser # A small utility to select a color
    kdePackages.kolourpaint # Easy-to-use paint program
    kdePackages.ksystemlog # KDE SystemLog Application
    kdePackages.sddm-kcm # Configuration module for SDDM
    kdiff3 # Compares and merges 2 or 3 files or directories
    kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
    kdePackages.partitionmanager # Optional: Manage the disk devices, partitions and file systems on your computer
    # Non-KDE graphical packages
    vlc # Cross-platform media player and streaming server
    wayland-utils # Wayland utilities
    wl-clipboard # Command-line copy/paste utilities for Wayland

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
        trayer
        autorandr
        brightnessctl
        alacritty
        i3lock-color
        dunst

        # Hyprland
        xdg-desktop-portal-hyprland
        kitty
        swww
        hyprlock
        swaylock-effects
        hypridle
        wl-clipboard
        waybar
        kanshi
        hyprshot
        nwg-look
        nwg-displays
        hyprpicker
        wofi
      ];
    }
