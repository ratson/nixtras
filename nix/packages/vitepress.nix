{
  lib,
  buildNpmPackage,
  fetchurl,
  outputs,
  ...
}:

let
  pname = "vitepress";
  version = "1.5.0";
in
buildNpmPackage (
  outputs.lib.npmArgs {
    inherit
      fetchurl
      lib
      pname
      version
      ;

    hash = "sha256-ahtABhB9ar2gVLV8M1AXtmquX6k6a1QXVTp6D8T23LA=";
    json.hash = "sha256-pBaW54MTbki5NHlPvEMH6P70S5aCzcCOH+PH2fR83EU=";
    lock.hash = "sha256-B7NV7iYuk+J5QgSnq6Xslt/KY8ki+xqkweS2BDdKxms=";

    npmDepsHash = "sha256-Wr5mWXtfebbTG9X4lsO4olH0asyFzxB7IzLoGkN6A+0=";

    meta = {
      broken = true;
      mainProgram = "vitepress";
    };
  }
)
