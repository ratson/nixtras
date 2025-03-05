{
  lib,
  fetchFromGitHub,
  pkg-config,
  rustPlatform,
  udev,
}:

let
  src = fetchFromGitHub {
    owner = "waycrate";
    repo = "swhkd";
    rev = "533295f2c864544c9a3e8176f4d6a44402118df3";
    hash = "sha256-EZcBmF1QZa3QBXSJXZXJCbLwBxmj1qjs9Ld/+7msP74=";
  };
in
rustPlatform.buildRustPackage {
  inherit src;

  pname = "swhkd-nightly";
  version = "1.2.1";

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

  meta = {
    description = "Sxhkd clone for Wayland (works on TTY and X11 too)";
    homepage = "https://github.com/waycrate/swhkd";
    license = lib.licenses.bsd2;
  };
}
