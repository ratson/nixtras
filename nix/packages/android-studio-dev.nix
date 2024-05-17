{ inputs, callPackage, makeFontsConf, gnome2, buildFHSEnv, tiling_wm ? false, ... }:

let
  mkStudio = opts: callPackage (import "${inputs.nixpkgs}/pkgs/applications/editors/android-studio/common.nix" opts) {
    fontsConf = makeFontsConf {
      fontDirectories = [ ];
    };
    inherit (gnome2) GConf gnome_vfs;
    inherit buildFHSEnv;
    inherit tiling_wm;
  };
in
  mkStudio {
    channel = "dev";
    pname = "android-studio-dev";
    version = "2024.1.2.2";
    sha256Hash = "sha256-nE31AsnieFwheu+T2M0N8fW8Vvj8jUQq03z93WAy2SI=";
  }
