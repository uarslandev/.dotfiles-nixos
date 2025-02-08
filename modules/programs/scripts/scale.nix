{pkgs}:

pkgs.writeShellScriptBin "scale" ''
	if [ -z "$1" ]; then
		echo "set a dpi"
		return 1
	fi

	# Get the factor value
	factor=$1

	# Calculate dpi using bc for floating point precision
	dpi=$(echo "$factor * 97" | bc)

	# Check if .Xresources exists, and create if not
	if [ ! -f ~/.Xresources ]; then
		echo "Creating .Xresources"
		touch ~/.Xresources
	fi

	# Modify .Xresources to set the dpi value
	if grep -q '^Xft.dpi:' ~/.Xresources; then
		sed -i "s/^Xft.dpi:.*/Xft.dpi: $dpi/" ~/.Xresources
	else
		echo "Xft.dpi: $dpi" >> ~/.Xresources
	fi

	# Apply the changes
	xrdb $HOME/.Xresources

	echo "xft.dpi set to $dpi"
''
