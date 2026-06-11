{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.alacritty = inputs.wrapper-modules.wrappers.alacritty.wrap {
      inherit pkgs;

      settings = {
        window = {
          decorations = "None";
          dynamic_title = true;
        };
        font = {
          size = 11.0;
        };
      };
    };
  };

  flake.nixosModules.alacritty = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.alacritty
    ];
  };
}
