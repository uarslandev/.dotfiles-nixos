{
  flake.nixosModules.design = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      inkscape
      gimp
      krita
      kdePackages.kdenlive
      blender
    ];
  };
}
