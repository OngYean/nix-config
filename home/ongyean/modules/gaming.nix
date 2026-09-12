{ pkgs, config, lib, ... }:

let
  customGameBin = { name, exePath, env ? {}, prefix ? "mangohud gamemoderun", protonPkg ? pkgs.dwproton-bin }:
    let
      envVars = {
        # Common defaults
        GAMEID = name;
        PROTONPATH = "${protonPkg.steamcompattool}";
        __GL_SHADER_DISK_CACHE_PATH = "${config.home.homeDirectory}/.cache/nvidia";
      } // env;  # Merge game-specific overrides

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
      preset = 2; # Show horizontal overlay
      font_file = "${pkgs.inter}/share/fonts/truetype/InterVariable.ttf"; # Use Inter font
      no_display = true; # Hide the HUD by default
    };
  };

  home.packages = with pkgs; [
    # Compatibility tools
    dwproton-bin.steamcompattool

    # Games
    osu-lazer-bin
    prismlauncher

    # Custom desktop entries for Proton games
    # ===========================
    # ===== How to install? =====
    # ===========================
    # 1. Confirm the GAMEID (umu-yourgame), WINEPREFIX will default to $HOME/Games/umu/GAMEID and it doesn't have to be set
    # 2. Confirm the PROTONPATH, use `nix eval --raw nixpkgs#pkgs.yourproton.steamcompattool` to find it
    # 3. Run `GAMEID=<GAMEID> PROTONPATH=<PROTONPATH> umu-run <path to exe>`
    # Step 3 can be used for the game installer, launcher and other Windows utilities
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
      settings = {
        StartupWMClass = "steam_app_genshin";
      };
    };

    honkai-star-rail = {
      name = "Honkai: Star Rail";
      exec = "umu-starrail";
      icon = "honkai-star-rail";
      categories = [ "Game" ];
      settings = {
        StartupWMClass = "steam_app_starrail";
      };
    };

    neverness-to-everness = {
      name = "Neverness To Everness";
      exec = "umu-nte";
      icon = "neverness-to-everness";
      categories = [ "Game" ];
      settings = {
        StartupWMClass = "steam_app_nte";
      };
    };
  };
}
