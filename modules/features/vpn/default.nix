{ ... }: {
  flake.nixosModules.vpn = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      wireguard-tools
      tailscale
      openvpn
      cloudflared
    ];
    
    services.tailscale.enable = true;
  };
}
