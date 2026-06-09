{ inputs, ... }: {
  flake.nixosModules = {
    # Aggregator module to connect everything to the Thinkpad
    thinkpad-defaults = { config, ... }: {
      imports = [
        # Reference the modules defined in this flake
        inputs.self.nixosModules.cli
        inputs.self.nixosModules.virtualisation
        inputs.self.nixosModules.security-ctf
        inputs.self.nixosModules.development
        inputs.self.nixosModules.core-apps
        inputs.self.nixosModules.gaming
        inputs.self.nixosModules.design
      ];

      # Host specific tweaks
      networking.hostName = "thinkpad";
      
      # Ensure user is in necessary groups
      users.users.umut.extraGroups = [ 
        "networkmanager" 
        "wheel" 
        "docker" 
        "wireshark" 
        "video" 
      ];
    };
  };
}
