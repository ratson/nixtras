{ buildNpmPackage, fetchurl, ... }:

buildNpmPackage rec {
  pname = "release-it";
  version = "17.3.0";
  src = fetchurl {
    url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
    hash = "sha256-T6tPexYwXQCCsbwo3eI+WvQ0RYmxbzoniQSAe9Ygvr0=";
  };

  lockfile = fetchurl {
    url = "https://raw.githubusercontent.com/release-it/release-it/${version}/package-lock.json";
    hash = "sha256-KUqRl4jBnCdMelMZwSb1brSBvPPhLQXWH+az+DODEY0=";
  };

  dontNpmBuild = true;
  npmDepsHash = "sha256-vE/vWFe3fpdwhUGHKydXbd461wzBAT8w7SjlJtzXmE4=";

  postPatch = ''
    cp "${lockfile}" ./package-lock.json
  '';
}
