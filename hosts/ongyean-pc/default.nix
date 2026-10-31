# Host: ongyean-pc
# The LUKS2 container should be named "nixos"
# and the boot partition should be labelled "boot"
{ lib, pkgs, inputs, ... }:

let
  nfsMountOptions = [
    "noatime"
    "nofail"
    "noauto"
    "x-systemd.automount"
    "x-systemd.idle-timeout=600"
    "x-systemd.mount-timeout=10"
    "nfsvers=4.2"
    "_netdev"
  ];

  mountFromNFS = path: {
    device = "10.42.0.1:${path}";
    fsType = "nfs";
    options = nfsMountOptions;
  };
in
{
  imports = [
    ../../modules/common
    ../../modules/ddcutil.nix
    ../../modules/gaming.nix
    ../../modules/hyprland.nix
    ../../modules/kde-file-management.nix
    ../../modules/phone-connect.nix
    ../../modules/secure-boot.nix
    ../../modules/services.nix
    ../../modules/tweaks.nix
    ../../modules/display-manager/noctalia-greeter.nix
    ../../modules/hardware/nvidia.nix
    ../../users/ongyean
    ./hardware-configuration.nix
    inputs.chaotic.nixosModules.default
  ];

  networking.hostName = "ongyean-pc";

  # Absolutely proprietary
  nixpkgs.config.allowUnfree = true;

  # Automatically switch USB Wi-Fi adapter to network mode from CD-ROM mode
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{idProduct}=="1a2b", RUN+="${pkgs.usb-modeswitch}/bin/usb_modeswitch -K -v 0bda -p 1a2b"
  '';

  # No need to save power on a desktop's Wi-Fi
  networking.networkmanager.wifi.powersave = lib.mkForce false;

  # Force 5GHz network due to 2.4GHz unreliability
  networking.wireless.iwd.settings = {
    Rank.BandModifier5GHz = 65535;
    Rank.BandModifier2_4GHz = 0.0;
  };

  # Unlock the LUKS2 container first so that the partitions can mount
  boot.initrd.luks.devices."nixos".device = "/dev/disk/by-label/nixos";

  # Force the boot partition to be found via its label
  # and mount NFS media directories
  # as well as Games directory from external SSD, if plugged in
  fileSystems = (lib.genAttrs [
    "/home/ongyean/Documents"
    "/home/ongyean/Music"
    "/home/ongyean/Pictures"
    "/home/ongyean/Videos"
  ] mountFromNFS) // {
    "/boot".device = lib.mkForce "/dev/disk/by-label/boot";
    "/home/ongyean/Games" = {
      device = "/dev/disk/by-label/Games";
      fsType = "ext4";
      options = [
        "noatime"
        "commit=60"
        "nofail"
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=120"
        "x-systemd.device-timeout=5s"
      ];
    };
  };

  services.scx.scheduler = "scx_lavd";

  # Device-specific GPU undervolting
  services.lact.settings.profiles."Undervolt".gpus."10DE:21C4-1458:4013-0000:01:00.0" = {
    fan_control_enabled = false;
    power_mizer_mode = "PreferMaximumPerformance";
    power_cap = 150.0;
    min_core_clock = 300;
    max_core_clock = 2000;
    gpu_clock_offsets."0" = 120;
    mem_clock_offsets."0" = 1000;
  };

  environment.systemPackages = with pkgs; [
    # Create fake nvidia-offload that simply passes everything
    (writeShellScriptBin "nvidia-offload" "exec \"$@\"")
  ];
}
