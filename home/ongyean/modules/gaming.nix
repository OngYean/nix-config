{ pkgs, config, lib, ... }:

let
  customGameBin = { name, exePath, env ? {}, prefix ? "mangohud gamemoderun", protonPkg ? pkgs.dwproton-bin }:
    let
      envVars = {
        GAMEID = name;
        PROTONPATH = "${protonPkg.steamcompattool}";
        __GL_SHADER_DISK_CACHE_PATH = "${config.home.homeDirectory}/.cache/nvidia";
        # common defaults
      } // env;  # merge game-specific overrides

      envStr = builtins.concatStringsSep "\n"
        (lib.mapAttrsToList (k: v: "export ${k}=${toString v}") envVars);
    in
    pkgs.writeShellScriptBin name ''
      ${envStr}
      nvidia-offload ${prefix} ${pkgs.umu-launcher}/bin/umu-run "${exePath}"
    '';
in
{
  programs.mangohud = {
    enable = true;
    settings = {
      full = true; # Show full information
      font_file = "${pkgs.inter}/share/fonts/truetype/InterVariable.ttf"; # Use Inter font
      round_corners = 12;
      no_display = true; # Hide the HUD by default
    };
  };

  home.packages = with pkgs; [
    dwproton-bin.steamcompattool
    discord
    (customGameBin {
      name = "umu-genshin";
      exePath = "$HOME/Games/umu/$GAMEID/drive_c/Program Files/Unlocker/unlockfps_nc.exe";
      env = {
        UMU_USE_STEAM=1;
        PROTON_ENABLE_WAYLAND=1;
        PROTON_DXVK_GPLASYNC=1;
      };
    })

    (customGameBin {
      name = "umu-starrail";
      exePath = "$HOME/Games/umu/$GAMEID/drive_c/Program Files/HoYoPlay/games/Star Rail Games/StarRail.exe";
      env = {
        PROTON_ENABLE_WAYLAND=1;
        PROTON_DXVK_GPLASYNC=1;
      };
    })

    (customGameBin {
      name = "umu-nte";
      exePath = "$HOME/Games/umu/$GAMEID/drive_c/Program Files/Neverness To Everness/NTEGlobalLauncher.exe";
      env = {
        PROTON_ENABLE_WAYLAND=1;
        PROTON_DXVK_GPLASYNC=1;
        VKD3D_CONFIG="single_queue,no_upload_hvv,force_static_cbv";
      };
    })
  ];

  xdg.desktopEntries = {
    genshin-impact = {
      name = "Genshin Impact";
      exec = "umu-genshin";
      icon = "genshin-impact";
      categories = [ "Game" ];
    };

    honkai-star-rail = {
      name = "Honkai: Star Rail";
      exec = "umu-starrail";
      icon = "star-rail";
      categories = [ "Game" ];
    };

    neverness-to-everness = {
      name = "Neverness To Everness";
      exec = "umu-nte";
      icon = "nte";
      categories = [ "Game" ];
    };
  };
}
