{ pkgs, ... }:

{
  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    glib
    android-tools
    scrcpy
  ];
}
