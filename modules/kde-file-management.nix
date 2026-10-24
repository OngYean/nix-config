{ pkgs, ... }:

{
  programs.partition-manager.enable = true;
  environment.systemPackages = with pkgs; with kdePackages; [
    dolphin
    dolphin-plugins
    ark
    filelight
    (callPackage ../pkgs/image2pdf-dolphin-plugin {})
  ];

  # Required for image2pdf-dolphin-plugin to be discoverable by Dolphin
  environment.pathsToLink = [ "/share/kio/servicemenus" ];
}
