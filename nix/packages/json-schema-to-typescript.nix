{ buildNpmPackage, fetchurl, ... }:

buildNpmPackage rec {
  pname = "json-schema-to-typescript";
  version = "14.0.4";
  src = fetchurl {
    url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
    hash = "sha256-0nM4XHkCbxs93jWP1b5+A0/MFjORc+NLRUBK8uqmbrw=";
  };

  lockfile = fetchurl {
    url = "https://github.com/bcherny/json-schema-to-typescript/raw/master/package-lock.json";
    hash = "sha256-Tljs6pJ21lw1y+kgzusH4LYN8nbRm+qbfrs35T/sfn0=";
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
