{pkgs}:

pkgs.writeShellScriptBin "convertVideos" ''
  originalDir="./original"

  if [ ! -d "$originalDir" ]; then
      echo "Creating original directory"
      mkdir "$originalDir"
  fi

  for video in *.mp4; do
      noExt="''${video%.mp4}"
      echo "Converting $video to $noExt.mov"
      ffmpeg -i "$video" -acodec pcm_s16le -vcodec copy "$noExt.mov"
      mv "$video" "$originalDir/"
  done

  for video in *.mov; do
      noExt="''${video%.mov}"
      if [ ! -f "$noExt.mov" ]; then
          echo "Converting $video to $noExt.mov"
          ffmpeg -i "$video" -acodec pcm_s16le -vcodec copy "$noExt.mov"
      fi
      mv "$video" "$originalDir/"
  done

  echo "Done converting videos."

''
