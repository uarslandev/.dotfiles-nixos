{ self, inputs, ... }: {
  flake.nixosModules.git = { pkgs, ... }: {
    programs = {
      gh.enable = true;
    git = {
      enable = true;

      config = {
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };
    };
  };
}
