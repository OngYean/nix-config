{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    startAsUserService = true;

    sharedModules = [
      # TODO: Add files within this folder
      {
      # Global fix for Dolphin being unable to open Neovim
      qt.kde.settings = {
        kdeglobals.General.TerminalApplication = "alacritty";
        kdeglobals.General.TerminalService = "Alacritty.desktop";
      };
    }];
  };
}