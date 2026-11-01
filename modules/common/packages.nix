# Useful system utility packages
{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    btop
    psmisc
    lsof
  ];
}
