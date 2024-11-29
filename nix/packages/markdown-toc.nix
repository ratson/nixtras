{
  lib,
  buildNpmPackage,
  fetchurl,
  outputs,
  ...
}:

let
  pname = "markdown-toc";
  version = "1.3.0";
in
buildNpmPackage (
  outputs.lib.npmArgs {
    inherit
      fetchurl
      lib
      pname
      version
      ;

    package = "@frat/${pname}";

    hash = "sha256-z1GDzX5v5ugYSzj3SV/Vlva3X/HcZPIRsZGdESfRCU8=";
    lock.hash = "sha256-U+Elmv8D4W2xi1zzdqk20yO9XEx7Uohv4GvZiY9ck2w=";

    npmDepsHash = "sha256-EjY0DtAEcWbrOAJbzQS2yhEEXXD01OeSVp+0O4vmWJM=";

    meta = {
      mainProgram = "markdown-toc";
    };
  }
)
