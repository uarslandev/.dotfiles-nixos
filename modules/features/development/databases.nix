{ self, inputs, ... }: {
  flake.nixosModules.databases = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # SQL GUI Clients
      dbeaver-bin
      # MongoDB GUI Clients
      # mongodb-compass # Often requires nix-ld or specific setup
      # robomongo
    ];
  };
}
