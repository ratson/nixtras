{ lib, buildNpmPackage, fetchurl, outputs, ... }:

let
  pname = "vtsls";
  version = "0.2.4";
in
buildNpmPackage (outputs.lib.npmArgs {
  inherit fetchurl lib pname version;

  package = "@vtsls/language-server";

  hash = "sha256-8bStgXGc1zVngAmNZgyxoeiJ9Ybq4t0mXu1NYft7H+0=";
  json.hash = "sha256-aLtmBxcs053WGnKbxtRsHKy8XclsXkgrryq6EgWsASs=";
  lock.hash = "sha256-W5rKAT0dnGhvvTKASeoDscH84bKsKqgnF05idwejicI=";

  npmDepsHash = "sha256-cwzkSqHnDENVytMOgQrQNe823z0R8M8pQ6/qJ+Abnag=";

  meta = {
    mainProgram = "vtsls";
  };
})
