{ self, inputs, ... }: {
  flake.nixosConfigurations.thinkpad = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.thinkpadConfiguration
      self.nixosModules.niri
      # Development
      self.nixosModules.zsh
      self.nixosModules.git
      self.nixosModules.neovim
      # Core
      self.nixosModules.cli
      self.nixosModules.core
    ];
  };
}
