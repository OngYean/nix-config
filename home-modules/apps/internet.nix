{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  oldPkgs = import inputs.nixpkgs-old {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  home.packages = with pkgs; [
    brave-origin
    (symlinkJoin {
      name = "spotifast-patched";
      paths = [ pkgs.spotifast ];
      postBuild = ''
        rm $out/share/applications/spotifast.desktop
        substitute ${pkgs.spotifast}/share/applications/spotifast.desktop \
          $out/share/applications/spotifast.desktop \
          --replace-fail "Icon=spotifast" "Icon=spotify" \
          --replace-fail "Name=Spotifast" "Name=Spotify"
      '';
    })
    (symlinkJoin {
      name = "zapfast-patched";
      paths = [ oldPkgs.zapfast ];
      postBuild = ''
        rm $out/share/applications/zapfast.desktop
        substitute ${oldPkgs.zapfast}/share/applications/zapfast.desktop \
          $out/share/applications/zapfast.desktop \
          --replace-fail "Icon=zapfast" "Icon=whatsapp" \
          --replace-fail "Name=ZapFast" "Name=WhatsApp"
      '';
    })
    telegram-desktop
  ];

  # Set Brave Origin as the default web browser
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "brave-origin.desktop";
    "x-scheme-handler/https" = "brave-origin.desktop";
    "x-scheme-handler/about" = "brave-origin.desktop";
    "x-scheme-handler/unknown" = "brave-origin.desktop";

    "text/html" = "brave-origin.desktop";
    "application/xhtml+xml" = "brave-origin.desktop";
  };

  # Pull Noto Sans CJK and expose only the heavier weights to Spotifast and ZapFast
  home.activation.fastAppsCJKFont = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/.local/share/fonts
    $DRY_RUN_CMD ln -sf ${pkgs.noto-fonts-cjk-sans-static}/share/fonts/opentype/noto-cjk/NotoSansCJK-Bold.ttc ${config.home.homeDirectory}/.local/share/fonts/
  '';
}
