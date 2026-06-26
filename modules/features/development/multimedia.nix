{ self, inputs, ... }:
{
  flake.nixosModules.multimedia =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        vlc
        mpv
        ffmpeg
        pavucontrol
        reaper
        guitarix
        ardour
        guitarix-vst
        neural-amp-modeler-lv2
        carla # Recommended LV2/VST host
        gxplugins-lv2
        kapitonov-plugins-pack
        chow-centaur
        lsp-plugins
        coppwr
        qjackctl
        # Audio/Video editing (optional)
        # audacity
      ];
    };
}
