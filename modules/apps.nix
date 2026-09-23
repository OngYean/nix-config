# Curated apps (packages) for a functional system
{ pkgs, ... }:

{
  programs = {
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
  };

  # Curated packages enforced for all users to ensure basic functionality
  environment.systemPackages = with pkgs; [
    alacritty
    fastfetch

    # System utilities
    kdePackages.filelight
    restic

    # File manager
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.ark

    # Web browser
    brave-origin

    # System monitoring tools
    btop
    resources
  ];
}
