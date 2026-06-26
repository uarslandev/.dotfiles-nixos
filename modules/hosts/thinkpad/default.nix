{ self, inputs, ... }:
{
  flake.nixosConfigurations.thinkpad = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.chaotic.nixosModules.default
      self.nixosModules.thinkpadConfiguration
      self.nixosModules.desktop

      # Feature Categories
      self.nixosModules.core
      self.nixosModules.services
      self.nixosModules.graphics
      self.nixosModules.vpn
      self.nixosModules.virtualisation
      self.nixosModules.sanoid
      self.nixosModules.development
      self.nixosModules.security
      self.nixosModules.realtime
      self.nixosModules.gaming
      self.nixosModules.design

      # Ensure user is in necessary groups (moved from deleted flake-module.nix)
      (
        { pkgs, ... }:
        {
          users.users.umut.extraGroups = [
            "networkmanager"
            "realtime"
            "wheel"
            "docker"
            "wireshark"
            "video"
            "audio"
          ];
        }
      )
    ];
  };
}
