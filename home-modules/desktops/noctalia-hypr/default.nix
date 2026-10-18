# Noctalia shell along with curated theme
# This setup uses zsh, please set the user's default shell to zsh
# This setup uses KDE's file management suite (modules/kde-file-management.nix)
{
  config,
  lib,
  pkgs,
  ...
}@args:

# Some config and share files are symlinked at build time instead
let
  dotfilesConfig = ./dotfiles/.config;
  # dotfilesData = ./dotfiles/.local/share;
  mkLinks = (import ../../../utils.nix args).mkLinks;
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
      autocd = true;
      autosuggestion.enable = true;
      defaultKeymap = "viins";
      fastSyntaxHighlighting.enable = true;
    };

    zed-editor = {
      enable = true;
      enableMcpIntegration = true;

      extensions = [
        "catppuccin"
        "csv"
        "dockerfile"
        "env"
        "html"
        "ini"
        "java"
        "log"
        "lua"
        "make"
        "material-icon-theme"
        "nix"
        "php"
        "sql"
        "toml"
        "xml"
      ];

      extraPackages = with pkgs; [
        # Language servers
        docker-language-server
        dockerfile-language-server
        vscode-html-languageserver
        jdt-language-server
        lua-language-server
        nil
        nixd
        intelephense
        phpactor
        phpantom-lsp

        # OpenCode dependencies
        nodejs-slim
      ];

      userSettings = {
        agent = {
          default_profile = "write";
          dock = "right";
        };
        auto_update = false;
        base_keymap = "VSCode";
        buffer_font_family = "JetBrains Mono";
        buffer_font_size = 13;
        format_on_save = "modifications";
        icon_theme = "Material Icon Theme";
        outline_panel.dock = "left";
        project_panel = {
          entry_spacing = "standard";
          dock = "left";
        };
        search.button = false;
        telemetry = {
          diagnostics = false;
          metrics = false;
        };
        title_bar = {
          button_layout = "platform_default";
          show_menus = true;
          show_sign_in = false;
          show_user_picture = false;
        };
        ui_font_family = "Inter";
        ui_font_size = 16;
        ui_font_weight = 400.0;
        vim.use_system_clipboard = "on_yank";
        vim_mode = true;
      };
    };

    antigravity-cli = {
      enable = true;
      enableMcpIntegration = true;
    };

    alacritty = {
      enable = true;
      settings = {
        window.padding = {
          x = 12;
          y = 12;
        };
        window.opacity = 0.5;
        window.blur = true;

        font.size = 10.0;
        font.normal.family = "JetBrains Mono";
        font.normal.style = "Regular";

        scrolling.history = 3023;
      };
    };

    fastfetch = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    brave-origin
    resources
    kdePackages.kcalc
    spotifast
    zapfast
  ];

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
      categories = [
        "Settings"
        "DesktopSettings"
      ];
      startupNotify = false;
    };
  };

  # Set Brave Origin as the default web browser
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "brave-origin.desktop";
    "x-scheme-handler/https" = "brave-origin.desktop";
    "x-scheme-handler/about" = "brave-origin.desktop";
    "x-scheme-handler/unknown" = "brave-origin.desktop";

    "text/html" = "brave-origin.desktop";
    "application/xhtml+xml" = "brave-origin.desktop";
  };

  # Reload Hyprland config
  home.activation.reloadHyprctl = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD ${pkgs.hyprland}/bin/hyprctl reload
  '';

  # Global fix for Dolphin being unable to open Neovim
  qt.kde.settings = {
    kdeglobals.General.TerminalApplication = "alacritty";
    kdeglobals.General.TerminalService = "Alacritty.desktop";
  };

  home.activation = {
    # Remove stale ksycoca6 cache files
    removeKsycoca6 = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD rm -f ${config.home.homeDirectory}/.cache/ksycoca6_en_*
    '';

    # Pull Noto Sans CJK and expose only the heavier weights to Spotifast and ZapFast
    fastAppsCJKFont = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/.local/share/fonts
      $DRY_RUN_CMD ln -sf ${pkgs.noto-fonts-cjk-sans-static}/share/fonts/opentype/noto-cjk/NotoSansCJK-Bold.ttc ${config.home.homeDirectory}/.local/share/fonts/
    '';
  };

  # Link dotfiles to the real locations
  xdg.configFile = mkLinks dotfilesConfig;
  # xdg.dataFile = mkLinks dotfilesData;
}
