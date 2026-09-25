lib:

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
}
