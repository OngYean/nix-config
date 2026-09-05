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
  # Nix garbage collection settings
  nix.gc = {
    automatic = true;
    dates = "*-*-* 21:00:00";
    options = "--delete-older-than 3d";
  };

  # NEVER CHANGE THIS
  system.stateVersion = "26.05";
}
