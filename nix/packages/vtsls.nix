{ buildNpmPackage, fetchurl, ... }:

buildNpmPackage rec {
  pname = "vtsls";
  version = "0.2.3";
  src = fetchurl {
    url = "https://registry.npmjs.org/@vtsls/language-server/-/language-server-${version}.tgz";
    hash = "sha256-VnMTKUqWpLxntV7RLU6Hsfet4XrdJhOrIjI3QcYpt6w=";
  };

  lockfile = fetchurl {
    url = "https://github.com/ratson/npm-lockfiles/raw/main/@vtsls/language-server/${version}/package-lock.json";
    hash = "sha256-YuSINxKEpqFl7m4z7B9hnHhuhv4V84y6wMeMIANlcmY=";
  };

  dontNpmBuild = true;
  npmDepsHash = "sha256-NcEooikviSZyGAvJs2pp4kSVZLoz8eGEuL3GWZ/S5Is=";

  postPatch = ''
    cp "${lockfile}" ./package-lock.json
  '';
}
