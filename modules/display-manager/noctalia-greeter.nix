{ pkgs, ...}:

{
  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      cursor.size = 36;
      keyboard.layout = "us";
      clock.enabled = false;
    };
    cursorTheme = {
      package = pkgs.callPackage ../../pkgs/mactahoe-cursors {};
      name = "MacTahoe-cursors";
    };
  };
}
