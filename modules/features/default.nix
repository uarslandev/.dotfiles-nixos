{ self, inputs, ... }: {
  imports = [
    ./applications
    ./development
    ./system
    ./gaming/default.nix # Explicitly import the default.nix from gaming folder
  ];

  flake.nixosModules.features =
    { ... }:
    {
      imports = [
        self.nixosModules.applications # This should be self.nixosModules.applications
        self.nixosModules.development # This should be self.nixosModules.development
        self.nixosModules.system # This should be self.nixosModules.system
        self.nixosModules.gaming # This should be self.nixosModules.gaming
      ];
    };
}