{ lib, buildNpmPackage, fetchurl, outputs, ... }:

let
  pname = "release-it";
  version = "17.6.0";
in
buildNpmPackage (outputs.lib.npmArgs {
  inherit fetchurl lib pname version;

  hash = "sha256-vN2A11mpa428o9ZitbM8NhX8gihEErbyNVTiSCUNG+U=";
  lock.url = "https://raw.githubusercontent.com/release-it/release-it/${version}/package-lock.json";
  lock.hash = "sha256-IBksAmFkZEK/sFLhHK7YF7A2e53MzBR8N9M1hMkffjM=";

  npmDepsHash = "sha256-LUJbbKws30B+AeGaUyx9gA532bRNse4AFixA1htxUMc=";
  npmFlags = [ "--legacy-peer-deps" ];

  meta = {
    mainProgram = "release-it";
  };
})
