{ config, ... }:

{
  imports = [
    ./wayland.nix
  ];

  # Under UWSM, this is required to properly import session variables
  xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
}
