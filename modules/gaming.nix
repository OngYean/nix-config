{ pkgs, ... }:

{
  boot.kernelModules = [ "ntsync" ];

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      dwproton-bin
    ];
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        renice = 10;
      };
       custom = {
        start = "${pkgs.libnotify}/bin/notify-send -i game -a 'FeralInteractive GameMode' -i applications-games 'Game Mode is ON'";
        end = "${pkgs.libnotify}/bin/notify-send -i game -a 'FeralInteractive GameMode' -i applications-games 'Game Mode is OFF'";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    umu-launcher
  ];
}
