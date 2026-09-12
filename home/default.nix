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

    sharedModules = [{
      # Global fix for Dolphin being unable to open Neovim
      qt.kde.settings = {
        kdeglobals.General.TerminalApplication = "alacritty";
        kdeglobals.General.TerminalService = "Alacritty.desktop";
      };
    }];
  };
}
