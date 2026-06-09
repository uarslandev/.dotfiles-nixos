{ self, ... }:
{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.cli
        self.nixosModules.mimetypes
      ];

      programs = {
        firefox.enable = true;
        thunderbird.enable = true;
      };

      services.syncthing = {
        enable = true;
        user = "umut";
        dataDir = "/home/umut/Documents";
        configDir = "/home/umut/.config/syncthing";
      };

      environment.systemPackages = with pkgs; [
        discord
        element-desktop
        keepassxc
        libreoffice-qt6-fresh
        networkmanagerapplet
        nextcloud-client
        obsidian
        signal-desktop
        syncthing
        teamspeak6-client
        telegram-desktop
        vim
        zoom-us
      ];
    };
}
