{ config, ... }:

{
  xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  home.sessionVariables = {
    ZED_DEVICE_ID = "1681";
  };
}
