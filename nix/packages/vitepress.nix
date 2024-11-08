{ buildNpmPackage, fetchurl, ... }:

let
  version = "1.5.0";
  lockfile = fetchurl {
    url = "https://github.com/ratson/npm-lockfiles/raw/main/vitepress/${version}/package-lock.json";
    hash = "sha256-B7NV7iYuk+J5QgSnq6Xslt/KY8ki+xqkweS2BDdKxms=";
  };
  pkg-json = fetchurl {
    url = "https://github.com/ratson/npm-lockfiles/raw/main/vitepress/${version}/package.json";
    hash = "sha256-pBaW54MTbki5NHlPvEMH6P70S5aCzcCOH+PH2fR83EU=";
  };
in
buildNpmPackage rec {
  inherit version;

  pname = "vitepress";
  src = fetchurl {
    url = "https://registry.npmjs.org/vitepress/-/vitepress-${version}.tgz";
    hash = "sha256-ahtABhB9ar2gVLV8M1AXtmquX6k6a1QXVTp6D8T23LA=";
  };

  dontNpmBuild = true;
  npmDepsHash = "sha256-Wr5mWXtfebbTG9X4lsO4olH0asyFzxB7IzLoGkN6A+0=";

  postPatch = ''
    cp "${pkg-json}" ./package.json
    cp "${lockfile}" ./package-lock.json
  '';
}
