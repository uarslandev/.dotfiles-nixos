{ self, inputs, ... }: {
  imports = [
    ./applications
    ./development
    ./system
    ./gaming
  ];

  flake.nixosModules.features =
    { ... }:
    {
      imports = [
        self.nixosModules.applications
        self.nixosModules.development
        self.nixosModules.system
        self.nixosModules.gaming
      ];
    };
}