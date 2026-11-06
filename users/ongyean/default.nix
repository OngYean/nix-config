{ pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../../modules/desktops/kde-plasma.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."ongyean" = {
    isNormalUser = true;
    description = "Ong Yean";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "gamemode"
      "i2c"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  home-manager.users.ongyean = {
    imports = [
      # For each user, ONLY enable one config file from desktops dir
      # ../../home-modules/desktops/noctalia-hypr
      ../../home-modules/desktops/plasma-macshell

      ../../home-modules/shells/zsh.nix
      ../../home-modules/gaming.nix
      ../../home-modules/apps/internet.nix
      ../../home-modules/apps/multimedia.nix
      ../../home-modules/apps/neovim.nix
      ../../home-modules/apps/office.nix
      ../../home-modules/apps/zed-editor.nix
    ];
    home.username = "ongyean";
    home.homeDirectory = "/home/ongyean";

    # Again, NEVER CHANGE THIS
    home.stateVersion = "26.05";

    # Add Chinese and Japanese IME for this user
    i18n.inputMethod.fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      fcitx5-mozc-ut
    ];
  };
}
