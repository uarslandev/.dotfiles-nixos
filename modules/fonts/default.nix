{ config, pkgs, lib, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ 
      anthy 
      mozc 
    ];
  };

fonts.packages = with pkgs; [
  noto-fonts
  meslo-lg
  meslo-lgs-nf
  nerdfonts
  fira-code-nerdfont
  iosevka
  noto-fonts-cjk-sans
  noto-fonts-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  mplus-outline-fonts.githubRelease
  dina-font
  proggyfonts
];
}
