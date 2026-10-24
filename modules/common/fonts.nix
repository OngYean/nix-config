{ pkgs, ... }:

{
  fonts = {
    fontconfig.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      corefonts # Microsoft's core fonts
    ];
  };
}
