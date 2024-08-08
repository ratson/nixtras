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
  version = "2024.2.1.1";
  sha256Hash = "sha256-sQS3jBLWuUyR1jP9PEg9Kf0AWSXSWTcTJWW+6kYIJP8=~";
}
