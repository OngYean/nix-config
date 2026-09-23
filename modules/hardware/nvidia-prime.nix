# NOTE: Add `hardware.nvidia.prime.nvidiaBusId` which is usually `"PCI:1@0:0:0"` on AMD laptops
# NOTE: Add `hardware.nvidia.prime.intelBusId` or `hardware.nvidia.prime.amdgpuBusId` based on the GPU present

{ ... }:

{
  imports = [ ./nvidia.nix ];
  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
  };
}
