{ buildNpmPackage, fetchurl, ... }:

let
  pname = "release-it";
  version = "17.6.0";
  lockfile = fetchurl {
    url = "https://raw.githubusercontent.com/release-it/release-it/${version}/package-lock.json";
    hash = "sha256-IBksAmFkZEK/sFLhHK7YF7A2e53MzBR8N9M1hMkffjM=";
  };
in
buildNpmPackage {
  inherit pname version;

  src = fetchurl {
    url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
    hash = "sha256-vN2A11mpa428o9ZitbM8NhX8gihEErbyNVTiSCUNG+U=";
  };

  dontNpmBuild = true;
  npmDepsHash = "sha256-LUJbbKws30B+AeGaUyx9gA532bRNse4AFixA1htxUMc=";
  npmFlags = [ "--legacy-peer-deps" ];

  postPatch = ''
    cp "${lockfile}" ./package-lock.json
  '';
}
