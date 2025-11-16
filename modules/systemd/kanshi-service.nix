{ config, pkgs, ... }:

{
  systemd.user.services.kanshi = {
    enable = true;
    description = "Kanshi Display Manager";

    unitConfig = {
      Requires = [ "local.target" ];
      After = [ "local.target" ];
    };

    serviceConfig = {
      Type = "simple";
      
      ExecStart = "${pkgs.kanshi}/bin/kanshi -c %h/.config/kanshi/config.d/%H";
      
      Restart = "on-failure";
      RestartSec = 1;
    };
    
  };
}
