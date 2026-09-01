{ pkgs, inputs, ... }:

{
  boot = {
    # Use systemd-boot as the boot loader
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Use CachyOS's LTO kernel (x86-64_v3).
    nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
    nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];
    nixpkgs.overlays = [
      inputs.nix-cachyos-kernel.overlays.pinned
    ];
    boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;

    # Uncomment this for mainstream Linux kernel
    #boot.kernelPackages = pkgs.linuxPackages_latest;

    boot.kernelModules = [ "ntsync" ];

    # Plymouth boot screen
    plymouth = {
      enable = true;
    };
  };
}
