{ self, inputs, ... }:
{
  flake.nixosModules.networking =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Other networking tools
        # iputils # for ping, ifconfig, etc.
        # netcat
      ];
    };
}

