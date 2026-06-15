{ self, inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.gh = pkgs.symlinkJoin {
        name = "gh";
        paths = [ pkgs.gh ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/gh --unset DBUS_SESSION_BUS_ADDRESS
        '';
      };
    };

  flake.nixosModules.cli =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.gh
      ] ++ (with pkgs; [
        ripgrep
        fd
        file
        fzf
        eza
        bat
        jq
        yq
        unzip
        zip
        wget
        curl
        tree
        btop
        fastfetch
        rsync
        just
        lazygit
      ]);

      environment.variables.EDITOR = "nvim";

      programs.bash.interactiveShellInit = ''
        bind '"\e[1;5C": forward-word'
        bind '"\e[1;5D": backward-word'
        bind '"\e[1;3C": forward-word'
        bind '"\e[1;3D": backward-word'
        bind '"\e[3;5~": kill-word'
        bind '"\e[3;3~": kill-word'
        bind '"\e[H": beginning-of-line'
        bind '"\e[F": end-of-line'
        bind '"\C-h": backward-kill-word'
        bind '"\e\x7f": backward-kill-word'
      '';
    };
}
