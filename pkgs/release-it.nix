{
  lib,
  buildNpmPackage,
  fetchurl,
  inputs,
  ...
}:

let
  pname = "release-it";
  version = "17.10.0";
in
buildNpmPackage (
  inputs.self.lib.npmArgs {
    inherit
      fetchurl
      lib
      pname
      version
      ;

    hash = "sha256-EHPx4FcCKvshlQG1Gm61/TbqXDrixyFbfict6hkEbjw=";
    lock.url = "https://raw.githubusercontent.com/release-it/release-it/${version}/package-lock.json";
    lock.hash = "sha256-EP14K+4dj7HZdmjiobnYG3GehnXfllBVdhXp4/NN/SQ=";

    npmDepsHash = "sha256-Po3QbRdVmvNaizIlfBvX5I7DL8k0G9Lc4L0gkpq+qfQ=";

    meta = {
      mainProgram = "release-it";
    };
  }
)
