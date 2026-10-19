{
  self,
  lib,
  pkgs,
  ...
}:

let
  readDirIfExists = path: if builtins.pathExists path then builtins.readDir path else { };

  byName = lib.mapAttrs (name: _: pkgs.callPackage (self + /pkgs/by-name/${name}/package.nix) { }) (
    readDirIfExists (self + /pkgs/by-name)
  );

  pythonExtension =
    python-final: _:
    lib.mapAttrs (
      name: _: python-final.callPackage (self + /pkgs/development/python-modules/${name}) { }
    ) (readDirIfExists (self + /pkgs/development/python-modules));
in
{
  nixpkgs.overlays = [
    (
      final: prev:
      byName
      // {
        pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
          pythonExtension
        ];
      }
    )
  ];
}
