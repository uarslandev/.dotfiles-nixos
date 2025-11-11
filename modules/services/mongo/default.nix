{ config, pkgs, ... }:

{
  services.mongodb = {
    enable = true;
    #package = "mongodb-7_0";
    enableAuth = false;
    #bind_ip = "10.5.0.2";
  };
}
