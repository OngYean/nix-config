# Host: ongyean-laptop
# The LUKS2 container should be named "nixos"
# and the boot partition should be labelled "boot"
{ lib, inputs, ... }:

{
  imports = [
    ../../modules/common
    ../../modules/apps.nix
    ../../modules/fonts.nix
    ../../modules/gaming.nix
    ../../modules/secure-boot.nix
    ../../modules/services.nix
    ../../modules/tweaks.nix
    ../../modules/hardware/amd.nix
    ../../modules/hardware/amdgpu.nix
    ../../modules/hardware/nvidia-prime.nix
    ../../home/ongyean
    ./hardware-configuration.nix
    inputs.chaotic.nixosModules.default
  ];

  networking.hostName = "ongyean-laptop";

  # Absolutely proprietary
  nixpkgs.config.allowUnfree = true;

  # Device-specific workaround for Zed to use AMD GPU
  environment.sessionVariables = {
    ZED_DEVICE_ID = "1681";
  };

  # Built-in webcam is broken on this laptop :(
  # Hence it is blocked via udev rule to avoid being waken up
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="30c9", ATTR{idProduct}=="0065", ATTR{authorized}="0"
  '';

  # Unlock the LUKS2 container first so that the partitions can mount
  boot.initrd.luks.devices."nixos" = {
    device = "/dev/disk/by-label/nixos";
    preLVM = true;
  };

  # Force the boot partition to be found via its label
  fileSystems."/boot".device = lib.mkForce "/dev/disk/by-label/boot";

  # Specify `amdgpuBusId` as required by NVIDIA PRIME
  hardware.nvidia.prime.nvidiaBusId = "PCI:1@0:0:0";
  hardware.nvidia.prime.amdgpuBusId = "PCI:7@0:0:0";

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

      profiles."Undervolt".gpus."10DE:25A2-103C:8A21-0000:01:00.0" = {
        fan_control_enabled = false;
        power_mizer_mode = "Auto";
        min_core_clock = 210;
        max_core_clock = 1950;
        gpu_clock_offsets."0" = 220;
      };
    };
  };
}
