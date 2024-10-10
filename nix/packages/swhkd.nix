{ lib
, pkg-config
, rustPlatform
, udev
, inputs
, inputVersion
}:

let
  src = inputs.swhkd;
in
rustPlatform.buildRustPackage {
  inherit src;

  pname = "swhkd-nightly";
  version = inputVersion src;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "sweet-0.3.0" = "sha256-swSE1CE39cGojp8HAziw0Bzjr+s4XaVU+4OqQDO60fE=";
    };
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ udev ];

  postBuild = ''
    $src/scripts/build-polkit-policy.sh \
      --swhkd-path=$out/bin/swhkd
  '';

  postInstall = ''
    install -D ./com.github.swhkd.pkexec.policy \
      -t $out/share/polkit-1/actions
  '';

  meta = with lib; {
    description = "Sxhkd clone for Wayland (works on TTY and X11 too)";
    homepage = "https://github.com/waycrate/swhkd";
    license = licenses.bsd2;
  };
}
