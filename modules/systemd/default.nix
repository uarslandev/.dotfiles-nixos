{ config, pkgs, ... }:

{
  imports = [
    ./kanshi-service.nix 
  ];

  systemd.user.targets.local = {
    enable = true;
    description = "Session Target";
    
    unitConfig = {
      After = [ "graphical-session-pre.target" ];
    };

    wantedBy = [ "graphical-session.target" ];
    wants = [
      "kanshi.service"
    ];
  };
}
