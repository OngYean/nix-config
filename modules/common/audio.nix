{ ... }:

{
  services.pipewire = {
    enable = true;

    audio.enable = true;
    alsa.enable = true;
    jack.enable = true;
    pulse.enable = true;
  };

  security.pam.loginLimits = [
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
    { domain = "@audio"; item = "nice";   type = "-"; value = "-11"; }
  ];
}
