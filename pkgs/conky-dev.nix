{
  fetchFromGitHub,
  gperf,
  pkgs',
  ...
}:

let
  version = "1.21.8";
in
pkgs'.conky.overrideAttrs (prev: {
  inherit version;

  src = fetchFromGitHub {
    owner = "brndnmtthws";
    repo = "conky";
    rev = "v${version}";
    hash = "sha256-bKWy/vWqHXqE3q8N3V6HV7/EKIOZ7CwTHgQ8btYkOvM=";
  };

  nativeBuildInputs = prev.nativeBuildInputs ++ [ gperf ];
})
