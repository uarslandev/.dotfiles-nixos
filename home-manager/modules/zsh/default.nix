{ config, pkgs, ... }:

{
 programs.zsh = {
  enable = true;
  enableAutosuggestions = true;
  enableCompletion = true;
  autocd = true;
  shellAliases = {
    ll = "ls -l";
	cal = "cal -mw";
    dfs = "cd ~/.dotfiles";
    update = "pushd ~/.dotfiles; sudo nixos-rebuild switch --flake .#$(hostname); popd";
	nix-search = "nix search nixpkgs";
    sd = "backup && systemctl poweroff -i";
    rb = "backup && systemctl reboot -i";
    ga = "git add";
    gc = "git commit -m";
    gcd = "git commit -m $(date +'%F_%T')";
    gp = "git push";
    gb = "git branch -a";
    gco = "git checkout";
    gt = "git ls-tree";
	gs = "git status";
    gl = "git log --graph --pretty=oneline --abbrev-commit";
	lg = "looking-glass-client -F";
	g = "grep -i";
	i = "iname";
	wlc = "wl-copy";
	startvm = "sudo virsh start win11";
	stopvm = "sudo virsh shutdown win11";
	backup = "pushd ~/.dotfiles; ga .; gcd; gp; popd";
	dconf-save = "pushd ~/.dotfiles/home-manager/; dconf dump / | dconf2nix > dconf.nix; popd";
  };
  plugins = [
	{
		name = "powerlevel10k-config";
		src = ./p10k;
		file = "p10k.zsh";
	}	
  ];
 
  zplug = {
    enable = true;
    plugins = [
      { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
      { name = "zsh-users/zsh-history-substring-search"; } # Simple plugin installation
      { name = "zsh-users/zsh-syntax-highlighting"; } # Simple plugin installation
      { name = "zsh-users/zsh-completions"; } # Simple plugin installation
      { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
    ];
  };
   oh-my-zsh = {
    enable = true;
    plugins = [ "git"];
  };
};
}
