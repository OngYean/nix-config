# image2pdf KDE (Plasma) Dolphin addon
{
  lib,
  fetchFromGitLab,
  stdenvNoCC,
  img2pdf,
  kdePackages,
}:

stdenvNoCC.mkDerivation rec {
  pname = "image2pdf-dolphin-plugin";
  version = "1.6";

  src = fetchFromGitLab {
    domain = "opencode.net";
    owner = "dahoc";
    repo = "image2pdf";
    tag = version;
    hash = "sha256-14Q5Ltrc5LErIC8cQRba32s7eeMMCPsUeIXgGpdGq28=";
  };

  postPatch = ''
    substituteInPlace image2pdf.desktop \
      --replace-fail "TryExec=img2pdf" "TryExec=${lib.getExe img2pdf}" \
      --replace-fail "-v img2pdf" "-v ${lib.getExe img2pdf}" \
      --replace-fail "\$(img2pdf" "\$(${lib.getExe img2pdf}" \
      --replace-fail "kdialog" "${lib.getExe' kdePackages.kdialog "kdialog"}"
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 image2pdf.desktop $out/share/kio/servicemenus/image2pdf.desktop
    runHook postInstall
  '';

  meta = {
    description = "KDE (Plasma) Dolphin addon: Converts images to pdfs with one click.";
    homepage = "https://www.opencode.net/dahoc/image2pdf";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
  };
}
