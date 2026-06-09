{ self, inputs, ... }: {
  flake.nixosModules.python = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      micromamba # Fast Anaconda alternative
      (python3.withPackages (ps: with ps; [
        pandas
        numpy
        matplotlib
        scikit-learn
        torch
        tensorflow
        keras
        jupyter
      ]))
    ];
  };
}