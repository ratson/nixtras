{ lib, buildNpmPackage, fetchurl, outputs, ... }:

let
  pname = "json-schema-to-typescript";
  version = "14.0.5";
  rev = "89a7b326ef18c75ad801ca93c780df8fd69ab644";
in
buildNpmPackage (outputs.lib.npmArgs {
  inherit fetchurl lib pname version;

  package = "@frat/${pname}";

  hash = "sha256-ME4KZ17QY2F5fJucb7txY71wz0CF2w6rdnbl7qLPl08=";
  lock.url = "https://raw.githubusercontent.com/bcherny/json-schema-to-typescript/${rev}/package-lock.json";
  lock.hash = "sha256-Tljs6pJ21lw1y+kgzusH4LYN8nbRm+qbfrs35T/sfn0=";

  npmDepsHash = "sha256-kPJV5OtMoUx8sclWwonHvTBvpDdiN7kM7H6bqPnb8JQ=";

  meta = {
    mainProgram = "json2ts";
  };
})
