{ pkgs, ...}:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    # package = config.boot.kernelPackages.nvidiaPackages.latest;
    package = pkgs.nvidia_cachyos;
    modesetting.enable = true;
    powerManagement.enable = true;
  };

  # Undervolt time
  services.lact = {
    enable = true;
    settings = {

    };
  };
}
