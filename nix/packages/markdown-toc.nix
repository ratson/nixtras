{ lib, buildNpmPackage, fetchurl, outputs, ... }:

let
  pname = "markdown-toc";
  version = "1.3.0";
in
buildNpmPackage (outputs.lib.npmArgs {
  inherit fetchurl lib pname version;

  package = "@frat/${pname}";

  hash = "sha256-z1GDzX5v5ugYSzj3SV/Vlva3X/HcZPIRsZGdESfRCU8=";
  lock.hash = "sha256-+4mtuoe/Jqt9/TEqp4AFJsK4yBM8cJ36H7rkOnvyRnM=";

  npmDepsHash = "sha256-Pp+8Ib3ilyzYX5Pn2TVkCLcN6nTWzViI5BIhN3zVCFU=";

  meta = {
    mainProgram = "markdown-toc";
  };
})
