{ inputs, ... }:
{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
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
        vim
        zoom-us
      ];
    };
}
