{
  fetchurl,
  firefox-devedition-bin-unwrapped,
  stdenv,
  wrapFirefox,
  ...
}:

let
  inherit (stdenv.hostPlatform) system;
  version = "139.0b4";
  mozSystem =
    ({
      x86_64-linux = "linux-x86_64";
    }).${system};
  hashes = {
    x86_64-linux = "sha256-jM22ImmoIXLR8M+jZ/q0e9VJqpmW0pc2Oa/s1XcnfyA=";
  };
  wmClass = "firefox-aurora";
in
(wrapFirefox
  (firefox-devedition-bin-unwrapped.overrideAttrs (_: {
    inherit version;
    src = fetchurl {
      url = "https://download-installer.cdn.mozilla.net/pub/devedition/releases/${version}/${mozSystem}/en-US/firefox-${version}.tar.xz";
      hash = hashes.${system};
    };
  }))
  {
    inherit wmClass;
    pname = "firefox-devedition-bin";
  }
).overrideAttrs
  (prev: {
    buildCommand =
      prev.buildCommand
      + ''
        wrapProgram $out/bin/firefox-developer-edition \
          --add-flags "--name=${wmClass}"
      '';
  })
