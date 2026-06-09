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
            # CachyOS Proton is not in nixpkgs for this flake right now.
            # Add an overlay-provided proton-cachyos package here if you bring one in.
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
  };
}