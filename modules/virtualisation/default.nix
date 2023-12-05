# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
	dmidecode
  ];

  virtualisation = {
  docker.enable = true;
	libvirtd = {
		enable = true;
		qemu = {
			swtpm.enable = true;
			ovmf.enable = true;
			ovmf.packages = [ pkgs.OVMFFull.fd ];
		};
	};
	spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
}

