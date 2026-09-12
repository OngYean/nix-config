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

  networking.hostName = "ongyean-laptop"; # Define your hostname.

  # WireGuard VPN for ongyean-laptop
  networking.wg-quick.interfaces = {
    wg0 = {
      autostart = false;
      address = [ "192.168.2.2/24" ];
      dns = [ "1.1.1.1" "1.0.0.1" ];
      mtu = 1280;
      privateKeyFile = "/var/lib/wireguard/wg0.key";

      peers = [{
        publicKey = "lyVgaZdfi/M5LR0/cyZhSZlx1URX4ussEBv1Vj94rHA=";
        allowedIPs = [ "0.0.0.0/0" "::/0" ];
        endpoint = "161.118.252.195:51820";
        persistentKeepalive = 25;
      }];
    };
  };

  # Absolutely proprietary
  nixpkgs.config.allowUnfree = true;

  # Built-in webcam is broken on this laptop :(
  # Hence it is blocked via udev rule to prevent being waken up
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
  hardware.nvidia.prime.amdgpuBusId = "PCI:7@0:0:0";
}
