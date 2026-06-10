{ pkgs, ... }:
{
  flake.nixosModules.ai =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        gemini-cli
        codex
        claude-code
      ];
    };
}
