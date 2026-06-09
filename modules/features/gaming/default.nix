{
  flake.nixosModules.gaming = { pkgs, ... }: {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    environment.systemPackages = with pkgs; [
      mangohud # FPS Counter and Overlay
      goverlay # GUI for mangohud
      gamemode
    ];
  };
}