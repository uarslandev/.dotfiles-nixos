{
  flake.nixosModules.security-ctf = { pkgs, ... }: {
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
  };
}