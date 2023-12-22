{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "Jdownloder${version}";
  version = "2.0";
  src = fetchurl {
    url = "https://mega.nz/file/bZtTnSDL#nVnOHuT8LMvvB9EuXp1nrEvjKjzQ6lSRShKkyGNRYPo";
    sha256 = "16c44729294dc54ffba74176356264bd2bd8f1c8b1a0924c13395c3358857a67";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/jdownloader-installer.sh
    chmod +x $out/bin/jdownloader-installer.sh
	cd $out/bin
	sh ./jdownloader-installer.sh
  '';

    meta = with lib; {
    description = "JDownloader 2";
    homepage = "https://jdownloader.org/";
    license = licenses.gpl3;
  };

}
