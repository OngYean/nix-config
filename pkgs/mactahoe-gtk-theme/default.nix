# Derived from nixpkgs#pkgs.whitesur-gtk-theme maintained by José Romildo Malaquias (@romildo) <malaquias@gmail.com>
{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  nix-update-script,
  dialog,
  glib,
  jdupes,
  libxml2,
  sassc,
  util-linux,
  altVariants ? [ ], # default: normal
  colorVariants ? [ ], # default: all
  opacityVariants ? [ ], # default: all
  themeVariants ? [ ], # default: default (BigSur-like theme)
  schemeVariants ? [ ], # default: standard
  iconVariant ? null, # default: standard (Apple logo)
  panelOpacity ? null, # default: 15%
  panelSize ? null, # default: 32px
  blur ? false, # default: false
  libadwaita ? false, # default: false
  fixed ? false, # default: false
  highDefinition ? false, # default: false
  roundedMaxWindow ? false, # default: false
  darkerColor ? false, # default: false
  smallerFont ? false, # default: false
  noShadow ? false, # default: false
  normal ? false, # default: false
}:

let
  pname = "mactahoe-gtk-theme";
  single = x: lib.optional (x != null) x;

in
  lib.checkListOfEnum
  "${pname}: window control buttons variants"
  [ "normal" "alt" "all" ]
  altVariants

  lib.checkListOfEnum
  "${pname}: color variants"
  [ "light" "dark" ]
  colorVariants

  lib.checkListOfEnum
  "${pname}: opacity variants"
  [ "normal" "solid" ]
  opacityVariants

  lib.checkListOfEnum
  "${pname}: accent color variants"
  [
    "default"
    "blue"
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

  lib.checkListOfEnum
  "${pname}: colorscheme style variants"
  [ "standard" "nord" ]
  schemeVariants

  lib.checkListOfEnum
  "${pname}: activities icon variants"
  [
    "standard"
    "apple"
    "simple"
    "gnome"
    "ubuntu"
    "tux"
    "arch"
    "manjaro"
    "fedora"
    "debian"
    "void"
    "opensuse"
    "popos"
    "mxlinux"
    "zorin"
    "budgie"
    "gentoo"
  ]
  (single iconVariant) # No nixos :(

  lib.checkListOfEnum
  "${pname}: panel opacity"
  [ "default" "30" "45" "60" "75" ]
  (single panelOpacity)

  lib.checkListOfEnum
  "${pname}: panel size"
  [ "default" "smaller" "bigger" ]
  (single panelSize)

  stdenvNoCC.mkDerivation
  (finalAttrs: {
    inherit pname;
    version = "2026-09-10";

    src = fetchFromGitHub {
      owner = "vinceliuice";
      repo = "MacTahoe-gtk-theme";
      tag = finalAttrs.version;
      hash = "sha256-P4zevOTHd7KKLj3a9wkaY96tMFMg7iZEpz3NkbdyTwM=";
    };

    __structuredAttrs = true;
    strictDeps = true;

    nativeBuildInputs = [
      dialog
      glib
      jdupes
      libxml2
      sassc
      util-linux
    ];

    # The GTK2 themes need an engine that is no longer packaged.
    # As the source repo is based on vinceliuice/WhiteSur-gtk-theme, the same patch to remove GTK2 applies
    # https://github.com/vinceliuice/WhiteSur-gtk-theme/pull/1437
    patches = [ ./remove-gtk2.patch ];

    postPatch = ''
      find -name "*.sh" -print0 | while IFS= read -r -d ''' file; do
        patchShebangs "$file"
      done

      # Do not install gnome-theme-switcher app
      substituteInPlace install.sh --replace-fail "install_app" ""

      # Do not provide `sudo`, as it is not needed in our use case of the install script
      substituteInPlace libs/lib-core.sh --replace-fail '$(command -v sudo)' false

      # Changes ~/.config/gtk-4.0 to /tmp
      substituteInPlace libs/lib-install.sh --replace-fail "\''${HOME}/.config/gtk-4.0" "/tmp"

      # Provides a dummy home directory
      substituteInPlace libs/lib-core.sh --replace-fail 'MY_HOME=$(getent passwd "''${MY_USERNAME}" | cut -d: -f6)' 'MY_HOME=/tmp'
    '';

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/themes

      ./install.sh \
        ${toString (map (x: "--alt " + x) altVariants)} \
        ${toString (map (x: "--color " + x) colorVariants)} \
        ${toString (map (x: "--opacity " + x) opacityVariants)} \
        ${toString (map (x: "--theme " + x) themeVariants)} \
        ${toString (map (x: "--scheme " + x) schemeVariants)} \
        ${lib.optionalString blur "--blur"} \
        ${lib.optionalString libadwaita "--libadwaita"} \
        ${lib.optionalString fixed "--fixed"} \
        ${lib.optionalString highDefinition "--highdefinition"} \
        ${lib.optionalString roundedMaxWindow "--roundedmaxwindow"} \
        ${lib.optionalString darkerColor "--darkercolor"} \
        ${lib.optionalString (iconVariant != null) ("--gnome-shell -i " + iconVariant)} \
        ${lib.optionalString (panelSize != null) ("--gnome-shell -panelheight " + panelSize)} \
        ${lib.optionalString (panelOpacity != null) ("--gnome-shell -panelopacity " + panelOpacity)} \
        ${lib.optionalString smallerFont "--gnome-shell -smallerfont"} \
        ${lib.optionalString noShadow "--gnome-shell -noshadow"} \
        ${lib.optionalString normal "--gnome-shell -normal"} \
        --dest $out/share/themes

      jdupes --quiet --link-soft --recurse $out/share

      runHook postInstall
    '';

    passthru.updateScript = nix-update-script { };

    meta = {
      description = "MacOS Tahoe theme for gtk desktops";
      homepage = "https://github.com/vinceliuice/MacTahoe-gtk-theme";
      license = lib.licenses.mit;
      platforms = lib.platforms.all;
    };
  })
