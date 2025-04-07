{
  fetchFromGitHub,
  webkitgtk_4_1,
  pkgs',
  ...
}:

let
  version = "3.0.0-dev";
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
        rev = "421b75ef21f09a5e303e167abdbe31495e57a3e2";
        hash = "sha256-XMrddtlS36lDYlb6aE4K1A2nYogt7yRk/IQSRLg5CEk=";
      }
      + "/v3";

    vendorHash = "sha256-PA2lJiMGRLjw607jcU3kiCS+tYsroDACfVBzo3IG+qk=";

    subPackages = [ "cmd/wails3" ];

    postFixup = builtins.replaceStrings [ "bin/wails" ] [ "bin/wails3" ] prev.postFixup;

    meta.mainProgram = "wails3";
  })
