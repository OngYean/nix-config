{ ... }:

{
  # TODO: Set up good DNS provider and change to systemd-resolved
  networking.networkmanager = {
    enable = true;
    dns = "default";
    ethernet.macAddress = "random";
    wifi.macAddress = "random";
    wifi.backend = "wpa_supplicant";
    wifi.powersave = true;
  };

  networking.firewall = {
    enable = true;
  };
}
