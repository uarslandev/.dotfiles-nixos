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
      self.nixosModules.ides
      self.nixosModules.neovim
      self.nixosModules.tmux
      self.nixosModules.latex
    ];

    environment.systemPackages = with pkgs; [
      vscode
      jetbrains.pycharm
      gcc
      gnumake
      python3
      nodejs
      go
    ];
  };
}