{ ... }:

{
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    ethernet.macAddress = "random";
    wifi.macAddress = "random";
    wifi.backend = "iwd";
    wifi.powersave = true;
  };

  networking.firewall = {
    enable = true;
  };
}
