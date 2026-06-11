{ self, inputs, ... }:
{
  flake.nixosModules.ai =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        gemini-cli
        claude-code
      ];
    };
}
