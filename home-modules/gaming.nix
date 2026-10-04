{ config, pkgs, ... }@args:

let
  mkProtonGame = (import ../utils.nix args).mkProtonGame;
in
{
  # Gather GLCache from all games in one place
  home.sessionVariables = {
    __GL_SHADER_DISK_CACHE_PATH = "${config.home.homeDirectory}/.cache";
    __GL_SHADER_DISK_CACHE_SIZE = 12000000000;
    VKD3D_SHADER_CACHE_PATH = "${config.home.homeDirectory}/.cache";
  };

  programs = {
    discord = {
      enable = true;
      settings.SKIP_HOST_UPDATE = true;
    };

    mangohud = {
      enable = true;
      settings = {
        preset = 2; # Show horizontal overlay
        font_file = "${pkgs.inter}/share/fonts/truetype/InterVariable.ttf"; # Use Inter font
        no_display = true; # Hide the HUD by default
      };
    };
  };

  home.packages = with pkgs; [
    # Games
    osu-lazer-bin
    prismlauncher

    # Custom shell script binaries for Proton games
    # ===========================
    # ===== How to install? =====
    # ===========================
    # 1. Confirm the GAMEID (umu-yourgame), WINEPREFIX will default to $HOME/Games/umu/GAMEID and it doesn't have to be set
    # 2. Confirm the PROTONPATH, use `nix eval --raw nixpkgs#pkgs.yourproton.steamcompattool` to find it
    # 3. Run `GAMEID=<GAMEID> PROTONPATH=<PROTONPATH> umu-run <path to exe>`
    # Step 3 can be used for the game installer, launcher and other Windows utilities
    (mkProtonGame {
      name = "umu-genshin";
      exePath = "$HOME/Games/umu/$GAMEID/drive_c/Program Files/Unlocker/unlockfps_nc.exe";
      env = {
        UMU_USE_STEAM=1;
        PROTON_ENABLE_WAYLAND=1;
        PROTON_DXVK_GPLASYNC=1;
      };
    })

    (mkProtonGame {
      name = "umu-genshin-launcher";
      gameid = "umu-genshin";
      exePath = "$HOME/Games/umu/$GAMEID/drive_c/Program Files/HoYoPlay/launcher.exe";
      env = {
        UMU_USE_STEAM=1;
        PROTON_DXVK_GPLASYNC=1;
      };
    })

    (mkProtonGame {
      name = "umu-starrail";
      exePath = "$HOME/Games/umu/$GAMEID/drive_c/Program Files/HoYoPlay/games/Star Rail Games/StarRail.exe";
      env = {
        PROTON_ENABLE_WAYLAND=1;
        PROTON_DXVK_GPLASYNC=1;
      };
    })

    (mkProtonGame {
      name = "umu-starrail-launcher";
      gameid = "umu-starrail";
      exePath = "$HOME/Games/umu/$GAMEID/drive_c/Program Files/HoYoPlay/launcher.exe";
      env = {
        PROTON_DXVK_GPLASYNC=1;
      };
    })

    (mkProtonGame {
      name = "umu-nte";
      exePath = "$HOME/Games/umu/$GAMEID/drive_c/Program Files/Neverness To Everness/NTEGlobalLauncher.exe";
      env = {
        PROTON_ENABLE_WAYLAND=1;
        PROTON_DXVK_GPLASYNC=1; # Active when run with DX11
        VKD3D_CONFIG="force_static_cbv"; # Active when run with DX12
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

      actions."open-launcher" = {
        name = "Open Launcher";
        exec = "umu-genshin-launcher";
        icon = "genshin-impact";
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

      actions."open-launcher" = {
        name = "Open Launcher";
        exec = "umu-starrail-launcher";
        icon = "honkai-star-rail";
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
