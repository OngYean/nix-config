{ ... }:

{
  # Enable Hyprland (UWSM)
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;

  # Enable GNOME Keyring ecosystem with SSH agent
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = true;
  programs.seahorse.enable = true;
}