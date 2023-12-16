{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "darknet-${version}";
  version = "1.0.0";
  src = fetchFromGitHub {
	url = "https://github.com/pjreddie/darknet.git";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp darknet $out/bin
  '';
}
