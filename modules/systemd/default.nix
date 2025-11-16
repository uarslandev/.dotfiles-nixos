{ config, pkgs, ... }:

{
  imports = [
    ./kanshi-service.nix
  ];

  systemd.user.targets."session" = {
    enable = true;
    description = "My Custom Session Target";

    unitConfig = {
      After = [ "graphical-session-pre.target" ];
      Wants = [ "kanshi.service" ];
    };

    wantedBy = [ "graphical-session.target" ];
  };
}

