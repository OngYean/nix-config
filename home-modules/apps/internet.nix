{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    brave-origin
    spotifast
    zapfast
    telegram-desktop
  ];

  # Set Brave Origin as the default web browser
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "brave-origin.desktop";
    "x-scheme-handler/https" = "brave-origin.desktop";
    "x-scheme-handler/about" = "brave-origin.desktop";
    "x-scheme-handler/unknown" = "brave-origin.desktop";

    "text/html" = "brave-origin.desktop";
    "application/xhtml+xml" = "brave-origin.desktop";
  };

  # Pull Noto Sans CJK and expose only the heavier weights to Spotifast and ZapFast
  home.activation.fastAppsCJKFont = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/.local/share/fonts
    $DRY_RUN_CMD ln -sf ${pkgs.noto-fonts-cjk-sans-static}/share/fonts/opentype/noto-cjk/NotoSansCJK-Bold.ttc ${config.home.homeDirectory}/.local/share/fonts/
  '';
}
