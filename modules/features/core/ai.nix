{ pkgs, ... }: {
  flake.nixosModules.ai = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      gemini-cli
      gpt-codex-agent
    ];
  };
}
