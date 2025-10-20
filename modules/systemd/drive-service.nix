{ config, pkgs, ... }:

{
  systemd.user = {
    services.rclone-bisync = {
      enable = true;
      description = "Run Rclone bisync between local Drive and remote drive1";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.rclone}/bin/rclone bisync %h/Drive drive1: \
--create-empty-src-dirs \
--compare size,modtime,checksum \
--slow-hash-sync-only \
--resilient \
-MvP \
--drive-skip-gdocs \
--fix-case";
      };
    };

    timers.rclone-bisync = {
      enable = true;
      description = "Timer to run Rclone bisync every 2 minutes";
      timerConfig = {
        OnActiveSec = "2min";
        OnUnitActiveSec = "2min";
        Persistent = true;
      };
      wantedBy = [ "timers.target" ];
    };
  };
}

