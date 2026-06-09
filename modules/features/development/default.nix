{ self, inputs, ... }: {
  imports = [
    ./multimedia.nix
  ];

  flake.nixosModules.applications =
    { ... }:
    {
      imports = [
        self.nixosModules.multimedia # This should be self.nixosModules.multimedia
      ];
    };
}