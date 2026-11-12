{ lib, pkgs, options, ... }:

{
  imports = [
    ../kde-file-management.nix
  ];

  config = {
    services.desktopManager.plasma6.enable = true;

    # Debloat
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      aurorae
      plasma-browser-integration
      plasma-workspace-wallpapers
      elisa
      gwenview
      kate
      ktexteditor
      khelpcenter
      plasma-keyboard
      qtvirtualkeyboard
      union
    ];
    programs.kde-pim.enable = false;
    services.orca.enable = false;
  } // lib.optionalAttrs (options ? chaotic) {
    # Only when chaotic's NixOS module is imported. Must stay inside `config`:
    # a top-level condition on `options` causes infinite recursion while imports are collected.
    chaotic.appmenu-gtk3-module.enable = true;
  };
}
