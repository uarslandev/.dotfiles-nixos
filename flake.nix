{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    user = "umut";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      pc = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./hosts/configuration.nix
          ./hosts/pc
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.${user} = import ./home-manager;

            home-manager.backupFileExtension = "backup";
          }
        ];
      };

      thinkpad = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./hosts/configuration.nix
          ./hosts/thinkpad
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.${user} = import ./home-manager;

            home-manager.backupFileExtension = "backup";
          }
        ];
      };

      work = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./hosts/configuration.nix
          ./hosts/work
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.${user} = import ./home-manager {
              inherit pkgs lib;
              config = {};
            };

            home-manager.backupFileExtension = "backup";
          }
        ];
      };
    };
  };
}
