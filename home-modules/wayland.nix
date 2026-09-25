{ ... }:

{
  # Session variables that hint (or force) the use of Wayland
  home.sessionVariables = {
    GDK_BACKEND = "wayland,x11,*";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    SDL_VIDEO_DRIVER = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
