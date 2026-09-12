# Darwin Plymouth theme
{ stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation rec {
  pname = "darwin-plymouth";
  version = "2.0";

  src = fetchFromGitHub {
    owner = "libredeb";
    repo = "darwin-plymouth";
    tag = version;
    hash = "sha256-JDb+m3lZu8cMLkTkG4SSzu/0c2GgMN9SZl6E+VqwpHY=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/plymouth/themes/darwin
    cp -r darwin/* $out/share/plymouth/themes/darwin/
    substituteInPlace $out/share/plymouth/themes/darwin/darwin.plymouth \
          --replace-fail "/usr/" "$out/"
    runHook postInstall
  '';
}
