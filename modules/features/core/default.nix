{ self, ... }:
{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.cli
        self.nixosModules.mimetypes
        self.nixosModules.ai
        self.nixosModules.alacritty
      ];

      programs = {
        firefox.enable = true;
        thunderbird.enable = true;
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
        teamspeak6-client
        telegram-desktop
        thunderbird
        vim
        zoom-us
      ];
    };
}
