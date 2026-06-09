{ self, inputs, ... }: {
  flake.nixosModules.multimedia = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      vlc
      mpv
      ffmpeg
      pavucontrol
      # Audio/Video editing (optional)
      # audacity
    ];
  };
}