{ pkgs ? import <nixpkgs> {} }:

let
  python = pkgs.python312;
  requirements = pkgs.writeText "requiremenets.txt"''
    numpy
  ''
  ;
in

  pkgs.mkShell{
    buildInputs = [
      python
      python.pkgs.virtualenv
      python.pkgs.pip
    ];

    shellHook = ''
      touch testfile
    '';
  }
