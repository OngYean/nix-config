{ config, ... }:

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
}
