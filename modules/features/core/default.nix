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
        kdeconnect.enable = true;
      };

      environment.systemPackages = with pkgs; [
        anki-bin
        audacity
        google-chrome
        sanoid
        vesktop
        element-desktop
        nixpkgs-manual
        fzf
        keepassxc
        libreoffice-qt6-fresh
        networkmanagerapplet
        nextcloud-client
        obsidian
        qbittorrent
        signal-desktop
        teamspeak6-client
        telegram-desktop
        thunderbird
        vim
        zoom-us
      ];

      systemd.tmpfiles.rules = [
        "d /home/umut/.config/Nextcloud 0755 umut users - -"
        "L+ /home/umut/.config/Nextcloud/nextcloud.cfg - umut users - /home/umut/.dotfiles/modules/features/core/nextcloud.cfg"
      ];
    };
}
