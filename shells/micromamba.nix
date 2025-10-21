{ pkgs ? import (fetchTarball "https://channels.nixos.org/nixos-24.05/nixexprs.tar.xz") {} }:
let
  fhs = pkgs.buildFHSUserEnv {
    name = "mamba-fhs-env";
    targetPkgs = _: [ pkgs.micromamba pkgs.zsh ];
    runScript = "zsh";
    profile = ''
      set -e
      eval "$(micromamba shell hook --shell posix)"
      export MAMBA_ROOT_PREFIX=${builtins.getEnv "PWD"}/.mamba
      if ! test -d $MAMBA_ROOT_PREFIX/envs/my-mamba-environment; then
          micromamba create --yes -q -n my-mamba-environment
      fi
      set +e
      alias conda=micromamba
    '';
  };
in
fhs.env

