{ config, pkgs, lib, ... }:
let
  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "hyprland_kath";
    #themeConfig = {
    #  Background = "path/to/background.jpg";
    #  Font = "M+1 Nerd Font";
    #};
  };
in
  {
    services.xserver.enable = true;
    services.displayManager.sddm = {
      enable = true;
      extraPackages = [
        custom-sddm-astronaut
      ];

      theme = "sddm-astronaut-theme";
      settings = {
        Theme = {
          Current = "sddm-astronaut-theme";
        };
      };
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
    custom-sddm-astronaut
    kdePackages.qtmultimedia
    dunst
    brightnessctl
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
