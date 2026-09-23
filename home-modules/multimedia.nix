{ pkgs, ... }:

{
  home.packages = with pkgs; [
    video-trimmer
    kdePackages.koko
    vlc
    audacity
  ];

  programs.obs-studio.enable = true;
}