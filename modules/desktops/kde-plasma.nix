{ pkgs, ... }:

{
  imports = [
    ../kde-file-management.nix
  ];
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    plasma-workspace-wallpapers
  ];
}
