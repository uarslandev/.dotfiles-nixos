{ config, pkgs, lib, ... }:

{
  imports = [
    "./tlp"
    "./cpufreq"
    "./mongo"
  ];
}
