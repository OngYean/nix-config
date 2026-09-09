{ ... }:

{
  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./locale.nix
    ./networking.nix
    ./pipewire.nix
    ./power-management.nix
  ];

  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  # Nix garbage collection settings
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

  # NEVER CHANGE THIS
  system.stateVersion = "26.05";
}
