{ config, pkgs, lib, ... }:
let
  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "hyprland_kath";
  };
in
  {
    services.xserver.enable = true;
    services.xserver.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
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
    xdg-desktop-portal-hyprland
    dunst
    brightnessctl
    #custom-sddm-astronaut
    networkmanagerapplet
    pavucontrol
    hyprpicker
    kitty
    swww
    hyprlock
    hyprpaper
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
