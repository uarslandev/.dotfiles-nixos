{ pkgs }:

pkgs.writeShellScriptBin "convertVideos" ''
    originalDir="./original"
    if [ ! -d "$originalDir" ]; then
        echo "creating original directory"
        mkdir $originalDir
    fi

    for video in *.mp4; do
        noExt="''${video%.mp4}"
        ffmpeg -i "$video" -acodec pcm_s16le -vcodec copy "$noExt.mov"
        mv "$video" "$originalDir"
    done

    echo $noExt
''
