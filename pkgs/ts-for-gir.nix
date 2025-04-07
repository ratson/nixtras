{
  lib,
  buildNpmPackage,
  fetchurl,
  inputs,
  ...
}:

let
  pname = "ts-for-gir";
  version = "4.0.0-beta.23";
in
buildNpmPackage (
  inputs.self.lib.npmArgs {
    inherit
      fetchurl
      lib
      pname
      version
      ;

    package = "@ts-for-gir/cli";

    hash = "sha256-7L7/GIQSlQ0Siez8QC/GHcI40hKhICwKfr43puDZc4c=";
    lock.hash = "sha256-sDb1SBB4jsAu1DrUiP49tcHprUUpfd79ATeR6I1NVZQ=";

    npmDepsHash = "sha256-0mSmUUwzBoJtsBkxwqoql3A7wYiZS45xTGfZr168OEg=";

    meta.mainProgram = pname;
  }
)
