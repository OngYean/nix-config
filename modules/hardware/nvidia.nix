{ config, ...}:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    modesetting.enable = true;
  };

  # Undervolt time
  services.lact = {
    enable = true;
    settings = {

    };
  };
}
