{ config, ... }:

{
  xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  home.sessionVariables = {
    ZED_DEVICE_ID = "1681";
    __GL_SHADER_DISK_CACHE_PATH = "${config.home.homeDirectory}/.cache/nvidia";
    GDK_BACKEND = "wayland,x11,*";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    SDL_VIDEO_DRIVER = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
