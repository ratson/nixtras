{ inputs, inputs', inputVersion, ... }:

inputs'.nixpkgs.legacyPackages.keyd.overrideAttrs (attrs: {
  version = inputVersion inputs.keyd;

  src = inputs.keyd;

  postPatch = ''
    substituteInPlace Makefile --replace /usr/local ""
  '';
})
