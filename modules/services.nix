# Services that make sense to have on a PC
{ ... }:

{
  # Enable OpenTabletDriver
  hardware.opentabletdriver.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
}
