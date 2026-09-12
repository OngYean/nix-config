{ config, pkgs, ... }:

{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name = "WhiteSur-cursors";
    package = pkgs.whitesur-cursors;
    size = 32;
  };

  home.packages = with pkgs; [
    qtengine
    darkly
    callPackage ../../../pkgs/custom-icons {}
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
}
