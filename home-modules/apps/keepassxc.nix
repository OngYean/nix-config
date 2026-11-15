{ lib, ... }:

{
  programs.keepassxc = {
    enable = true;
    autostart = true;
    settings = {
      Browser = {
        Enabled = true;
      };
      GUI = {
        AdvancedSettings = true;
        ApplicationTheme = "dark";
        CompactMode = true;
        HidePasswords = true;
        ShowTrayIcon = true;
        MinimizeToTray = true;
        MinimizeOnStartup = true;
        MinimizeOnClose = true;
      };
      SSHAgent = {
        Enabled = true;
        UseOpenSSH = true;
        UsePageant = false;
      };
    };
  };

  services.ssh-agent.enable = lib.mkDefault true;
}
