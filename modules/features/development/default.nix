{ self, ... }: {
  flake.nixosModules.development = { pkgs, ... }: {
    imports = [
      self.nixosModules.databases
      self.nixosModules.multimedia
      self.nixosModules.containerization
      self.nixosModules.networking
      self.nixosModules.security
      self.nixosModules.python
      self.nixosModules.zsh
      self.nixosModules.git
      self.nixosModules.cli-tools
      self.nixosModules.security-tools
      self.nixosModules.ides
      self.nixosModules.neovim
    ];

    environment.systemPackages = with pkgs; [
      vscode
      jetbrains.pycharm-oss
      gcc
      gnumake
      python3
      nodejs
      go
    ];
  };
}