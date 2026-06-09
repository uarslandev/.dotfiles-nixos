{ self, ... }: {
  flake.nixosModules.thinkpad = { ... }: {
    imports = [
      self.nixosModules.thinkpadConfiguration # Hardware/Specific config
      self.nixosModules.core
      self.nixosModules.virtualisation
      self.nixosModules.development
      self.nixosModules.security-ctf
      self.nixosModules.gaming
      self.nixosModules.design
    ];
  };
}