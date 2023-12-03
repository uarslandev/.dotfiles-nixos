{pkgs ? import <nixpkgs> {}}:

(pkgs.buildFHSEnv {
  name = "base-fhs";
  runScript = "bash";
  targetPkgs = pkgs': with pkgs'; [ cmatrix ];
}).env
