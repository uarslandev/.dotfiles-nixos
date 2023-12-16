{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "darknet-${version}";
  version = "1.0.0";
  src = fetchFromGitHub {
    owner = "pjreddie";
    repo = "darknet";
    rev = "f6afaabcdf85f77e7aff2ec55c020c0e297c77f9";
    sha256 = "sha256-Bhvbc06IeA4oNz93WiPmz9TXwxz7LQ6L8HPr8UEvzvE=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp darknet $out/bin
  '';
}
