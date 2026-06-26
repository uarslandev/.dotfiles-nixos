{ self, inputs, ... }:
{
  flake.nixosModules.pcHardware =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];
      networking.hostId = "a512f6dd";

      services.zfs.autoScrub.enable = true;
      services.zfs.trim.enable = true;

      fileSystems."/" = {
        device = "zpool/root";
        fsType = "zfs";
        options = [ "zfsutil" ];
      };

      fileSystems."/nix" = {
        device = "zpool/nix";
        fsType = "zfs";
        options = [ "zfsutil" ];
      };

      fileSystems."/var" = {
        device = "zpool/var";
        fsType = "zfs";
        options = [ "zfsutil" ];
      };

      fileSystems."/home" = {
        device = "zpool/home";
        fsType = "zfs";
        options = [ "zfsutil" ];
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-id/ata-Samsung_SSD_870_EVO_1TB_S6PUNF0R703815P-part1";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };

      fileSystems."/home/umut/HDD" = {
        device = "/dev/disk/by-uuid/2d10aef3-aa68-41ec-b219-ddffef913f65";
        fsType = "ext4";
      };

      swapDevices = [
        {
          device = "/dev/disk/by-id/ata-Samsung_SSD_870_EVO_1TB_S6PUNF0R703815P-part2";
          randomEncryption = true;
        }
      ];

      # Enable Nvidia GPU support
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
        # Modesetting is required for Wayland.
        modesetting.enable = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        # Enable this if you have graphical corruption after sleep or suspend.
        powerManagement.enable = false;

        # Fine-grained power management. Turns off GPU when not in use.
        # Only available on Turing and newer GPUs (GTX 16xx, RTX 20xx+).
        powerManagement.finegrained = false;

        # Use the Nvidia open source kernel module (not to be confused with nouveau)
        # Only available on Turing and newer GPUs.
        # For Pascal (GTX 1060), this MUST be false!
        open = false;

        # Enable the Nvidia settings menu, accessible via `nvidia-settings`.
        nvidiaSettings = true;

        # Option to select the driver package.
        package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
