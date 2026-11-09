{ pkgs, ... }:

{
  imports = [
    ../kde-file-management.nix
  ];

  services.desktopManager.plasma6.enable = true;

  # Debloat
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    aurorae
    plasma-browser-integration
    plasma-workspace-wallpapers
    elisa
    gwenview
    kate
    ktexteditor
    khelpcenter
    plasma-keyboard
    qtvirtualkeyboard
    union
  ];
  programs.kde-pim.enable = false;
  services.orca.enable = false;

  chaotic.appmenu-gtk3-module.enable = true;
}
