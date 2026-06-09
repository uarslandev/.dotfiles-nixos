{ ... }: {
  flake.nixosModules.security = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      nmap
      wireshark
      metasploit
      burpsuite
      john
      hashcat
      gobuster
      sqlmap
      ghidra-bin
      pwntools
    ];
    
    programs.wireshark.enable = true;
    
    security.rtkit.enable = true;
    # Add other security hardening or tools here
  };
}
