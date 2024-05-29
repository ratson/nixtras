{ buildNpmPackage, fetchurl, ... }:

buildNpmPackage rec {
  pname = "markdown-toc";
  version = "1.3.0";
  src = fetchurl {
    url = "https://registry.npmjs.org/@frat/${pname}/-/${pname}-${version}.tgz";
    hash = "sha256-z1GDzX5v5ugYSzj3SV/Vlva3X/HcZPIRsZGdESfRCU8=";
  };

  lockfile = fetchurl {
    url = "https://github.com/ratson/${pname}/releases/download/v${version}/package-lock.json";
    hash = "sha256-+4mtuoe/Jqt9/TEqp4AFJsK4yBM8cJ36H7rkOnvyRnM=";
  };

  dontNpmBuild = true;
  npmDepsHash = "sha256-Pp+8Ib3ilyzYX5Pn2TVkCLcN6nTWzViI5BIhN3zVCFU=";

  postPatch = ''
    cp "${lockfile}" ./package-lock.json
  '';
}
