{ self, inputs, ... }:
{
  flake.nixosModules.containerization =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Add containerization tools here
        docker
        podman
        podman-desktop
      ];
    };
}

