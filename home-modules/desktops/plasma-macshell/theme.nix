{ config, lib, pkgs, inputs, ... }:

let
  mactahoeGtkTheme = pkgs.callPackage ../../../pkgs/mactahoe-gtk-theme {
    libadwaita = true;
    roundedMaxWindow = true;
    darkerColor = true;
  };
in
{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name = "MacTahoe-cursors";
    package = pkgs.callPackage ../../../pkgs/mactahoe-cursors {};
    size = 32;
    # TODO: Add kcminputrc config
  };

  home.packages = with pkgs; [
    klassy
    darkly
    inputs.kwin-effects-glass.packages.${stdenv.hostPlatform.system}.default
    (callPackage ../../../pkgs/custom-icons {})
  ];

  gtk = {
    enable = true;
    gtk2.enable = false;

    theme = {
      name = "MacTahoe-Dark";
      package = mactahoeGtkTheme;
    };

    # GTK4 requires explicit declaration
    gtk4.theme = {
      name = "MacTahoe-Dark";
      package = mactahoeGtkTheme;
    };

    iconTheme.name = "MacTahoe-dark";
    iconTheme.package = pkgs.callPackage ../../../pkgs/mactahoe-icon-theme {};

    font = {
      name = "Inter";
      size = 10;
      package = pkgs.inter;
    };
  };

  qt.kde.settings = {
    kdeglobals.Icons.Theme = "MacTahoe-dark";
  };
}
