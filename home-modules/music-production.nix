{ pkgs, inputs, ... }:

let
  oldPkgs = import inputs.nixpkgs-old {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  home.packages = with pkgs; with oldPkgs; [
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
