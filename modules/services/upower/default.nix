{ config, pkgs, ... }:

{
  services.upower = {
    enable = true;
    percentageLow = 15;
    percentageCritical = 5;
    percentageAction = 4;
    criticalPowerAction = "Hibernate";
  };
}
