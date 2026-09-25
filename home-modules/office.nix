{ pkgs, ...}:

{
  home.packages = with pkgs; [
    libreoffice
    kdePackages.okular
    xournalpp
  ];

  programs.libreoffice = {
    enable = true;
    # package = pkgs.libreoffice-qt;
  };
}
