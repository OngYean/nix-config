# Remember to enable services.desktopManager.plasma6
{ lib, pkgs, inputs, ... }@args:

# Some config and share files are symlinked at build time instead
let
  dotfilesConfig = ./dotfiles/.config;
  # dotfilesData = ./dotfiles/.local/share;
  mkLinks = (import ../../../utils.nix args).mkLinks;
in
{
  imports = [
    ./rc.nix
    ./theme.nix
    inputs.macshell-kwin.homeManagerModules.macshell
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  programs.macshell = {
    enable = true;
    autostart = true;
    lockScreen = true;
  };

  # KDE Plasma already launches fcitx5 via XDG autostart
  i18n.inputMethod.fcitx5.systemd.enable = false;

  # Link dotfiles to the real locations
  xdg.configFile = mkLinks dotfilesConfig;
  # xdg.dataFile = mkLinks dotfilesData;
}
