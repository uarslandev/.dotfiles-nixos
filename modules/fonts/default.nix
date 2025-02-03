{ config, pkgs, lib, ... }:

{
 i18n.inputMethod = {
   type = "fcitx5";
   enable = true;
   fcitx5.waylandFrontend = true;
   fcitx5.addons = with pkgs; [
     fcitx5-mozc
     fcitx5-gtk
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
