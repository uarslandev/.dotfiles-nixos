{pkgs}:

pkgs.writeShellScriptBin "evdev" ''
input_devices=$(ls /dev/input/by-id/*event* | grep -v if)

for device in $input_devices
do
if [[ $device == *"kbd"* && $device == *"Keyboard"* ]]; then
        echo "<input type='evdev'>
  <source dev='$device' grab='all' repeat='on' grabToggle='ctrl-ctrl'/>
</input>"
    else
        echo "<input type='evdev'>
  <source dev='$device'/>
</input>"
    fi
done | xclip -sel c
''
