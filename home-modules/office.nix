{ pkgs, ...}:

{
  home.packages = with pkgs; [
    kdePackages.okular
    xournalpp
  ];

  programs.libreoffice = {
    enable = true;
  };
}
