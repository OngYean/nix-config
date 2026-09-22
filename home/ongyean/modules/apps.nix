{ config, pkgs, ... }:

{
  programs = {
    noctalia = {
      enable = true;
      systemd.enable = true;
    };

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

    discord = {
      enable = true;
      settings.SKIP_HOST_UPDATE = true;
    };
  };

  # User packages
  home.packages = with pkgs; [
    # Document and multimedia apps
    audacity
    video-trimmer
    obs-studio
    xournalpp

    # Social apps
    telegram-desktop
  ];

  # Desktop entry overrides
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
