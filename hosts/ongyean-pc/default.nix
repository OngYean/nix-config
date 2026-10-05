# Host: ongyean-pc
# The LUKS2 container should be named "nixos"
# and the boot partition should be labelled "boot"
{ lib, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/common
    ../../modules/gaming.nix
    ../../modules/hyprland.nix
    ../../modules/kde-file-management.nix
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

  # Force 5GHz network due to 2.4GHz unreliability
  networking.wireless.iwd.settings = {
    Rank.BandModifier5GHz = 65535;
    Rank.BandModifier2_4GHz = 0.0;
  };

  # Unlock the LUKS2 container first so that the partitions can mount
  boot.initrd.luks.devices."nixos" = {
    device = "/dev/disk/by-label/nixos";
    preLVM = true;
  };

  # Force the boot partition to be found via its label
  fileSystems."/boot".device = lib.mkForce "/dev/disk/by-label/boot";

  fileSystems."/home/ongyean/Games" = {
    device = "/dev/disk/by-label/Games";
    fsType = "ext4";
    options = [
      "noatime"
      "commit=60"
      "nofail"
      "noauto"
      "x-systemd.automount"
      # "x-systemd.idle-timeout=120"
      # "x-systemd.device-timeout=5s"
    ];
  };

  services.scx.scheduler = "scx_lavd";

  # Device-specific GPU undervolting
  services.lact = {
    enable = true;
    settings = {
      version = 7;
      daemon = {
        log_level = "info";
        admin_group = "wheel";
        disable_clocks_cleanup = false;
      };
      apply_settings_timer = 5;
      current_profile = "Undervolt";

      profiles."Undervolt".gpus."10DE:21C4-1458:4013-0000:01:00.0" = {
        fan_control_enabled = false;
        power_mizer_mode = "PreferMaximumPerformance";
        power_cap = 150.0;
        min_core_clock = 300;
        max_core_clock = 2000;
        gpu_clock_offsets."0" = 120;
        mem_clock_offsets."0" = 1000;
      };
    };
  };
  
  # Enable screen brightness adjustment from userspace shell
  services.ddccontrol = {
    enable = true;
    package = pkgs.ddcutil;
  };

  environment.systemPackages = with pkgs; [
    # Create fake nvidia-offload that simply passes everything
    (writeShellScriptBin "nvidia-offload" "exec \"$@\"")
  ];
}
