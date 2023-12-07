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
	scream
	dmidecode
	looking-glass-client
	pv
	pigz
  ];

  systemd.tmpfiles.rules = [
  "f /dev/shm/looking-glass 0660 umut qemu-libvirtd -"
  ];

  systemd.user.services.scream-ivshmem = {
  enable = true;
  description = "Scream IVSHMEM";
  serviceConfig = {
    ExecStart = "${pkgs.scream}/bin/scream-ivshmem-pulse /dev/shm/scream";
    Restart = "always";
  };
  wantedBy = [ "multi-user.target" ];
  requires = [ "pulseaudio.service" ];
};


  virtualisation = {
  docker.enable = true;
	libvirtd = {
		enable = true;
		qemu = {
			swtpm.enable = true;
			ovmf.enable = true;
			ovmf.packages = [ pkgs.OVMFFull.fd ];
		};
		onBoot = "ignore";
		onShutdown = "shutdown";
	};
	spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
}

