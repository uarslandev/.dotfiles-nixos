# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  networking.hostName = "thinkpad";
  boot.kernelParams = ["intel_iommu=on"];
  boot.kernelModules = ["kvm-intel"];


  systemd.targets.sleep.enable = true;
  systemd.targets.suspend.enable = true;
  systemd.targets.hibernate.enable = true;
  systemd.targets.hybrid-sleep.enable = true;


  services.cron = {
    systemCronJobs = [
      "*/1 * * * *      umut    echo 'connect DC:2C:26:3A:09:04' | bluetoothctl"
      "*/1 * * * *      umut    dfs && git pull"
    ];
  };

  hardware.graphics = {
    enable = true;
    driSupport32Bit = true;
   extraPackages = with pkgs; [
      rocmPackages.clr.icd
      intel-compute-runtime
   ];
 };
  
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
}
