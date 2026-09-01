{ pkgs, inputs, ... }:

{
  imports = [
    ../../home
    ./modules
    inputs.home-manager.nixosModules.home-manager
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."ongyean" = {
    isNormalUser = true;
    description = "Ong Yean";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
    shell = pkgs.zsh;
  };

  home-manager.users.ongyean = {
    home.username = "ongyean";
    home.homeDirectory = "/home/ongyean";

    # Again, NEVER CHANGE THIS
    home.stateVersion = "26.05";
  };
}
