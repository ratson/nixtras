{ fetchFromGitHub, inputs', gperf, ... }:

let
  version = "1.21.8";
in
inputs'.nixpkgs.legacyPackages.conky.overrideAttrs (oldAttrs: {
  inherit version;

  src = fetchFromGitHub {
    owner = "brndnmtthws";
    repo = "conky";
    rev = "v${version}";
    hash = "sha256-bKWy/vWqHXqE3q8N3V6HV7/EKIOZ7CwTHgQ8btYkOvM=";
  };

  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ gperf ];
})
