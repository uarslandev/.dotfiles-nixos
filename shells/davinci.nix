{ pkgs ? import <nixpkgs> {} }:

(pkgs.buildFHSEnv {
  name = "davinci-resolve-studio fhs env";
  targetPkgs = pkgs: (with pkgs; [
    davinci-resolve-studio
  ]) ++ (with pkgs.xorg; [
  ]);
  multiPkgs = pkgs: (with pkgs; [
  ]);
  runScript = "bash";
}).env

