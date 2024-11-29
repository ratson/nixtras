{
  lib,
  buildNpmPackage,
  fetchurl,
  outputs,
  ...
}:

let
  pname = "vtsls";
  version = "0.2.6";
in
buildNpmPackage (
  outputs.lib.npmArgs {
    inherit
      fetchurl
      lib
      pname
      version
      ;

    package = "@vtsls/language-server";

    hash = "sha256-5fxQvKUzgBox66qumsOtSTh7PbSn6e/ovTOsDP8BWLY=";
    json.hash = "sha256-g8VjYT7qokQjcUjxXC13M9Eq5POz4g8yLaK6o7ncMIk=";
    lock.hash = "sha256-j5ylmXwpr6Gr1vUvi9whn87lgNXI3+zyVo0r1j1HqiY=";

    npmDepsHash = "sha256-qXz8qaC3taTsk4r68fldGkKNgLNBeflwe5nII3SNUgE=";

    meta = {
      mainProgram = "vtsls";
    };
  }
)
