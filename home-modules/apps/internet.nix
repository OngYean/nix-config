{ pkgs, ... }:

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
}
