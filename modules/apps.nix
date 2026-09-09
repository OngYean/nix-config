# Curated apps (packages) for a functional system
{ pkgs, ... }:

{
  programs = {
    # Desktop experience must-haves - Hyprland WM
    hyprland.enable = true;
    hyprland.withUWSM = true;

    # Basic dev setup
    zsh.enable = true;
    git = {
      enable = true;
      config = {
        init = {
          defaultBranch = "main";
        };
        url = {
          "https://github.com/" = {
            insteadOf = [
              "gh:"
              "github:"
            ];
          };
        };
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      configure = {
      };
    };

    # An app to manage GNOME keyring credentials
    seahorse.enable = true;
  };

  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    wget
    alacritty
    fastfetch
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.filelight
    kdePackages.ark
    kdePackages.partitionmanager
    brave-origin
    restic
    btop
    resources
  ];
}
