{ self, inputs, ... }: {
  imports = [
    ./cli.nix
    ./databases.nix
    ./security.nix
    ./ides.nix
    ./python.nix
    ./neovim.nix
    ./git.nix
  ];

  flake.nixosModules.development =
    { ... }:
    {
      imports = [
        self.nixosModules.development-cli
        self.nixosModules.databases
        self.nixosModules.security
        self.nixosModules.ides
        self.nixosModules.python
        self.nixosModules.neovim
        self.nixosModules.git
      ];
    };
}