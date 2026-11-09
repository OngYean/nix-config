{ pkgs, ... }:

{
  home.packages = with pkgs; [
    video-trimmer
    vlc
    audacity
    (symlinkJoin {
      name = "kdePackages.koko-patched";
      paths = [ pkgs.kdePackages.koko ];
      postBuild = ''
        rm $out/share/applications/org.kde.koko.desktop
        substitute ${pkgs.kdePackages.koko}/share/applications/org.kde.koko.desktop \
          $out/share/applications/org.kde.koko.desktop \
          --replace-fail "Icon=org.kde.koko" "Icon=photos" \
      '';
    })
  ];

  programs.obs-studio.enable = true;

  # Set Koko as the default image viewer in MIME
  xdg.mimeApps.defaultApplications = {
    "image/*" = "org.kde.koko.desktop";
  };
}