{ self, inputs, ... }:
{
  flake.nixosModules.sddm =
    { pkgs, ... }:
    {
      imports = [
        inputs.qylock.nixosModules.default
      ];

      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };

      programs.qylock = {
        enable = true;
        theme = "pixel-sakura";
      };
    };
}
