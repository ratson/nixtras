{ fetchFromGitHub, inputs', ... }:

let
  src = fetchFromGitHub {
    owner = "rvaiya";
    repo = "keyd";
    rev = "393d341464fe567515e767bfae8167a38fa6fb3d";
    hash = "sha256-Csllis4Kl2/4E0yQVk/46ASX8fKIWECmH0rCOHhzxLg=";
  };
in
inputs'.nixpkgs.legacyPackages.keyd.overrideAttrs (attrs: {
  inherit src;

  version = "2.4.3";

  postPatch = ''
    substituteInPlace Makefile --replace /usr/local ""
  '';
})
