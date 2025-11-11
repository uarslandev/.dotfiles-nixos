{ config, pkgs, ... }:

{
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        "hosts allow" = "192.168.0. 127.0.0.1 localhost";
        "hosts deny"  = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      public = {
        "path" = "/mnt/mapper/";   # your mounted encrypted folder
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
      };
    };
  };

  networking.firewall.allowPing = true;
}
