# Use fcitx5 as the default input method as ibus is not available in Home Manager
{ ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
  };
}
