{ lib, pyproject-nix }:

lib.fix (
  self:
  let
    mkExtension = import ./packages.nix {
      inherit (self.lib) resolvers;
      inherit lib;
    };
  in
  {
    inherit mkExtension;
    packages = { newScope, callPackage, python, ... }: lib.makeScope newScope (callPackage mkExtension { inherit python; });
    lib = import ./lib { inherit lib pyproject-nix; };
    hacks = import ./hacks;
    util = import ./util;
  }
)
