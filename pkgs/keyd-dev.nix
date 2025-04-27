{ fetchFromGitHub, pkgs', ... }:

let
  src = fetchFromGitHub {
    owner = "rvaiya";
    repo = "keyd";
    rev = "0cbe717b63c73de7872013b0834d90d802047546";
    hash = "sha256-NfdOjLgMU7CJup2MeBaK/uADVyfWPNLGPNm3ahwqrRY=";
  };
  shortRev = builtins.substring 0 7 src.rev;
  version = "2.5.0+${shortRev}";
in
pkgs'.keyd.overrideAttrs (attrs: {
  inherit src version;

  postPatch = ''
    substituteInPlace Makefile --replace /usr/local ""
  '';
})
