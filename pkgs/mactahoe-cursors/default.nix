# MacTahoe cursors
{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation rec {
  pname = "MacTahoe-cursors";
  version = "2026-09-10";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "MacTahoe-icon-theme";
    tag = version;
    hash = "sha256-NAahlBOYub0QlqkYStamoCbyWh+H5JG/iFm4Ws9EU3A=";
  };

  sourceRoot = "source/cursors";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons/MacTahoe-cursors $out/share/icons/MacTahoe-dark-cursors
    cp -r dist/* $out/share/icons/MacTahoe-cursors
    cp -r dist-dark/* $out/share/icons/MacTahoe-dark-cursors
    runHook postInstall
  '';

  meta = {
    description = "MacOS Tahoe like cursor theme for linux desktops";
    homepage = "https://github.com/vinceliuice/MacTahoe-icon-theme/tree/main/cursors";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
  };
}
