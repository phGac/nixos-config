{ lib }:

excluded:
  lib.filterAttrs
    (
      name: _:
        let
          lowerName = lib.toLower name;
        in
        !(lib.any (mod: lib.hasInfix mod lowerName) excluded)
    )