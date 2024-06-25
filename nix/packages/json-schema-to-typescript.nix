{ buildNpmPackage, fetchurl, ... }:

let
  pname = "json-schema-to-typescript";
  version = "14.0.5";
  rev = "89a7b326ef18c75ad801ca93c780df8fd69ab644";
  lockfile = fetchurl {
    url = "https://github.com/bcherny/json-schema-to-typescript/raw/${rev}/package-lock.json";
    hash = "sha256-Tljs6pJ21lw1y+kgzusH4LYN8nbRm+qbfrs35T/sfn0=";
  };
in
buildNpmPackage {
  inherit pname version;

  src = fetchurl {
    url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
    hash = "sha256-ME4KZ17QY2F5fJucb7txY71wz0CF2w6rdnbl7qLPl08=";
  };

  dontNpmBuild = true;
  npmDepsHash = "sha256-kPJV5OtMoUx8sclWwonHvTBvpDdiN7kM7H6bqPnb8JQ=";

  postPatch = ''
    cp "${lockfile}" ./package-lock.json
  '';

  meta = {
    mainProgram = "json2ts";
  };
}
