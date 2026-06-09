{ ... }: {
  flake.nixosModules.security = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # Reverse Engineering & Debugging
      ghidra-bin
      binwalk
      radare2
      cutter
      iaito
      gdb
      strace
      ltrace
      pwntools

      # Network & Exploitation
      nmap
      wireshark
      metasploit
      burpsuite
      sqlmap
      gobuster

      # Password Cracking
      john
      hashcat
    ];
    
    programs.wireshark.enable = true;
    
    security.rtkit.enable = true;
  };
}
