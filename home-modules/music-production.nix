{ pkgs, ... }:

{
  home.packages = with pkgs; [
    reaper
    qjackctl
    guitarix

    # Audio plugins
    lsp-plugins
    zam-plugins
  ];

  # TODO: Add the following plugins
  # jdrummer.vst3
  # DuskVerb.clap
  # ZynAddSubFX.vst
  # Surge XT
  # sforzando
  # MDA VST
}
