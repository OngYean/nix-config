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

  # Absolutely proprietary
  nixpkgs.config.allowUnfree = true;

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
