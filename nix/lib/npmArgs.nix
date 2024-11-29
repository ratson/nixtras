{
  pname,
  version,
  lib,
  fetchurl,
  json ? null,
  lock,
  hash,
  package ? pname,
  ...
}@args:

let
  name = lib.last (lib.splitString "/" package);

  lockfile = fetchurl {
    url =
      lock.url
        or "https://raw.githubusercontent.com/ratson/npm-lockfiles/main/${package}/${version}/package-lock.json";
    hash = lock.hash;
  };

  pkg-json = fetchurl {
    url =
      json.url
        or "https://raw.githubusercontent.com/ratson/npm-lockfiles/main/${package}/${version}/package.json";
    hash = json.hash;
  };
  pkg-cp = if json == null then "" else ''cp "${pkg-json}" ./package.json'';

  buildArgs = builtins.removeAttrs args [
    "lib"
    "fetchurl"
    "json"
    "lock"
    "hash"
    "name"
  ];
in
{
  inherit pname version;

  src = fetchurl {
    inherit hash;
    url = "https://registry.npmjs.org/${package}/-/${name}-${version}.tgz";
  };

  dontNpmBuild = true;

  postPatch = ''
    ${pkg-cp}
    cp "${lockfile}" ./package-lock.json
  '';
}
// buildArgs
