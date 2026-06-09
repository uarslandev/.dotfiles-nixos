{
  flake.nixosModules.virtualisation = { pkgs, ... }: {
    virtualisation.docker = {
      enable = true;
      setSocketVariable = true;
    };
    environment.systemPackages = with pkgs; [ docker-compose ];
  };
}