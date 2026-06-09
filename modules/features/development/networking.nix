{ self, inputs, ... }: {
  flake.nixosModules.networking = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # VPNs
      openvpn
      networkmanager-openvpn
      # Other networking tools
      # iputils # for ping, ifconfig, etc.
      # netcat
    ];
  };
}