{pkgs}:

pkgs.writeShellScriptBin "lock" ''
i3lock -C -i $HOME/.config/lock.png -c 000000 \
	  --pass-media-keys \
      --pass-screen-keys \
      --pass-volume-keys \
      --force-clock \
      --inside-color 00000000 --insidever-color 00000000 --insidewrong-color 00000000 \
      --date-str %F \
      --date-color ffffff \
      --time-color ffffff \
      --verif-text= --wrong-text= --noinput-text= \
      --redraw-thread
''
