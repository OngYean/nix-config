# Custom icons
{ stdenvNoCC, gtk3, hicolor-icon-theme }:

stdenvNoCC.mkDerivation rec {
  pname = "custom-icons";
  version = "1.0";

  src = ./icons;

  nativeBuildInputs = [ gtk3 ];
  buildInputs = [ hicolor-icon-theme ];

  dontPatchELF = true;
  dontRewriteSymlinks = true;
  dontDropIconThemeCache = true;  # critical: prevents gtk3 hook from deleting the cache

  installPhase = ''
    mkdir -p $out/share/icons/hicolor/256x256/apps
    cp -r 256x256/apps/* $out/share/icons/hicolor/256x256/apps/
  '';

  postInstall = ''
    gtk-update-icon-cache -f -t $out/share/icons/hicolor
  '';
}
