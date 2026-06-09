{ self, inputs, ... }:
{
  flake.nixosConfigurations.thinkpad = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.thinkpadConfiguration
      self.nixosModules.niri
      self.nixosModules.desktop

      # Feature Categories
      self.nixosModules.core
      self.nixosModules.virtualisation
      self.nixosModules.development
      self.nixosModules.security-ctf
      self.nixosModules.gaming
      self.nixosModules.design

      # Ensure user is in necessary groups (moved from deleted flake-module.nix)
      ({ pkgs, ... }: {
        users.users.umut.extraGroups = [ 
          "networkmanager" 
          "wheel" 
          "docker" 
          "wireshark" 
          "video" 
        ];
      })
    ];
  };
}
