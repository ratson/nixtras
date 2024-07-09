{ buildNpmPackage, fetchurl, ... }:

let
  pname = "release-it";
  version = "17.5.0";
  lockfile = fetchurl {
    url = "https://raw.githubusercontent.com/release-it/release-it/${version}/package-lock.json";
    hash = "sha256-GTUu75yYFivefGyjyLUlAhUUdaCfy8yuWPK0Iq8fkq8=";
  };
in
buildNpmPackage {
  inherit pname version;

  src = fetchurl {
    url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
    hash = "sha256-UmUe498YyU5AZCirySFJ1lft2/GfeyZjgvurRSm9Wv4=";
  };

  dontNpmBuild = true;
  npmDepsHash = "sha256-FLG/xUWO84sUV1gcarvywA9i/bos6Btm/B0ejTrVW2I=";
  npmFlags = [ "--legacy-peer-deps" ];

  postPatch = ''
    cp "${lockfile}" ./package-lock.json
  '';
}
