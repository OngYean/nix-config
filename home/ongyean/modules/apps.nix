{ pkgs, ... }:

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
  };

  # User packages
  home.packages = with pkgs; [
    xournalpp
    vlc
  ];

  # Desktop entry overrides
}
