let
  pkgs = import <nixpkgs> {};
  python = pkgs.python312;
  pythonPackages = python.pkgs;
  lib-path = with pkgs; lib.makeLibraryPath [
    libffi
    openssl
    stdenv.cc.cc
  ];
in with pkgs; mkShell {
  packages = [
    pythonPackages.pydantic
    pythonPackages.psycopg2
    pythonPackages.orjson
    pythonPackages.sqlalchemy
    pythonPackages.uvicorn
    pythonPackages.fastapi
    pythonPackages.venvShellHook
  ];

  buildInputs = [
    readline
    libffi
    openssl
    git
    openssh
    rsync
  ];

  shellHook = ''
    SOURCE_DATE_EPOCH=$(date +%s)
    export "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib-path}"
    VENV=.venv

    if test ! -d $VENV; then
      python3.12 -m venv $VENV
    fi
    source ./$VENV/bin/activate
    export PYTHONPATH=`pwd`/$VENV/${python.sitePackages}/:$PYTHONPATH
    pip install -r requirements.txt
  '';

  postShellHook = ''
    ln -sf ${python.sitePackages}/* ./.venv/lib/python3.12/site-packages
  '';
}
