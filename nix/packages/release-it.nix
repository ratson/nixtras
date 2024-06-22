{ buildNpmPackage, fetchurl, ... }:

let
  pname = "release-it";
  version = "17.4.0";
  lockfile = fetchurl {
    url = "https://raw.githubusercontent.com/release-it/release-it/${version}/package-lock.json";
    hash = "sha256-hdWlsepkKqW2mmeTY5AV0Bi8B4nOSZGuYDv7syvZMPs=";
  };
in
buildNpmPackage {
  inherit pname version;

  src = fetchurl {
    url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
    hash = "sha256-hCIc/R/cCXwL5jYvi/xLbNK7Pjh/cQWXGQClMF95gGA=";
  };

  dontNpmBuild = true;
  npmDepsHash = "sha256-h8xWH66QEix2VQfN2rpVXsnllZDFIeGSNYfxiLJsrwA=";
  npmFlags = [ "--legacy-peer-deps" ];

  postPatch = ''
    cp "${lockfile}" ./package-lock.json
  '';
}
