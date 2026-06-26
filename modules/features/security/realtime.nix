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
          value = "99999";
        }
        {
          domain = "@audio";
          item = "nofile";
          type = "hard";
          value = "99999";
        }
        # --- Add Esync Limits Here ---
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

      # Systemd limits required for Esync/Fsync compatibility
      systemd.extraConfig = ''
        DefaultLimitNOFILE=524288
      '';

      systemd.user.extraConfig = ''
        DefaultLimitNOFILE=524288
      '';
    };
}
