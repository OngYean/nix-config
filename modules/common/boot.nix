{ pkgs, ... }:

{
  #nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
  #nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

  boot = {
    # Use systemd-boot as the boot loader
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };

    # Uncomment this for mainstream Linux kernel
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_cachyos;

    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "nowatchdog"
      "splash"
      "udev.log_level=3"
    ];
    initrd.verbose = false;

    # Plymouth boot screen
    plymouth = {
      enable = true;
      themePackages = [ (pkgs.callPackage ../../pkgs/darwin-plymouth {}) ];
      theme = "darwin";
      font = "${pkgs.inter}/share/fonts/truetype/InterVariable.ttf";
    };
  };
}
