{ ... }:

{
  services.tuned = {
    enable = true;
    ppdSupport = true;
    ppdSettings = {
      profiles = {
        balanced = "balanced";
        performance = "throughput-performance";
        power-saver = "powersave";
      };
    };
  };
  services.upower.enable = true;
}
