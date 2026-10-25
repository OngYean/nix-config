# Host: ongyean-laptop
# The LUKS2 container should be named "nixos"
# and the boot partition should be labelled "boot"
{ lib, inputs, ... }:

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
    ../../modules/hardware/amd.nix
    ../../modules/hardware/amdgpu.nix
    ../../modules/hardware/nvidia-prime.nix
    ../../users/ongyean
    ./hardware-configuration.nix
    inputs.chaotic.nixosModules.default
  ];

  networking.hostName = "ongyean-laptop";

  # Set this device to masquerade network traffic through Ethernet port
  networking = {
    networkmanager.ensureProfiles.profiles."desktop-share" = {
      connection = {
        id = "desktop-share";
        type = "ethernet";
        interface-name = "eno1";
        autoconnect = "true";
        autoconnect-priority = "-10";
      };

      ipv4 = {
        method = "shared";
        address1 = "10.42.0.1/24";
      };
      ipv6.method = "ignore";
    };

    # Avoid rpfilter from dropping NATed traffic
    firewall.checkReversePath = "loose";
  };

  # Share user `ongyean`'s media directories through shared mode
  services.nfs.server = {
    enable = true;
    exports = ''
      /home/ongyean/Documents 10.42.0.0/24(rw,sync,no_subtree_check)
      /home/ongyean/Music 10.42.0.0/24(rw,sync,no_subtree_check)
      /home/ongyean/Pictures 10.42.0.0/24(rw,sync,no_subtree_check)
      /home/ongyean/Videos 10.42.0.0/24(rw,sync,no_subtree_check)
      /home/ongyean/Games 10.42.0.0/24(rw,sync,no_subtree_check)
    '';
  };

  # Allow DNS, DHCP and NFS ports on Ethernet interface
  networking.firewall.interfaces."eno1" = {
    allowedUDPPorts = [ 53 67 ];
    allowedTCPPorts = [ 53 2049 ];
  };

  networking.wireless.iwd.settings = {
    Rank.BandModifier6GHz = 65535;
    Rank.BandModifier2_4GHz = 0.0;
  };

  # Absolutely proprietary
  nixpkgs.config.allowUnfree = true;

  # Device-specific workaround for Zed to use AMD GPU
  environment.sessionVariables = {
    ZED_DEVICE_ID = "1681";
  };

  services.displayManager.noctalia-greeter.enable = true;

  # Built-in webcam is broken on this laptop :(
  # Hence it is blocked via udev rule to avoid being waken up
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="30c9", ATTR{idProduct}=="0065", ATTR{authorized}="0"
  '';

  # Unlock the LUKS2 container first so that the partitions can mount
  boot.initrd.luks.devices."nixos".device = "/dev/disk/by-label/nixos";

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
      	mem_clock_offsets."0" = 1000;
      };
    };
  };
}
