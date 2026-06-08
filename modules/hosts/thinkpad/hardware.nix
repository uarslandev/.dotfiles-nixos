{ self, inputs, ... }: {
    flake.nixosModules.thinkpadHardware = { config, lib, pkgs, modulesPath, ... }: {
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/luks-c7db5fcf-b6c1-469f-a148-1e7c9433c780";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-c7db5fcf-b6c1-469f-a148-1e7c9433c780".device = "/dev/disk/by-uuid/c7db5fcf-b6c1-469f-a148-1e7c9433c780";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/0FD2-EAEA";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/mapper/luks-c0f3bc45-0014-4d08-a98e-e3ef293dc443"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
};
}