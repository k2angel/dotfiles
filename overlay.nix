final: prev:

let
  lib = prev.lib;

  readDirIfExists = path: if builtins.pathExists path then builtins.readDir path else { };

  byName = lib.mapAttrs (name: _: final.callPackage ./pkgs/by-name/${name}/package.nix { }) (
    readDirIfExists ./pkgs/by-name
  );

  pythonExtension =
    python-final: _:
    lib.mapAttrs (name: _: python-final.callPackage ./pkgs/development/python-modules/${name} { }) (
      readDirIfExists ./pkgs/development/python-modules
    );
in
byName
// {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    pythonExtension
  ];
}
