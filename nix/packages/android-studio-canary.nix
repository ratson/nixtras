{ inputs
, callPackage
, makeFontsConf
, gnome2
, buildFHSEnv
, tiling_wm ? false
, ...
}:

let
  mkStudio = opts: callPackage (import "${inputs.nixpkgs}/pkgs/applications/editors/android-studio/common.nix" opts) {
    fontsConf = makeFontsConf { fontDirectories = [ ]; };
    inherit (gnome2) GConf gnome_vfs;
    inherit buildFHSEnv;
    inherit tiling_wm;
  };
in
mkStudio {
  channel = "canary";
  pname = "android-studio-canary";
  version = "2024.1.2.8";
  sha256Hash = "sha256-2wqZV0UqZHprfUFvhWh0IdA9TQcwlZtWECZVwZ47ICc=";
}
