{ config, pkgs, ... }:

{
  imports = [
    # 1. Import the file that *defines* the custom service
    ./kanshi-service.nix 
    ./drive-service.nix
  ];

  # Define the custom 'session.target' user unit
  systemd.user.targets.session = {
    # This enables and makes the unit available under systemctl --user
    enable = true;
    
    # Corresponds to Description="Session Target"
    description = "Session Target";

    # Corresponds to the [Unit] directives
    unitConfig = {
      # This ensures your custom target starts after the session pre-setup is done
      After = [ "graphical-session-pre.target" ];
    };

    # Corresponds to WantedBy=graphical-session.target
    # This makes the main graphical session pull in your custom session target.
    wantedBy = [ "graphical-session.target" ];

    # Corresponds to all the Wants= directives in your original file.
    # When this target is activated (when you log in), it will try to start all these units.
    wants = [
#      "drive.timer"
#      "youtube-music-player.service"
#      "fcitx5.service"
#      "xss-lock.service"
      "kanshi.service"
#      "swww.service"
    ];
  };
  
  # You must ensure the services/timers listed in 'wants' are defined and enabled
  # elsewhere in your configuration (e.g., fcitx5 and kanshi).
}

