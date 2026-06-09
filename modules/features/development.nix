{
  flake.nixosModules.development = { pkgs, ... }: {
    imports = [
      # This allows you to just import 'development' 
      # and get everything else you define in that folder
      # once you move them to separate files.
      # inputs.self.nixosModules.git 
      # inputs.self.nixosModules.python
    ];

    environment.systemPackages = with pkgs; [
      vscode
      jetbrains.pycharm-oss
      gcc
      gnumake
      python3
      nodejs
      go
    ];
  };
}