{ pkgs, ...}:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    # Uncomment this for mainstream NVIDIA kernel module
    # package = config.boot.kernelPackages.nvidiaPackages.latest;
    package = pkgs.nvidia_cachyos;
    modesetting.enable = true;
    powerManagement.enable = true;
  };
}
