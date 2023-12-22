{ stdenv, fetchurl, lib, ...}:

stdenv.mkDerivation rec {
  name = "jdownloder${version}";
  version = "2.0";
  src = fetchurl {
    url = "https://mega.nz/file/bZtTnSDL#nVnOHuT8LMvvB9EuXp1nrEvjKjzQ6lSRShKkyGNRYPo";
    sha256 = "sha256-nmNGcUVOAZLgc/od4z5ZYkZ2pcjL3JmNVepPplo/IaY=";
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
