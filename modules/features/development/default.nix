{ self, inputs, ... }: {
  imports = [
    ./networking.nix
    ./containerization.nix
  ];

  flake.nixosModules.system =
    { ... }:
    {
      imports = [
        self.nixosModules.networking
        self.nixosModules.containerization
      ];
    };
}