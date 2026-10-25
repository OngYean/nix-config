# Enable screen brightness adjustment from userspace shell
{ pkgs, ... }:

{
  hardware.i2c.enable = true;
  environment.systemPackages = [ pkgs.ddcutil ];
}
