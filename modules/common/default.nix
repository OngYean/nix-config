{ ... }:

{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./boot.nix
    ./locale.nix
    ./networking.nix
    ./power-management.nix
  ];

  nix.settings.experimental-features = [ "flakes" ];

  # Nix garbage collection settings
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than +8";
  };

  # NEVER CHANGE THIS
  system.stateVersion = "26.05";
}
