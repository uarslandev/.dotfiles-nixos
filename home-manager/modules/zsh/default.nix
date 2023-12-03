{ config, pkgs, ... }:

{
 programs.zsh = {
  enable = true;
  enableAutosuggestions = true;
  enableCompletion = true;
  autocd = true;
  shellAliases = {
    ll = "ls -l";
    dfs = "cd ~/.dotfiles";
    update = "pushd ~/.dotfiles; sudo nixos-rebuild switch --flake .#$(hostname); popd";
    sd = "systemctl poweroff -i";
    rb = "systemctl reboot -i";
    ga = "git add";
    gc = "git commit -m";
    gcd = "git commit -m $(date +'%F_%T')";
    gp = "git push";
    gb = "git branch -a";
    gco = "git checkout";
    gt = "git ls-tree";
	gs = "git status";
    gl = "git log --graph --pretty=oneline --abbrev-commit";
	backup = "pushd ~/.dotfiles; ga .; gcd; gp; popd";
  };
  plugins = [
	{
		name = "powerlevel10k-config";
		src = ./p10k;
		file = "p10k.zsh";
	}	
	{
		name = "scale script";
		src = ./scripts;
		file = "scale";
	}
	{
		name = "lock script";
		src = ./scripts;
		file = "lock";
	}


  ];
 
  zplug = {
    enable = true;
    plugins = [
      { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
      { name = "zsh-users/zsh-syntax-highlighting"; } # Simple plugin installation
      { name = "zsh-users/zsh-completions"; } # Simple plugin installation
      { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
    ];
  };
   oh-my-zsh = {
    enable = true;
    plugins = [ "git" ];
  };
};
}
