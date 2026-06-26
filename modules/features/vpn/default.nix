{ ... }:
{
  flake.nixosModules.vpn =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        wireguard-tools
        tailscale
        openvpn
        networkmanager-openvpn
        cloudflared
        cloudflare-warp
      ];
      services.cloudflare-warp.enable = true;
      services.tailscale.enable = true;
    };
}
