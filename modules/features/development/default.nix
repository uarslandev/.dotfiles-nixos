{ self, inputs, ... }: {
  imports = [
    ./multimedia.nix
  ];

  flake.nixosModules.applications =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.multimedia
      ];
      environment.systemPackages = with pkgs; [
        # Add your GUI applications here
        firefox
        discord
      ];
    };
}