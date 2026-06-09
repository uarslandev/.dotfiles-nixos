{ self, ... }: {
  flake.nixosModules.mimetypes = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      alacritty
      kdePackages.dolphin
      firefox
      vscode
      kdePackages.kservice # REQUIRED: Gives Dolphin the caching tool it expects
    ];

    # CRITICAL FIX FOR DOLPHIN OUTSIDE PLASMA:
    # Tells KDE apps to look for standard menus and use the correct platform data.
    environment.sessionVariables = {
      XDG_MENU_PREFIX = "plasma-";
    };

    # Declaratively generate the Freedesktop application menu blueprint that Dolphin demands
    environment.etc."xdg/menus/plasma-applications.menu".text = ''
      <!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Menu 1.0//EN"
       "http://www.freedesktop.org/standards/menu-spec/menu-1.0.dtd">
      <Menu>
        <Name>Applications</Name>
        <DefaultAppDirs/>
        <DefaultDirDirs/>
        <DefaultLayout inline="false" show_empty="false">
          <Merge type="all"/>
        </DefaultLayout>
        <Include>
          <All/>
        </Include>
      </Menu>
    '';

    xdg = {
      mime = {
        enable = true;
        defaultApplications = {
          "inode/directory" = [ "org.kde.dolphin.desktop" ];
          "application/pdf" = [ "firefox.desktop" ];
          "text/plain" = [ "code.desktop" ];
          "text/markdown" = [ "code.desktop" ];
          "application/json" = [ "code.desktop" ];
          "text/javascript" = [ "code.desktop" ];
          "text/html" = [ "firefox.desktop" ];
          "x-scheme-handler/http" = [ "firefox.desktop" ];
          "x-scheme-handler/https" = [ "firefox.desktop" ];
        };
      };
      
      terminal-exec = {
        enable = true;
        package = pkgs.alacritty;
      };
    };
  };
}