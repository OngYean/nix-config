lib: pkgs: 

{
  # Walk through `dir` and create dotfile entries with sources set correctly
  mkLinks = dir:
    let
      walk = base: prefix:
        lib.foldl' (acc: name:
          let
            path = base + "/${name}";
            rel  = if prefix == "" then name else "${prefix}/${name}";
            type = (builtins.readDir base).${name};
          in
          if type == "directory"
          then acc // walk path rel
          else acc // { ${rel}.source = path; }
        ) {} (builtins.attrNames (builtins.readDir base));
    in
    walk dir "";

  # Create user binary for Proton-based games
  mkProtonGame = { name, exePath, gameid ? name, env ? {}, wrapperCmd ? "mangohud gamemoderun", protonPkg ? pkgs.dwproton-bin }:
    let
      envVars = {
        # Common defaults
        GAMEID = gameid;
        PROTONPATH = "${protonPkg.steamcompattool}";
      } // env;  # Merge game-specific overrides

      envStr = builtins.concatStringsSep "\n"
        (lib.mapAttrsToList (k: v: "export ${k}=${toString v}") envVars);
    in
    pkgs.writeShellScriptBin name ''
      ${envStr}
      nvidia-offload ${wrapperCmd} ${pkgs.umu-launcher}/bin/umu-run "${exePath}"
    ''; # Note that for setups not using NVIDIA PRIME, dummy nvidia-offload script should be used
}
