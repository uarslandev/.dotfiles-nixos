{ self, inputs, ... }: {
  flake.nixosModules.development-cli = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      gh # GitHub CLI
      # Add other general CLI tools here
      # htop
      lazygit
    ];
  };
}