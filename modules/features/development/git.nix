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
          # Pre-configure gh credential helper to avoid "read-only file system" errors
          # when running `gh auth login`, as the git wrapper locks the global config.
          "credential \"https://github.com\"".helper = "!${pkgs.gh}/bin/gh auth git-credential";
          "credential \"https://gist.github.com\"".helper = "!${pkgs.gh}/bin/gh auth git-credential";
          # Force Git to use SSH for all GitHub operations
          url."git@github.com:".insteadOf = "https://github.com/";
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
