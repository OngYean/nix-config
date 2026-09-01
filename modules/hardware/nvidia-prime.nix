# NOTE: Override `hardware.nvidia.prime.nvidiaBusId` if it is not `"PCI:1@0:0:0"`
# NOTE: Add `hardware.nvidia.prime.intelBusId` or `hardware.nvidia.prime.amdgpuBusId` based on the GPU present

{ ... }:

{
  imports = [ ./nvidia.nix ];
  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    nvidiaBusId = "PCI:1@0:0:0";
  };
}
