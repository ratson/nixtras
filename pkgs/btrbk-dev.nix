{
  fetchFromGitHub,
  pkgs',
  ...
}:

pkgs'.btrbk.overrideAttrs (_: {
  version = "0.33.0-dev";

  src = fetchFromGitHub {
    owner = "digint";
    repo = "btrbk";
    rev = "18ddc659790de489967c2c82213fb5fba7955d40";
    hash = "sha256-JgUDT6Wme4EiSVFu4NRGuYJ3UckWwUHgT/NYlsIxCFc=";
  };
})
