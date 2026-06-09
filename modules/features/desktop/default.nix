{ self, inputs, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.niri
      ];

      programs.dconf.enable = true;
      services.gvfs.enable = true;
      services.tumbler.enable = true;

      xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-wlr
        ];
        config.common.default = [
          "gtk"
          "wlr"
        ];
      };

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        SDL_VIDEODRIVER = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
      };

      environment.systemPackages = with pkgs; [
        adwaita-icon-theme
        brightnessctl
        cliphist
        gnome-themes-extra
        helvum
        imv
        kanshi
        libnotify
        nautilus
        nwg-look
        pavucontrol
        playerctl
        swappy
        wl-clipboard
        wdisplays
        wev
        xdg-utils
      ];
    };
}
