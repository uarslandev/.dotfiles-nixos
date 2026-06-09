{
  flake.nixosModules.core-apps = { pkgs, ... }: {
    services.syncthing = {
      enable = true;
      user = "umut";
      dataDir = "/home/umut/Documents";
      configDir = "/home/umut/.config/syncthing";
    };
    environment.systemPackages = with pkgs; [
      thunderbird
      obsidian
      discord
      syncthing
    ];
  };
}