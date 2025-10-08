{ config, pkgs, lib, ... }:

{
  # Enable the systemd service for Kanshi
  systemd.services.kanshi = {
    description = "Kanshi";
    after = [ "session.target" ];
    requires = [ "session.target" ];
    
    serviceConfig = {
      ExecStart = "${pkgs.kanshi}/bin/kanshi -c ${config.home.homeDirectory}/.config/kanshi/config.d/${toString config.system.hostName}";
      Restart = "on-failure";
      RestartSec = "1s";
    };
  };
}
