{ config, pkgs, ... }:

# Note: This snippet assumes 'pkgs.kanshi' is available in your scope.
# If you are using Home Manager, you might prefer setting this within your
# Home Manager configuration file, which already has 'pkgs' in scope.

{
  # Define a systemd service that runs under the user session (i.e., systemctl --user)
  systemd.user.services.kanshi = {
    # Start the service when the user logs in
    enable = true;
    description = "Kanshi Display Manager";

    # Corresponds to the [Unit] section
    unitConfig = {
      # This ensures kanshi starts only after the 'session.target' is active.
      Requires = [ "session.target" ];
      After = [ "session.target" ];
    };

    # Corresponds to the [Service] section
    serviceConfig = {
      Type = "simple";
      
      # Use the Nix store path for the executable and systemd variables for the path.
      # %h resolves to the user's home directory ($HOME).
      # %H resolves to the hostname (as in your original unit).
      ExecStart = "${pkgs.kanshi}/bin/kanshi -c %h/.config/kanshi/config.d/%H";
      
      Restart = "on-failure";
      RestartSec = 1;
    };
    
    # Since your custom session.target already *Wants* this service, we don't strictly need
    # 'wantedBy', but leaving this commented out for reference.
    # wantedBy = [ "graphical-session.target" ];
  };
}
