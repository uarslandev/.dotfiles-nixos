{ self, inputs, ... }: {
  flake.nixosModules.latex = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      texlive.combined.scheme-full
      zathura
    ];
  };
}
