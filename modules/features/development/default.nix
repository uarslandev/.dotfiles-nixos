{ self, inputs, ... }: {
  flake.nixosModules.gaming = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      steam
      lutris
      heroic
      bottles        # Advanced Windows environment manager
      mangohud       # FPS counter and system overlay
      gamemode       # Performance daemon
      gameconqueror  # Cheat Engine-like GUI for memory editing (scanmem frontend)
      
      # Windows Compatibility Layer
      wine-staging   # Bleeding edge Wine for better game compatibility
      winetricks     # Helper script to install DLLs and libraries in Wine
    ];

    # Steam requires some global configuration for hardware acceleration and DRM
    programs.steam.enable = true;

    # Enable GameMode optimizations (daemon and renice support)
    programs.gamemode.enable = true;
  };
}