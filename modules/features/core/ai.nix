{ pkgs, ... }: {
  flake.nixosModules.ai = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # Gemini CLI and GPT Codex agents would go here.
      # Assuming they are available in nixpkgs or as custom packages.
      # For now, adding generic placeholders or common tools if known.
    ];
  };
}
