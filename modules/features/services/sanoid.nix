{ self, ... }:
{
  flake.nixosModules.sanoid =
    { pkgs, ... }:
    {
      # Enable syncoid to pull the dataset from batcave
      services.syncoid = {
        enable = true;
        sshKey = "/var/lib/syncoid/id_ed25519";
        commonArgs = [
          "--recursive"
          "--no-sync-snap"
        ];

        commands = {
          "immich-backup" = {
            source = "user@batcave:tank/immich";
            target = "zpool/backups/immich";
            extraArgs = [ "--sshoption=Port=22" ];
          };
        };
      };

      # Local sanoid configuration is preserved but disabled (not included in active config)
      services.sanoid = {
        enable = false;
        interval = "hourly";

        datasets = {
          "zpool/home" = {
            useTemplate = [ "production" ];
            recursive = true;
          };
          "zpool/backups/immich" = {
            useTemplate = [ "backup" ];
            recursive = true;
          };
        };

        templates = {
          "production" = {
            hourly = 24;
            daily = 7;
            monthly = 3;
            yearly = 0;
            autosnap = true;
            autoprune = true;
          };
          "backup" = {
            hourly = 30;
            daily = 30;
            monthly = 12;
            yearly = 0;
            autosnap = false;
            autoprune = true;
          };
        };
      };
    };
}
