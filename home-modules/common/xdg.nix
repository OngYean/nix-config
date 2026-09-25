{ config, lib, ... }:

# Some config and share files are symlinked at build time instead
let
  dotfilesConfig = ../../users/${config.home.username}/dotfiles/.config;
  dotfilesData = ../../users/${config.home.username}/dotfiles/.local/share;
  mkLinks = (import ../../utils.nix lib).mkLinks;
in
{
  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    pictures = "${config.home.homeDirectory}/Pictures";
    videos = "${config.home.homeDirectory}/Videos";
    music = "${config.home.homeDirectory}/Music";
    projects = "${config.home.homeDirectory}/Projects";
    templates = "${config.home.homeDirectory}/Templates";
    publicShare = "${config.home.homeDirectory}/Public";
    desktop = "${config.home.homeDirectory}/Desktop";

    # Optional: Custom directories
    extraConfig = {
      GAMES = "${config.home.homeDirectory}/Games";
    };
  };

  # Link dotfiles to the real locations
  xdg.configFile = mkLinks dotfilesConfig;
  xdg.dataFile = mkLinks dotfilesData;
}
