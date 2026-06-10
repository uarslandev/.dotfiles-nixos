{ self, inputs, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.niri
        self.nixosModules.sddm
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
        GTK_IM_MODULE = "fcitx";
        QT_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";
      };

      i18n.inputMethod = {
        enabled = "fcitx5";
        fcitx5.addons = with pkgs; [
          fcitx5-mozc
          fcitx5-gtk
        ];
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
