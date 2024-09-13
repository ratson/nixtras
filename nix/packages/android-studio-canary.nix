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
  version = "2024.2.2.2";
  sha256Hash = "sha256-TSjKJ4gAqZlycMP1or8MV+Il+KOQJL/F1kUKQr6/rSw=";
}
