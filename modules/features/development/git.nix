{ self, inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.git = inputs.wrapper-modules.wrappers.git.wrap {
        inherit pkgs;

        settings = {
          init.defaultBranch = "main";
          pull.rebase = true;
          push.autoSetupRemote = true;
          user.name = "Umut Arslan";
          user.email = "umut_arslan@gmx.de";
        };
      };
    };

  flake.nixosModules.git =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.git
      ];
    };
}
