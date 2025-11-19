# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ 
      ../modules
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.kernelModules = [ "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" "snd-seq" "snd-rawmidi" ];
  boot.supportedFilesystems = [ "ntfs" ];
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  nixpkgs.config.allowUnfree = true;

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  i18n.extraLocaleSettings = {
    LC_MESSAGES = "en_US.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  services.xserver.enable = true;

  services.printing.enable = true;

  security.polkit.enable = true;

  services.libinput.enable = true;

  home-manager.backupFileExtension = "backup";

  users.users.umut = {
    isNormalUser = true;
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    extraGroups = [ "sudo" "wheel" "docker" "libvirtd" "network" "networkmanager" "kvm" "jackaudio" "video" "dialout" ]; # Enable ‘sudo’ for the user.
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024; # 32GB in MB
    }
  ];

  services.xserver.excludePackages = [ pkgs.xterm ];

  environment.systemPackages = with pkgs; [
    vim 
    exfat
    nix-prefetch-scripts
    nurl
    fuse
    fuse3
    fuse2
    file
    neovim
    wget
    pcmanfm
    xarchiver
    neovim
    playerctl
    pciutils
    tree
    ranger
    killall
    neofetch
    btop
    nvtopPackages.full
    networkmanager-openvpn
    networkmanager-vpnc
    htop
    tmux
    fuse
    rar
    patchelf
    nix-search-cli
    ntfs3g
    fd
    fuse3
    lsof
    zip
    unzip
    cifs-utils
    samba
    ffmpeg
    steam-run
    cudatoolkit
    cudaPackages_12.cudnn
    nixpkgs-manual
    ripgrep
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.dconf.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8080 ];
  networking.firewall.allowedUDPPorts = [ 8080 ];
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
