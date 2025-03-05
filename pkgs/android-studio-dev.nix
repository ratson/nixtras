{
  inputs,
  callPackage,
  makeFontsConf,
  buildFHSEnv,
  tiling_wm ? false,
  ...
}:

let
  mkStudio =
    opts:
    callPackage (import "${inputs.nixpkgs}/pkgs/applications/editors/android-studio/common.nix" opts) {
      fontsConf = makeFontsConf { fontDirectories = [ ]; };
      inherit buildFHSEnv;
      inherit tiling_wm;
    };
in
mkStudio {
  channel = "dev";
  pname = "android-studio-dev";
  version = "2024.3.2.7";
  sha256Hash = "sha256-RENjqoPdq3iYrF1q8QcjrXVBG8xNQrV+Vq9dj0Z/Im8=";
}
