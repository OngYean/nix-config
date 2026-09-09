{ config, lib, ... }:

# Some config and share files are symlinked at build time instead
let
  dotfilesConfig = ../dotfiles/.config;
  dotfilesData = ../dotfiles/.local/share;
  mkLinks = dir:
    let
      walk = base: prefix:
        lib.foldl' (acc: name:
          let
            path = base + "/${name}";
            rel  = if prefix == "" then name else "${prefix}/${name}";
            type = (builtins.readDir base).${name};
          in
          if type == "directory"
          then acc // walk path rel
          else acc // { ${rel}.source = path; }
        ) {} (builtins.attrNames (builtins.readDir base));
    in
    walk dir "";
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
  xdg.dataFile   = mkLinks dotfilesData;
}
