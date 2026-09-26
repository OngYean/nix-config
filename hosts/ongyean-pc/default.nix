# Host: ongyean-pc
# The LUKS2 container should be named "nixos"
# and the boot partition should be labelled "boot"
{ lib, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/common
    ../../modules/apps.nix
    ../../modules/gaming.nix
    ../../modules/hyprland.nix
    ../../modules/phone-connect.nix
    ../../modules/secure-boot.nix
    ../../modules/services.nix
    ../../modules/tweaks.nix
    ../../modules/hardware/nvidia.nix
    ../../users/ongyean
    ./hardware-configuration.nix
    inputs.chaotic.nixosModules.default
  ];

  networking.hostName = "ongyean-pc";

  # Absolutely proprietary
  nixpkgs.config.allowUnfree = true;

  services.displayManager.noctalia-greeter.enable = true;

  # Automatically switch USB Wi-Fi adapter to network mode from CD-ROM mode
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{idProduct}=="1a2b", RUN+="${pkgs.usb-modeswitch}/bin/usb_modeswitch -K -v 0bda -p 1a2b"
  '';

  # No need to save power on a desktop's Wi-Fi
  networking.networkmanager.wifi.powersave = lib.mkForce false;

  # Unlock the LUKS2 container first so that the partitions can mount
  boot.initrd.luks.devices."nixos" = {
    device = "/dev/disk/by-label/nixos";
    preLVM = true;
  };

  # Force the boot partition to be found via its label
  fileSystems."/boot".device = lib.mkForce "/dev/disk/by-label/boot";

  services.scx.scheduler = "scx_lavd";
  services.lact.enable = true;

  environment.systemPackages = with pkgs; [
    # Enable monitor brightness control
    ddcutil
  ];
}
