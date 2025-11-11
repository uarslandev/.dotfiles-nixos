{ config, pkgs, lib, ... }:

{
  imports = [
    "./tlp"
    "./cpufreq"
    "./upower"
    "./mongo"
  ];
}
