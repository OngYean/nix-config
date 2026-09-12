{ ... }:

{
  networking = {
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      ethernet.macAddress = "random";
      wifi.macAddress = "random";
      wifi.backend = "iwd";
      wifi.powersave = true;
    };

    # Use Cloudflare's public DNS resolver
    nameservers = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
      "2606:4700:4700::1111#one.one.one.one"
      "2606:4700:4700::1001#one.one.one.one"
    ];

    firewall = {
      enable = true;
    };
  };

  services.resolved = {
    enable = true;
    settings.Resolve.DNSOverTLS = true;
  };
}
