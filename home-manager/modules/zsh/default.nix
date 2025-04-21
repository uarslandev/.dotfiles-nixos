{ config, pkgs, ... }:

{
 programs.zsh = {
  enable = true;
  autosuggestion.enable = true;
  enableCompletion = true;
  autocd = true;
  sessionVariables = {
      AWT_TOOLKIT = "MToolkit";
	  _JAVA_AWT_WM_NONREPARENTING=1;
    };

  shellAliases = {
	backup = "pushd ~/.dotfiles; ga .; gcd; gp; popd";
	cal = "cal -mw";
	gd = "git diff";
	gs = "git status";
	lg = "looking-glass-client -F";
	n = "nvim";
	nix-search = "nix search nixpkgs";
	nix-update = "nix flake update";
	ns = "nix-shell";
	sp = "systemctl-suspend";
	startvm = "sudo virsh start win11";
	stopvm = "sudo virsh shutdown win11";
	t = "tmux";
    chrome = "google-chrome-stable";
    dfs = "cd ~/.dotfiles";
    ga = "git add";
    gb = "git branch -a";
    gc = "git commit -m";
    gcd = "git commit -m $(date +'%F_%T')";
    gco = "git checkout";
    gl = "git log --graph --pretty=oneline --abbrev-commit";
    gls = "git ls-files";
    glsu = "git ls-files | awk -F'/' '{print \$1}' | sort | uniq";
    glu = "git ls-files";
    gluf = "git ls-files --others --exclude-standard | awk -F'/' '{print \$1}' | sort | uniq";
    gp = "git push";
    gt = "git ls-tree";
    nixpkgs-help = "chrome /nix/store/arl0kk5jl0vjyvjj6sp4mhxjclj5d8ac-nixpkgs-manual/share/doc/nixpkgs/manual.html";
    rb = "backup && systemctl reboot -i";
    sd = "backup && systemctl poweroff -i";
    u = "update";
    update = "pushd ~/.dotfiles; sudo nixos-rebuild switch --flake .#$(hostname); popd";
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
    plugins = [ "git git-auto-fetch fzf"];
    theme = "robbyrussell";
  };
  initExtra = ''
	bindkey -s ^f "tmux-sessionizer\n"
  '';
};
}
