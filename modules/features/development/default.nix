{ self, inputs, ... }: {
  flake.nixosModules.applications =
    { ... }:
    {
      imports = [
        self.nixosModules.multimedia
      ];
    };
}