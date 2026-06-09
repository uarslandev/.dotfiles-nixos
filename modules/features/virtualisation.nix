{
  flake.nixosModules.virtualisation = { pkgs, ... }: {
    virtualisation.docker.enable = true;
    environment.systemPackages = with pkgs; [ docker-compose ];
  };
}