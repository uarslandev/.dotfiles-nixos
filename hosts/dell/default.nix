# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  networking.hostName = "dell";

  #boot.extraModprobeConfig = "options vfio-pci ids=10de:1f12,10de:10f9,10de:1ada,10de:1adb";
}

