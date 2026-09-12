# Services that make sense to have on a PC
{ ... }:

{
  # Default choice of display manager
  services.displayManager.noctalia-greeter.enable = true;

  # Enable OpenTabletDriver
  hardware.opentabletdriver.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable GNOME Keyring ecosystem with SSH agent
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = true;
}
