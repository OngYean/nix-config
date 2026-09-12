# Derived from nixpkgs#pkgs.whitesur-icon-theme maintained by Icy-Thought (@Icy-Thought) <gilganyx@pm.me>
{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gtk3,
  hicolor-icon-theme,
  jdupes,
  boldPanelIcons ? false,
  alternativeIcons ? false,
  themeVariants ? [ ],
}:

let
  pname = "MacTahoe-icon-theme";
in
lib.checkListOfEnum "${pname}: theme variants"
  [
    "default"
    "purple"
    "pink"
    "red"
    "orange"
    "yellow"
    "green"
    "grey"
    "all"
  ]
  themeVariants

  stdenvNoCC.mkDerivation
  rec {
    inherit pname;
    version = "2026-09-10";

    src = fetchFromGitHub {
      owner = "vinceliuice";
      repo = "MacTahoe-icon-theme";
      tag = version;
      hash = "sha256-5MN1iza+xPcW18DSbaxVNPdbvY9JwB/Ravk1HnK8Djw=";
    };

    nativeBuildInputs = [
      gtk3
      jdupes
    ];

    buildInputs = [ hicolor-icon-theme ];

    # These fixup steps are slow and unnecessary
    dontPatchELF = true;
    dontRewriteSymlinks = true;
    dontDropIconThemeCache = true;

    postPatch = ''
      patchShebangs install.sh
    '';

    installPhase = ''
      runHook preInstall

      ./install.sh --dest $out/share/icons \
        --name MacTahoe \
        --theme ${toString themeVariants} \
        ${lib.optionalString alternativeIcons "--alternative"} \
        ${lib.optionalString boldPanelIcons "--bold"} \

      jdupes --link-soft --recurse $out/share

      runHook postInstall
    '';

    # Drop dangling symlinks from the upstream icon set.
    postFixup = ''
      find $out/share/icons -xtype l -delete
    '';

    meta = {
      description = "MacOS Tahoe icon theme for Linux";
      homepage = "https://github.com/vinceliuice/MacTahoe-icon-theme";
      license = lib.licenses.gpl3Plus;
      platforms = lib.platforms.linux;
      maintainers = with lib.maintainers; [ icy-thought ];
    };

  }
