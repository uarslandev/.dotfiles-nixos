{ self, ... }: {
  flake.nixosModules.applications =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Add your GUI applications here
        firefox
        discord
        vlc
      ];
    };
}