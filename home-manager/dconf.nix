# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "com/usebottles/bottles" = {
      startup-view = "page_list";
    };

    "org/gnome/Console" = {
      last-window-maximised = false;
      last-window-size = mkTuple [ 652 480 ];
    };

    "org/gnome/Extensions" = {
      window-height = 1048;
      window-maximized = true;
      window-width = 1280;
    };

    "org/gnome/calendar" = {
      active-view = "month";
      window-maximized = true;
      window-size = mkTuple [ 768 600 ];
    };

    "org/gnome/control-center" = {
      last-panel = "keyboard";
      window-state = mkTuple [ 980 640 false ];
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = [ "Utilities" "YaST" "Pardus" ];
    };

    "org/gnome/desktop/app-folders/folders/Pardus" = {
      categories = [ "X-Pardus-Apps" ];
      name = "X-Pardus-Apps.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [ "gnome-abrt.desktop" "gnome-system-log.desktop" "nm-connection-editor.desktop" "org.gnome.baobab.desktop" "org.gnome.Connections.desktop" "org.gnome.DejaDup.desktop" "org.gnome.Dictionary.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.Evince.desktop" "org.gnome.FileRoller.desktop" "org.gnome.fonts.desktop" "org.gnome.Loupe.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.tweaks.desktop" "org.gnome.Usage.desktop" "vinagre.desktop" ];
      categories = [ "X-GNOME-Utilities" ];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/YaST" = {
      categories = [ "X-SuSE-YaST" ];
      name = "suse-yast.directory";
      translate = true;
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/pixels-l.jxl";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/pixels-d.jxl";
      primary-color = "#967864";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/input-sources" = {
      mru-sources = [ (mkTuple [ "xkb" "us" ]) ];
      sources = [ (mkTuple [ "xkb" "de+us" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "breeze_cursors";
      enable-hot-corners = false;
      gtk-theme = "Adwaita";
      icon-theme = "Adwaita";
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "vesktop" ];
    };

    "org/gnome/desktop/notifications/application/vesktop" = {
      application-id = "vesktop.desktop";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/pixels-l.jxl";
      primary-color = "#967864";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Shift><Super>q" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close,minimize,maximize:appmenu";
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      experimental-features = [ "scale-monitor-framebuffer" ];
      overlay-key = "Super_L";
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [ 890 550 ];
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-schedule-automatic = false;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "gnome-terminal";
      name = "gnome-terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Shift><Super>i";
      command = "pavucontrol";
      name = "pavucontrol";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Shift><Super>o";
      command = "keepassxc";
      name = "keepassxc";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      binding = "<Shift><Super>p";
      command = "nautilus";
      name = "nautilus";
    };

    "org/gnome/shell" = {
      disabled-extensions = [ "light-style@gnome-shell-extensions.gcampax.github.com" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" "window-list@gnome-shell-extensions.gcampax.github.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "apps-menu@gnome-shell-extensions.gcampax.github.com" "arcmenu@arcmenu.com" "dash-to-dock@micxgx.gmail.com" "gTile@vibou" "launch-new-instance@gnome-shell-extensions.gcampax.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "next-up@artisticat1.github.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "system-monitor@gnome-shell-extensions.gcampax.github.com" "status-icons@gnome-shell-extensions.gcampax.github.com" ];
      welcome-dialog-last-shown-version = "47.1";
    };

    "org/gnome/shell/extensions/arcmenu" = {
      arcmenu-hotkey = [ "<Super>d" ];
      distro-icon = 22;
      menu-button-icon = "Distro_Icon";
      menu-layout = "Runner";
      prefs-visible-page = 0;
      recently-installed-apps = [ "unityhub.desktop" ];
      runner-position = "Centered";
      search-entry-border-radius = mkTuple [ true 25 ];
    };

    "org/gnome/shell/extensions/gtile" = {
      show-toggle-tiling = [ "<Control>Return" ];
    };

    "org/gnome/shell/world-clocks" = {
      locations = [];
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

  };
}
