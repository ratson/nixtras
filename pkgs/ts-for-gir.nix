{
  lib,
  buildNpmPackage,
  fetchurl,
  inputs,
  ...
}:

let
  pname = "ts-for-gir";
  version = "4.0.0-beta.21";
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

    hash = "sha256-082932w1DtraiHl8PXPFl6gNNmd62mGHtqh6O1+z1Q0=";
    lock.hash = "sha256-EbqeUuZQwwKUl5ZmeX9ETP3dqmL2w0ezGpV9u84WJzs=";

    npmDepsHash = "sha256-2P4Wn4wTptCEApl+RlLIuzxqymACa/my96VenRZDfhw=";

    meta.mainProgram = pname;
  }
)
