# Curated apps (packages) for a functional system
{ pkgs, ... }:

{
  programs = {
    # Basic dev setup




    # KDE Partition Manager
    partition-manager.enable = true;
  };

  # Curated packages enforced for all users to ensure basic functionality
  environment.systemPackages = with pkgs; [
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
