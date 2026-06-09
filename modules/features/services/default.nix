{ self, ... }: {
  flake.nixosModules.services = { ... }: {
    imports = [
      self.nixosModules.syncthing
    ];
  };
}
