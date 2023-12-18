{pkgs}:

pkgs.writeShellScriptBin "cow" ''
	echo "hello world" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
''
