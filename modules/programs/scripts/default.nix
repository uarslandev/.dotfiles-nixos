{ config, pkgs, ... }:
let

in
{
	environment.systemPackages = [
		(import ./hello.nix { inherit pkgs; })
	];
}
