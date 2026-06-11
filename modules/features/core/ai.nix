{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: 
  let
    pkgsUnfree = import inputs.nixpkgs {
      inherit (pkgs.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
  in
  {
    packages.ai = inputs.wrapper-modules.wrappers.claude-code.wrap {
      pkgs = pkgsUnfree;
      
      # Bundling other AI tools together
      runtimePkgs = [
        pkgs.gemini-cli
        pkgs.codex
      ];
    };
  };

  flake.nixosModules.ai = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.ai
    ];
  };
}
