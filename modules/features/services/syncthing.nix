{ self, ... }: {
  flake.nixosModules.syncthing = { pkgs, ... }: {
    services.syncthing = {
      enable = true;
      user = "umut";
      dataDir = "/home/umut/Documents";
      configDir = "/home/umut/.config/syncthing";
    };
    environment.systemPackages = [ pkgs.syncthing ];
  };
}
