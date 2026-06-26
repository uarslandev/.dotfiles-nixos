{ ... }:
{
  flake.nixosModules.realtime =
    { pkgs, ... }:
    {
      security.pam.loginLimits = [
        {
          domain = "@audio";
          item = "memlock";
          type = "-";
          value = "unlimited";
        }
        {
          domain = "@audio";
          item = "rtprio";
          type = "-";
          value = "99";
        }
        {
          domain = "@audio";
          item = "nofile";
          type = "soft";
          value = "1048576";
        }
        {
          domain = "@audio";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
        # --- Esync Limits ---
        {
          domain = "*";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "*";
          item = "nofile";
          type = "hard";
          value = "524288";
        }
      ];

      # Modern structured settings for systemd
      systemd.settings = {
        Manager = {
          DefaultLimitNOFILE = "524288";
        };
      };
    };
}
