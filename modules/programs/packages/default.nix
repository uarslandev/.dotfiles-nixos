{ config, pkgs, ... }:

let
  oldPkgs = import (builtins.fetchTarball {
    url = "https://channels.nixos.org/nixos-24.05/nixexprs.tar.xz";
    sha256 = "1f8j7fh0nl4qmqlxn6lis8zf7dnckm6jri4rwmj0qm1qivhr58lv";
  }) { 
    system = "x86_64-linux";  # Explicitly set your system architecture
  };
in
{
  environment.systemPackages = with pkgs; [
    xclip
    distrobox
    keepassxc
    copyq
    imagemagick
    rclone
    scrot
  ] ++ (with oldPkgs; [ grive2 ]);
}

