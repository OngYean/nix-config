{ pkgs, inputs, ... }:

let
  oldPkgs = import inputs.nixpkgs-old {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  environment.systemPackages = with oldPkgs; [
    reaper
    qjackctl
    guitarix

    # Audio plugins
    lsp-plugins
    zam-plugins
    zynaddsubfx
    surge-xt
    mda_lv2 # LV2 instead of VST
    fluida-lv2 # SF2 player, replaces sforzando
    sfizz-ui # SFZ player, replaces sforzando
  ];

  # NOTE: Set DAW's lookup path to start with /run/current-system/sw instead of /usr
  environment.pathsToLink = [
    "/lib/vst"
    "/lib/vst3"
    "/lib/clap"
    "/lib/lv2"
  ];

  # TODO: Add the following plugins
  # jdrummer.vst3
  # DuskVerb.clap
  # sforzando
}
