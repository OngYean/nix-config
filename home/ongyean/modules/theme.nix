{ config, lib, pkgs, ... }:

{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
    name = "MacTahoe-dark-cursors";
    package = pkgs.callPackage ../../../pkgs/mactahoe-cursors {};
    size = 48;
  };

  home.packages = with pkgs; [
    qtengine
    darkly
    (callPackage ../../../pkgs/custom-icons {})
  ];

  # Injects qtengine as Qt theme
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qtengine";
  };

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
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark"; # Essential for GTK4/Libadwaita apps to turn dark
      gtk-theme = "adw-gtk3-dark";
    };
  };

  qt.kde.settings = {
    kdeglobals.Icons.Theme = "MacTahoe-dark";
  };

  home.activation.iconThemeSymlink = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ln -sf ${pkgs.callPackage ../../../pkgs/mactahoe-icon-theme {}}/share/icons/MacTahoe* ${config.home.homeDirectory}/.local/share/icons/
  '';
}
