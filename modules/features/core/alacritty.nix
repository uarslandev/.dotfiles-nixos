{ pkgs, ... }: {
  flake.nixosModules.alacritty = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.alacritty ];
    
    # System-wide Alacritty configuration
    environment.etc."alacritty/alacritty.toml".text = ''
      [window]
      decorations = "None"
      dynamic_title = true
      
      [font]
      size = 11.0
    '';
  };
}
