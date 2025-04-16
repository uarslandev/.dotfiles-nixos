# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];
  networking.hostName = "pc";

  #boot.kernelParams = [ "amd_iommu=on" "nvidia-drm.fbdev=1"];
  boot.kernelModules = [ "kvm-amd" ];
  #boot.extraModprobeConfig = "options vfio-pci ids=10de:1d01, 10de:0fb8";


#  nixpkgs.overlays = [
#    (final: prev: {
#      davinci-resolve-studio = prev.davinci-resolve-studio.overrideAttrs (oldAttrs: {
#        postInstall = ''
#          rm -rf $out/bin/resolve
#        '';
#      });
#    })
#  ];
#
  environment.systemPackages = with pkgs; [
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;

    enable32Bit = true;
  };


}
