{ pkgs, ... }:

{
programs.zed-editor = {
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
          show_menus = false;
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
}
