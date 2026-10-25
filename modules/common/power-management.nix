{ config, pkgs, ... }:

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

  # Automatically change power profile based on A/C power supply status
  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="power_supply", KERNEL=="AC*", ATTR{online}=="1", RUN+="${pkgs.tuned}/bin/tuned-adm profile ${config.services.tuned.ppdSettings.profiles.balanced}"
    ACTION=="change", SUBSYSTEM=="power_supply", KERNEL=="AC*", ATTR{online}=="0", RUN+="${pkgs.tuned}/bin/tuned-adm profile ${config.services.tuned.ppdSettings.profiles.power-saver}"
  '';
}
