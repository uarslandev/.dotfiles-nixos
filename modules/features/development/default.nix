{ self, inputs, ... }: {
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
        self.nixosModules.containerization
        self.nixosModules.cli-tools
      ];
    };
}