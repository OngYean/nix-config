# Remember to enable services.desktopManager.plasma6
{ pkgs, inputs, ... }:

{
  imports = [
    inputs.macshell-kwin.homeManagerModules.macshell
  ];

  home.packages = with pkgs; [
    klassy
    darkly
    inputs.kwin-effects-glass.packages.${stdenv.hostPlatform.system}.default
  ];

  programs.macshell = {
    enable = true;
    autostart = true;
  };
}
