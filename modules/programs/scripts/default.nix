{ config, pkgs, ... }:
let

in
{
	environment.systemPackages = [
		(import ./scale.nix { inherit pkgs; })
		(import ./lock.nix { inherit pkgs; })
	];
}
