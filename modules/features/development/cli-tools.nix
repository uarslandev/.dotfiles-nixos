{ self, inputs, ... }: {
  flake.nixosModules.cli-tools =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Add general CLI tools here
        tree
        wget
      ];
    };
}