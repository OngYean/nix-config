# Curated apps (packages) for a functional system
{ pkgs, ... }:

{
  programs = {
    # Desktop experience must-haves - Hyprland WM
    hyprland.enable = true;
    hyprland.withUWSM = true;

    # Basic dev setup
    zsh.enable = true;
    git = {
      enable = true;
      config = {
        init = {
          defaultBranch = "main";
        };
        url = {
          "https://github.com/" = {
            insteadOf = [
              "gh:"
              "github:"
            ];
          };
        };
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      configure = {
      };
    };

    # KDE Partition Manager
    partition-manager.enable = true;

    # KDE Connect
    kdeconnect.enable = true;

    # An app to manage GNOME keyring credentials
    seahorse.enable = true;
  };

  # Curated packages enforced for all users to ensure basic functionality
  environment.systemPackages = with pkgs; [
    wget
    alacritty
    fastfetch

    # System utilities
    kdePackages.filelight
    restic

    # File manager
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.ark

    # Document and media viewers
    libreoffice
    kdePackages.okular
    kdePackages.koko
    vlc

    # Web browser
    brave-origin

    # System monitoring tools
    btop
    resources
  ];
}
