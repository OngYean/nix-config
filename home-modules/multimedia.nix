{ pkgs, ... }:

{
  home.packages = with pkgs; [
    video-trimmer
    kdePackages.koko
    vlc
    # audacity
  ];

  programs.obs-studio.enable = true;

  # Set Koko as the default image viewer in MIME
  xdg.mimeApps.defaultApplications = {
    "image/*" = "org.kde.koko.desktop";
  };
}