{ self, inputs, ... }: {
  # This file defines the 'applications' module referenced in your features/default.nix
  flake.nixosModules.applications =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # GUI Applications
        firefox
        discord
        vlc
      ];
    };
}