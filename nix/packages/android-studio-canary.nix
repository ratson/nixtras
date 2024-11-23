{ inputs
, callPackage
, makeFontsConf
, buildFHSEnv
, tiling_wm ? false
, ...
}:

let
  mkStudio = opts: callPackage (import "${inputs.nixpkgs}/pkgs/applications/editors/android-studio/common.nix" opts) {
    fontsConf = makeFontsConf { fontDirectories = [ ]; };
    inherit buildFHSEnv;
    inherit tiling_wm;
  };
in
mkStudio {
  channel = "canary";
  pname = "android-studio-canary";
  version = "2024.3.1.3";
  sha256Hash = "sha256-b6HEwHSnNm9ltrfWFepjqoxWQG5Awa3oxlBKeZKnv2g=";
}
