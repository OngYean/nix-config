{ pkgs, ... }:

{
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      inter
      jetbrains-mono
    ];
  };
}
