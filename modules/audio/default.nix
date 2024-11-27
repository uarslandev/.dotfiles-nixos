# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
environment.systemPackages = with pkgs; [
	guitarix
	ardour
	jack2
	libjack2
    qjackctl
    pulseaudioFull
];

# hardware.pulseaudio.enable = true;
hardware.pulseaudio.enable = false;
# rtkit is optional but recommended
security.rtkit.enable = true;
services.pipewire = {
  audio.enable = true;
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  jack.enable = true;
  wireplumber.enable = true;
};

}
