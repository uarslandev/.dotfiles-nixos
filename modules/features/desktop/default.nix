{ self, ... }: {

  flake.nixosModules.desktop = { ... }: {
    imports = [
      self.nixosModules.niri
      # Add other desktop modules here as they are created
    ];
  };

}