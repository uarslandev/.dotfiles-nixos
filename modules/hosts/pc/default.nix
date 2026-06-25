{ self, inputs, ... }:
{
  flake.nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.chaotic.nixosModules.default
      self.nixosModules.pcConfiguration
      self.nixosModules.desktop

      # Feature Categories
      self.nixosModules.core
      self.nixosModules.services
      self.nixosModules.graphics
      self.nixosModules.vpn
      self.nixosModules.virtualisation
      self.nixosModules.development
      self.nixosModules.security
      self.nixosModules.gaming
      self.nixosModules.design

      # Ensure user is in necessary groups (moved from deleted flake-module.nix)
      (
        { pkgs, ... }:
        {
          users.users.umut.extraGroups = [
            "networkmanager"
            "wheel"
            "docker"
            "wireshark"
            "video"
          ];
        }
      )
    ];
  };
}
