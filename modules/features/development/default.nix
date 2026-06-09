{ self, inputs, ... }: {
  imports = [
    ./python.nix
    ./neovim.nix
    ./git.nix
    ./containerization.nix
    ./cli-tools.nix
    ./cli.nix
    ./databases.nix
    ./security.nix
    ./ides.nix
    ./networking.nix # New networking module
  ];

  flake.nixosModules.development =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.python
        self.nixosModules.neovim
        self.nixosModules.git
        self.nixosModules.containerization
        self.nixosModules.cli-tools
        self.nixosModules.development-cli
        self.nixosModules.databases
        self.nixosModules.security
        self.nixosModules.ides
        self.nixosModules.networking # New networking module
      ];
    };
}