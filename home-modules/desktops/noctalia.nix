# Noctalia shell along with curated theme
# This setup uses zsh, please set the user's default shell to zsh
{ config, pkgs, ... }:

{
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

  fonts.packages = with pkgs; [
    # Mono font used in qtengine config
    jetbrains-mono
  ];

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
}
