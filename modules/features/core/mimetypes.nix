{ self, ... }: {
  flake.nixosModules.mimetypes = { pkgs, ... }: {
    # System-wide packages needed for these associations to work flawlessly
    environment.systemPackages = with pkgs; [
      alacritty
      kdePackages.dolphin
      firefox
      vscode
    ];

    # Configure global system mime apps and default terminal standard
    xdg = {
      mime = {
        enable = true;
        defaultApplications = {
          # Directories & File Browsing
          "inode/directory" = [ "org.kde.dolphin.desktop" ];

          # PDF Reader
          "application/pdf" = [ "firefox.desktop" ];

          # Code / Text Editing
          "text/plain" = [ "code.desktop" ];
          "text/markdown" = [ "code.desktop" ];
          "application/json" = [ "code.desktop" ];
          "text/javascript" = [ "code.desktop" ];
          
          # Web / Links
          "text/html" = [ "firefox.desktop" ];
          "x-scheme-handler/http" = [ "firefox.desktop" ];
          "x-scheme-handler/https" = [ "firefox.desktop" ];
          "x-scheme-handler/about" = [ "firefox.desktop" ];
          "x-scheme-handler/unknown" = [ "firefox.desktop" ];
        };
      };
      
      # Sets Alacritty as the default fallback system handler for terminal tasks
      terminal-exec = {
        enable = true;
        package = pkgs.alacritty;
      };
    };
  };
}