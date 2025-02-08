{ config, pkgs, ... }:
let

in
{
	environment.systemPackages = [
		(import ./scale.nix { inherit pkgs; })
		(import ./lock.nix { inherit pkgs; })
		(import ./evdev.nix { inherit pkgs; })
		(import ./tmux-sessionizer.nix { inherit pkgs; })
		(import ./convert.nix { inherit pkgs; })
	];
}
