{ ... }:

{
  services.pipewire = {
    enable = true;

    audio = true;
    alsa = true;
    jack = true;
    pulse = true;
  };

  security.pam.loginLimits = [
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
    { domain = "@audio"; item = "nice";   type = "-"; value = "-11"; }
  ];
}
