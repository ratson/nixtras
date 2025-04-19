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
  version = "2025.1.1.7";
  sha256Hash = "sha256-RQOmTzmk0el8WXE3cnSBCnpginFk0bK45Aij7eil1uM=";
}
