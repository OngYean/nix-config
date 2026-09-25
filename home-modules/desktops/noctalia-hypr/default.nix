# Noctalia shell along with curated theme
# This setup uses zsh, please set the user's default shell to zsh
# This setup uses KDE's file management suite (modules/kde-file-management.nix)
{ config, lib, pkgs, ... }:

# Some config and share files are symlinked at build time instead
let
  dotfilesConfig = ./dotfiles/.config;
  # dotfilesData = ./dotfiles/.local/share;
  mkLinks = (import ../../../utils.nix lib).mkLinks;
in
{
  imports = [
    ./theme.nix
  ];

  programs = {
    noctalia = {
      enable = true;
      systemd.enable = true;
    };

    # NOTE: Please set the user's shell to zsh in NixOS config
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      defaultKeymap = "viins";
      fastSyntaxHighlighting.enable = true;
      oh-my-zsh.enable = true;
    };

    # Neovim to replace vi and vim for better experience
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      waylandSupport = true;
    };

    zed-editor = {
      enable = true;
      extensions = [
        "nix"
      ];
      extraPackages = with pkgs; [
        nixd
        nil
      ];
      userSettings = {
        buffer_font_size = 13;
        features = {
          copilot = false;
        };
        telemetry = {
          metrics = false;
        };
        ui_font_size = 17;
        vim_mode = true;
      };
    };

    antigravity-cli = {
      enable = true;
      enableMcpIntegration = true;
    };

    alacritty = {
      enable = true;
    };

    fastfetch = {
      enable = true;
    };
  };

  # Noctalia is Wayland-only, hence set fcitx5 to use Wayland frontend
  i18n.inputMethod.fcitx5.waylandFrontend = true;

  # Desktop entry override for Noctalia
  xdg.desktopEntries = {
    "dev.noctalia.Noctalia" = {
      name = "System Settings";
      comment = "System settings for Noctalia shell";
      exec = "${config.programs.noctalia.package}/bin/noctalia msg settings-open";
      icon = "preferences-system";
      terminal = false;
      categories = [ "Settings" "DesktopSettings" ];
      startupNotify = false;
    };
  };

  # Global fix for Dolphin being unable to open Neovim
  qt.kde.settings = {
    kdeglobals.General.TerminalApplication = "alacritty";
    kdeglobals.General.TerminalService = "Alacritty.desktop";
  };

  # Link dotfiles to the real locations
  xdg.configFile = mkLinks dotfilesConfig;
  # xdg.dataFile = mkLinks dotfilesData;
}
