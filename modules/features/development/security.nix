{ self, inputs, ... }: {
  flake.nixosModules.security = { pkgs, ... }: {
    # Wireshark requires a program wrapper for correct setuid/capabilities
    programs.wireshark.enable = true;
  };
}