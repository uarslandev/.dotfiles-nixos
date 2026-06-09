{ self, inputs, ... }:
{
  flake.nixosConfigurations.thinkpad = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.thinkpadConfiguration
      self.nixosModules.niri
      self.nixosModules.desktop

      # Feature Categories
      self.nixosModules.development
      self.nixosModules.gaming

      # Shell & Core Utilities
      self.nixosModules.zsh
      self.nixosModules.cli
      self.nixosModules.core
      self.nixosModules.mimetypes
    ];
  };
}
