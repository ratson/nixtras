{ fetchurl, inputs', ... }:

let
  version = "1.2.10";
in
inputs'.nixpkgs.legacyPackages.quickgui.overrideAttrs (oldAttrs: {
  inherit version;

  src = fetchurl {
    url = "https://github.com/quickemu-project/quickgui/releases/download/${version}/quickgui-${version}+1-linux.deb";
    hash = "sha256-UGMT5YDgabfC2vhZT8rwCkS8SeV4UQL2rDWeqiDDwZM=";
  };
})
