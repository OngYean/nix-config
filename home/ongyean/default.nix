{ pkgs, inputs, ... }:

{
  imports = [
    ../../home-modules/common
    inputs.home-manager.nixosModules.home-manager
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."ongyean" = {
    isNormalUser = true;
    description = "Ong Yean";
    extraGroups = [ "wheel" "networkmanager" "audio" "gamemode" ];
    shell = pkgs.zsh;
  };

  home-manager.users.ongyean = {
    imports = [
      ./modules
    ];
    home.username = "ongyean";
    home.homeDirectory = "/home/ongyean";

    # Again, NEVER CHANGE THIS
    home.stateVersion = "26.05";

    # TODO: Install telegram

    # Add Chinese and Japanese IME for this user
    i18n.inputMethod.fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      fcitx5-mozc
    ];
  };
}
