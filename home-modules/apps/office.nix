{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.okular
    xournalpp
  ];

  programs.libreoffice = {
    enable = true;
  };

  # Set Okular as the default application for PDF file format
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "okularApplication_pdf.desktop";
    "application/x-gzpdf" = "okularApplication_pdf.desktop";
    "application/x-bzpdf" = "okularApplication_pdf.desktop";
  };
}
