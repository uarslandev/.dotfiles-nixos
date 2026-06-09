{ self, inputs, ... }: {
  flake.nixosModules.security-tools = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # Reverse Engineering & Debugging
      ghidra
      binwalk
      radare2
      cutter     # GUI for radare2
      iaito      # Alternative GUI for radare2
      gdb
      pwndbg     # GDB plugin for exploit dev
      strace
      ltrace

      # Network & Exploitation
      nmap
      metasploit
      burpsuite
      sqlmap

      # Password Cracking
      john
      hashcat
    ];
  };
}