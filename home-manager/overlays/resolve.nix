{ pkgs}:

pkgs.davinci-resolve-studio.overrideAttrs (oldAttrs: rec {
  installPhase = ''
    mkdir -p $out/bin
    cp /home/umut/resolve $out/bin/resolve
  '';
})

