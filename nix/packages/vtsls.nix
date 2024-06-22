{ buildNpmPackage, fetchurl, ... }:

let
  version = "0.2.4";
  lockfile = fetchurl {
    url = "https://github.com/ratson/npm-lockfiles/raw/main/@vtsls/language-server/${version}/package-lock.json";
    hash = "sha256-W5rKAT0dnGhvvTKASeoDscH84bKsKqgnF05idwejicI=";
  };
in
buildNpmPackage rec {
  inherit version;

  pname = "vtsls";
  src = fetchurl {
    url = "https://registry.npmjs.org/@vtsls/language-server/-/language-server-${version}.tgz";
    hash = "sha256-8bStgXGc1zVngAmNZgyxoeiJ9Ybq4t0mXu1NYft7H+0=";
  };

  dontNpmBuild = true;
  npmDepsHash = "sha256-cwzkSqHnDENVytMOgQrQNe823z0R8M8pQ6/qJ+Abnag=";

  postPatch = ''
    cp "${lockfile}" ./package-lock.json
  '';
}
