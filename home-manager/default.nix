{ config, pkgs, ... }:
let
	home = "/home/umut/.dotfiles/configs";
	link = config.lib.file.mkOutOfStoreSymlink;
in
{

  imports = [
    ./modules
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "umut";
  home.homeDirectory = "/home/umut";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.packages = 
	let
	    darknet = pkgs.callPackage derivations/darknet.nix {};
	in with pkgs; [
		darknet
	];
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
#  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
	".config/bg.jpg".source = link "${home}"+"/bg.jpg";
	".config/lock.png".source = link "${home}"+"/lock.png";
	".config/dunst".source = link "${home}"+"/dunst";
	".config/fcitx5".source = link "${home}"+"/fcitx5";
	".config/GIMP".source = link "${home}"+"/GIMP";
	".config/keepassxc".source = link "${home}"+"/keepassxc";
	".config/rofi".source = link "${home}"+"/rofi";
	".config/i3".source = link "${home}"+"/i3";
	".config/i3status".source = link "${home}"+"/i3status";
	".config/kitty".source = link "${home}"+"/kitty";
	".config/xmonad".source = link "${home}"+"/xmonad";
	".config/tmux".source = link "${home}"+"/tmux";
	".config/picom".source = link "${home}"+"/picom";
	".config/alacritty".source = link "${home}"+"/alacritty";
	".xmobarrc".source = link "${home}"+"/.xmobarrc";
	"mimeapps.list".source = link "${home}"+"/mimeapps.list";

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/umut/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  gtk = {
	  enable = true;
	  cursorTheme = {
		  package = pkgs.bibata-cursors;
		  name = "Bibata-Modern-Ice";
	  };
	  theme = {
		  name = "SolArc-Dark";
		  package = pkgs.solarc-gtk-theme;
	  };
  };
  qt = {
	  enable = true;
	  platformTheme.name = "gtk";
	  style = {
		  name = "adwaita-dark";
	  };
  };

# Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
