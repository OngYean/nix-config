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

  # KDE Plasma already launches fcitx5 via XDG autostart
  i18n.inputMethod.fcitx5.systemd.enable = false;
}
