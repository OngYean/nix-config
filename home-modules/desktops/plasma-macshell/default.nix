# Remember to enable services.desktopManager.plasma6
{ pkgs, inputs, ... }:

{
  imports = [
    ./theme.nix
    inputs.macshell-kwin.homeManagerModules.macshell
  ];

  programs.macshell = {
    enable = true;
    autostart = true;
  };
}
