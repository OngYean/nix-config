{ config, lib, pkgs, inputs, ... }:

{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name = "MacTahoe-cursors";
    package = pkgs.callPackage ../../../pkgs/mactahoe-cursors {};
    size = 36;
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
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme.name = "MacTahoe-dark";
    iconTheme.package = pkgs.callPackage ../../../pkgs/mactahoe-icon-theme {};
    font = {
      name = "Inter";
      size = 10;
      package = pkgs.inter;
    };
    # gtk3.extraConfig = {
    #   gtk-application-prefer-dark-theme = true;
    # };
    # gtk4.extraConfig = {
    #   gtk-application-prefer-dark-theme = true;
    # };
  };

  # dconf.settings = {
  #   "org/gnome/desktop/interface" = {
  #     color-scheme = "prefer-dark"; # Essential for GTK4/Libadwaita apps to turn dark
  #     gtk-theme = "adw-gtk3-dark";
  #   };
  # };

  qt.kde.settings = {
    kdeglobals.Icons.Theme = "MacTahoe-dark";
  };
}
