{ inputs, ... }: {

    flake.nixosModules.core = {pkgs, ...}: {
        programs = {
            firefox.enable = true;            
        };
        environment.systemPackages = with pkgs; [
            discord
            vim
            networkmanagerapplet
        ];
    };
}