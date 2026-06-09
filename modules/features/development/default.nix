{ self, inputs, ... }: {
  flake.nixosModules.gaming =
    { pkgs, ... }:
    {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      programs = {
        gamemode.enable = true;

        gamescope = {
          enable = true;
          capSysNice = true;
        };

        steam = {
          enable = true;
          gamescopeSession.enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = true;
          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };
      };

      environment.systemPackages = with pkgs; [
        bottles
        goverlay
        heroic
        lutris
        mangohud
        protontricks
        protonup-qt
        scanmem
        steamtinkerlaunch
        winetricks
      ];
    };
}