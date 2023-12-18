{ config, pkgs, ... }:
let

in
{
	environment.systemPackages = [
		(import ./hello.nix { inherit pkgs; })
		(import ./lock.nix { inherit pkgs; })
	];
}
