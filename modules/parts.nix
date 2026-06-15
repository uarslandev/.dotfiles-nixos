{ inputs, ... }:
{
  systems = [
    "x86_64-linux"
    "x86_64-darwin"
    "aarch64-linux"
    "aarch64-darwin"
  ];

  perSystem =
    {
      system,
      pkgs,
      self',
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      packages.default = pkgs.symlinkJoin {
        name = "dotfiles-developer-tools";
        paths = [
          self'.packages.zsh
          self'.packages.neovim
          self'.packages.git
          self'.packages.tmux
          self'.packages.tmux-sessionizer
          self'.packages.tmux-ssh-sessionizer
          pkgs.gemini-cli
          pkgs.antigravity-cli
          pkgs.claude-code
          pkgs.fzf
          pkgs.ripgrep
          pkgs.fd
        ];
      };
    };
}
