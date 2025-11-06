{ pkgs ? import (fetchTarball "https://channels.nixos.org/nixos-24.05/nixexprs.tar.xz") {} }:
let
  fhs = pkgs.buildFHSUserEnv {
    name = "example-project-environment";

    targetPkgs = _: [
      pkgs.micromamba
    ];

    runScript = "zsh";

    profile = ''
      set -e
      #export MAMBA_ROOT_PREFIX=${builtins.getEnv "PWD"}/.mamba
      export MAMBA_ROOT_PREFIX=${builtins.getEnv "HOME"}/.mamba
      eval "$(micromamba shell hook --shell=zsh | sed 's/complete / # complete/g')"
      #micromamba create --yes -q -n my-mamba-environment
      #micromamba activate my-mamba-environment
      #micromamba install --yes -f conda-requirements.txt -c conda-forge
      set +e
    '';


  };
in fhs.env
