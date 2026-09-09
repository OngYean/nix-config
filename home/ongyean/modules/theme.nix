{ config, pkgs, ... }:

{
  # home.activation.installIconTheme = config.lib.dag.entryAfter ["writeBoundary"] ''
  #   export PATH="${lib.makeBinPath [ pkgs.bash pkgs.gtk3 pkgs.coreutils pkgs.gnused ]}:$PATH"
  #   REPO_DIR="$HOME/repos/MacTahoe-icon-theme"
  #   REMOTE_DIR="https://github.com/vinceliuice/MacTahoe-icon-theme.git"
  #   if [ ! -d "$REPO_DIR" ]; then
  #     $DRY_RUN_CMD ${pkgs.git}/bin/git clone $REMOTE_DIR "$REPO_DIR"
  #   else
  #     $DRY_RUN_CMD ${pkgs.git}/bin/git -C "$REPO_DIR" pull
  #   fi
  #   $DRY_RUN_CMD chmod +x "$REPO_DIR/install.sh"
  #   $DRY_RUN_CMD chmod +x "$REPO_DIR/cursors/install.sh"
  #   $DRY_RUN_CMD "$REPO_DIR/install.sh"
  #   $DRY_RUN_CMD "$REPO_DIR/cursors/install.sh"
  # '';

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
    #iconTheme.name = "MacTahoe-dark";
    iconTheme.name = "WhiteSur-dark";
    iconTheme.package = pkgs.whitesur-icon-theme;
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
