# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/calendar" = {
      active-view = "month";
      window-maximized = true;
      window-size = mkTuple [ 768 600 ];
    };

    "org/gnome/control-center" = {
      last-panel = "power";
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
      enable-hot-corners = false;
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "gnome-power-panel" "org-keepassxc-keepassxc" "thunderbird" "org-gnome-evolution-alarm-notify" ];
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-evolution-alarm-notify" = {
      application-id = "org.gnome.Evolution-alarm-notify.desktop";
    };

    "org/gnome/desktop/notifications/application/org-keepassxc-keepassxc" = {
      application-id = "org.keepassxc.KeePassXC.desktop";
    };

    "org/gnome/desktop/notifications/application/thunderbird" = {
      application-id = "thunderbird.desktop";
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

    "org/gnome/evolution-data-server/calendar" = {
      reminders-past = [ "eb47dbfefdfa01fffe303a5bf43fe81ab9427703n5e083cda3c5ed9f90b8ab7ecff5ec5eb2f2ca7fdt20241203T110000Zn1733221800n1733223600n1733230800nBEGIN:VEVENTrnDTSTART;TZID=Europe/Berlin:20241203T120000rnDTEND;TZID=Europe/Berlin:20241203T140000rnRRULE:FREQ=WEEKLY;WKST=TUrnDTSTAMP:20241130T181555ZrnUID:rn cli34p1jclj6ab9i64q68b9k70pm8bb1chi66b9gckqjadpg6srjae1p68@google.comrnCREATED:20241008T132603ZrnX-LIC-ERROR;X-LIC-ERRORTYPE=VALUE-PARSE-ERROR:No value for DESCRIPTION rn property. Removing entire property:rnLAST-MODIFIED:20241130T181555ZrnX-LIC-ERROR;X-LIC-ERRORTYPE=VALUE-PARSE-ERROR:No value for LOCATION rn property. Removing entire property:rnSEQUENCE:0rnSTATUS:CONFIRMEDrnSUMMARY:Read Paper for from speech act theory tornTRANSP:OPAQUErnX-MOZ-GENERATION:8rnX-MOZ-GOOGLE-HTML-DESCRIPTION:truernX-MOZ-LASTACK:20241130T181554ZrnX-EVOLUTION-CALDAV-ETAG:63868673755rnRECURRENCE-ID:20241203T110000ZrnBEGIN:VALARMrnACTION:DISPLAYrnDESCRIPTION:This is an event reminderrnTRIGGER:-PT30MrnX-EVOLUTION-ALARM-UID:5e083cda3c5ed9f90b8ab7ecff5ec5eb2f2ca7fdrnEND:VALARMrnEND:VEVENTrn" "eb47dbfefdfa01fffe303a5bf43fe81ab9427703n925adb6de9bd2afbcefa32d2ddbdc53b283fcb3ft20241203T110000Zn1733221800n1733223600n1733230800nBEGIN:VEVENTrnDTSTART;TZID=Europe/Berlin:20241203T120000rnDTEND;TZID=Europe/Berlin:20241203T140000rnRRULE:FREQ=WEEKLY;WKST=TUrnDTSTAMP:20241202T133301ZrnUID:rn 6kpj0p1gclh3eb9g6grmab9kcgp36b9o70rjibb46kr62cj574p3ccb474@google.comrnCREATED:20241202T132131ZrnX-LIC-ERROR;X-LIC-ERRORTYPE=VALUE-PARSE-ERROR:No value for DESCRIPTION rn property. Removing entire property:rnLAST-MODIFIED:20241202T133301ZrnX-LIC-ERROR;X-LIC-ERRORTYPE=VALUE-PARSE-ERROR:No value for LOCATION rn property. Removing entire property:rnSEQUENCE:1rnSTATUS:CONFIRMEDrnSUMMARY:WorkrnTRANSP:OPAQUErnX-EVOLUTION-CALDAV-ETAG:63868829581rnRECURRENCE-ID:20241203T110000ZrnBEGIN:VALARMrnACTION:DISPLAYrnDESCRIPTION:This is an event reminderrnTRIGGER:-PT30MrnX-EVOLUTION-ALARM-UID:925adb6de9bd2afbcefa32d2ddbdc53b283fcb3frnEND:VALARMrnEND:VEVENTrn" ];
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

    "org/gnome/nm-applet/eap/1ff7da60-79cb-3db3-be95-a47c35b6e665" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-schedule-automatic = false;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/" ];
      screensaver = [ "<Shift><Super>w" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "gnome-terminal";
      name = "gnome-terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Shift><Super>o";
      command = "keepassxc";
      name = "keepassxc";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Shift><Super>p";
      command = "nautilus";
      name = "nautilus";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      binding = "<Shift><Super>i";
      command = "pavucontrol";
      name = "pavucontrol";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/shell" = {
      disabled-extensions = [ "auto-move-windows@gnome-shell-extensions.gcampax.github.com" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "window-list@gnome-shell-extensions.gcampax.github.com" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "light-style@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "arcmenu@arcmenu.com" "dash-to-dock@micxgx.gmail.com" "gTile@vibou" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "system-monitor@gnome-shell-extensions.gcampax.github.com" "status-icons@gnome-shell-extensions.gcampax.github.com" "launch-new-instance@gnome-shell-extensions.gcampax.github.com" "apps-menu@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" ];
      favorite-apps = [ "thunderbird.desktop" "org.gnome.Calendar.desktop" "org.gnome.Music.desktop" "org.gnome.Nautilus.desktop" "youtube-music.desktop" "nvim.desktop" ];
      welcome-dialog-last-shown-version = "47.1";
    };

    "org/gnome/shell/extensions/arcmenu" = {
      arcmenu-hotkey = [ "<Super>d" ];
      distro-icon = 22;
      menu-button-icon = "Distro_Icon";
      menu-layout = "Runner";
      prefs-visible-page = 0;
      runner-position = "Centered";
      search-entry-border-radius = mkTuple [ true 25 ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      background-opacity = 0.8;
      custom-theme-shrink = true;
      dash-max-icon-size = 32;
      dock-position = "BOTTOM";
      height-fraction = 0.9;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "DP-1";
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

    "org/gtk/gtk4/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      sidebar-width = 140;
      sort-column = "name";
      sort-directories-first = true;
      sort-order = "ascending";
      type-format = "category";
      view-type = "list";
      window-size = mkTuple [ 857 326 ];
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 157;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 578 141 ];
      window-size = mkTuple [ 1203 902 ];
    };

  };
}
