{ self, inputs, ... }:
{
  flake.nixosModules.multimedia =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        vlc
        mpv
        ffmpeg
        yabridge
        yabridgectl
        qpwgraph
        pavucontrol
        reaper
        obs-studio
        guitarix
        ardour
        guitarix-vst
        neural-amp-modeler-lv2
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
