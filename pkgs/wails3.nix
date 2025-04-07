{
  fetchFromGitHub,
  webkitgtk_4_1,
  pkgs',
  ...
}:

let
  version = "3.0.0-alpha.9";
in
(pkgs'.wails.override {
  webkitgtk_4_0 = webkitgtk_4_1;
}).overrideAttrs
  (prev: {
    inherit version;

    pname = "wails3";

    src =
      fetchFromGitHub {
        owner = "wailsapp";
        repo = "wails";
        rev = "v${version}";
        hash = "sha256-3sXR3dPpMU9S01/STTzKvju8Pvkq4+Ve7Fo2eMKsYN0=";
      }
      + "/v3";

    vendorHash = "sha256-yU/v0fDw7OoF51JkHzN8jFw3eG4nA42TD6kuuLF65jw=";

    subPackages = [ "cmd/wails3" ];

    postFixup = builtins.replaceStrings [ "bin/wails" ] [ "bin/wails3" ] prev.postFixup;

    meta.mainProgram = "wails3";
  })
