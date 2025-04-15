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
    chrome = "google-chrome-stable";
    nixpkgs-help = "chrome /nix/store/arl0kk5jl0vjyvjj6sp4mhxjclj5d8ac-nixpkgs-manual/share/doc/nixpkgs/manual.html";
	cal = "cal -mw";
    dfs = "cd ~/.dotfiles";
    update = "pushd ~/.dotfiles; sudo nixos-rebuild switch --flake .#$(hostname); popd";
    u = "update";
	nix-search = "nix search nixpkgs";
	nix-update = "nix flake update";
	t = "tmux";
	sp = "systemctl-suspend";
	n = "nvim";
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
    glu = "git ls-files";
    gluf = "git ls-files --others --exclude-standard | awk -F'/' '{print \$1}' | sort | uniq";
    gls = "git ls-files";
    glsu = "git ls-files | awk -F'/' '{print \$1}' | sort | uniq";
	lg = "looking-glass-client -F";
	startvm = "sudo virsh start win11";
	stopvm = "sudo virsh shutdown win11";
	backup = "pushd ~/.dotfiles; ga .; gcd; gp; popd";
  };
  plugins = [
	{
		name = "powerlevel10k-config";
		src = ./p10k;
		file = "p10k.zsh";
	}	
  ];
 
  zplug = {
    enable = false;
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
