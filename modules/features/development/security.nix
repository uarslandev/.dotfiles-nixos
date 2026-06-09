{ self, inputs, ... }: {
  flake.nixosModules.security = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # Reverse Engineering
      ghidra
      radare2
      # binwalk
      # strace
      # CTF Tools (examples)
      # wireshark # Network analysis
      # nmap # Network scanner
    ];

    programs.wireshark.enable = true;
  };
}