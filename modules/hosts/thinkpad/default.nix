{ self, inputs, ... }:
{
  flake.nixosConfigurations.thinkpad = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.thinkpadConfiguration
      self.nixosModules.niri
      self.nixosModules.desktop
      self.nixosModules.thinkpad-defaults # Aggregates all general features

      # Shell & Core Utilities
      self.nixosModules.zsh
      self.nixosModules.core
      self.nixosModules.mimetypes
    ];
  };
}
