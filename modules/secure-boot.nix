{ lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  environment.systemPackages = with pkgs; [
    sbctl
  ];

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    autoGenerateKeys.enable = true;
    autoEnrollKeys.enable = true;
    pkiBundle = "/var/lib/sbctl";

    measuredBoot = {
      enable = true;
      pcrs = [
        0
        4
        7
      ];
    };
    configurationLimit = 8;
  };
}
