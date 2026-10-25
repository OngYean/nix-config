{
  config,
  lib,
  pkgs,
  ...
}:

let
  gamemodeStart = pkgs.writeShellScript "gamemode-start" ''
    ${pkgs.tuned}/bin/tuned-adm profile ${config.services.tuned.ppdSettings.profiles.performance}
    sudo ${pkgs.systemd}/bin/systemctl start lactd.service
    ${pkgs.libnotify}/bin/notify-send -i game -a 'FeralInteractive GameMode' -i applications-games 'Game Mode is ON'
  '';

  gamemodeStop = pkgs.writeShellScript "gamemode-stop" ''
    ${pkgs.tuned}/bin/tuned-adm profile $(${pkgs.tuned}/bin/tuned-adm recommend)
    sudo ${pkgs.systemd}/bin/systemctl stop lactd.service
    ${pkgs.libnotify}/bin/notify-send -i game -a 'FeralInteractive GameMode' -i applications-games 'Game Mode is OFF'
  '';
in
{
  boot.kernelModules = [ "ntsync" ];

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      dwproton-bin
    ];
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true; # Requires `gamemode` user group
    settings = {
      general = {
        renice = 10;
      };
      custom = {
        start = "${gamemodeStart}";
        end = "${gamemodeStop}";
      };
    };
  };

  # Allows `gamemode` user group members to start/stop lactd without sudo
  security.sudo.extraConfig = ''
    %gamemode ALL=(root) NOPASSWD: ${pkgs.systemd}/bin/systemctl start lactd.service, ${pkgs.systemd}/bin/systemctl stop lactd.service
  '';

  # Enables GPU undervolting support via LACT
  services.lact = {
    enable = true;
    settings = {
      version = 7;
      daemon = {
        log_level = "info";
        admin_group = "wheel";
        disable_clocks_cleanup = false;
      };
      apply_settings_timer = 5;
      current_profile = "Undervolt";
    };
  };

  # Disables lactd.service, it should be started by gamemode on demand
  systemd.services.lactd.wantedBy = lib.mkForce [ ];

  environment.systemPackages = with pkgs; [
    umu-launcher
  ];
}
