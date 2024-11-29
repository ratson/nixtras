{
  lib,
  fetchFromGitHub,
  rustPlatform,
  clangStdenv,
  linkFarm,
  fetchgit,
  runCommand,
  gn,
  neovim,
  ninja,
  makeWrapper,
  pkg-config,
  python3,
  removeReferencesTo,
  xcbuild,
  SDL2,
  fontconfig,
  xorg,
  stdenv,
  darwin,
  libglvnd,
  libxkbcommon,
  enableWayland ? stdenv.hostPlatform.isLinux,
  wayland,
}:

let
  src = fetchFromGitHub {
    owner = "neovide";
    repo = "neovide";
    rev = "f9e4f8e160f1d3dcc2a7c272ec2a4bad7568363c";
    hash = "sha256-JedMppG2c/QqdR4kkEJLYTKsIgtowCfV18azPUnz/ME=";
  };
  SKIA_SOURCE_DIR =
    let
      repo = fetchFromGitHub {
        owner = "rust-skia";
        repo = "skia";
        rev = "m131-0.79.1";
        hash = "sha256-XqXfKNYSiECbN96WVWA67Vy4sPuVvg6KqHESjA8gFJM=";
      };
      externals = linkFarm "skia-externals" (
        lib.mapAttrsToList (name: value: {
          inherit name;
          path = fetchgit value;
        }) (lib.importJSON ./skia-externals.json)
      );
    in
    runCommand "source" { } ''
      cp -R --no-preserve=mode,ownership ${repo} $out
      ln -s ${externals} $out/third_party/externals
    '';
in
rustPlatform.buildRustPackage.override { stdenv = clangStdenv; } {
  inherit src SKIA_SOURCE_DIR;

  pname = "neovide-nightly";
  version = "0.13.3-unstable-2024-11-20";

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  SKIA_GN_COMMAND = "${gn}/bin/gn";
  SKIA_NINJA_COMMAND = "${ninja}/bin/ninja";

  nativeBuildInputs = [
    makeWrapper
    pkg-config
    python3 # skia
    removeReferencesTo
  ] ++ lib.optionals stdenv.hostPlatform.isDarwin [ xcbuild ];

  nativeCheckInputs = [ neovim ];

  buildInputs =
    [
      SDL2
      fontconfig
      rustPlatform.bindgenHook
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      darwin.apple_sdk.frameworks.AppKit
    ];

  postFixup =
    let
      libPath = lib.makeLibraryPath (
        [
          libglvnd
          libxkbcommon
          xorg.libXcursor
          xorg.libXext
          xorg.libXrandr
          xorg.libXi
        ]
        ++ lib.optionals enableWayland [ wayland ]
      );
    in
    ''
      # library skia embeds the path to its sources
      remove-references-to -t "$SKIA_SOURCE_DIR" \
        $out/bin/neovide

      wrapProgram $out/bin/neovide \
        --prefix LD_LIBRARY_PATH : ${libPath}
    '';

  postInstall =
    lib.optionalString stdenv.hostPlatform.isDarwin ''
      mkdir -p $out/Applications
      cp -r extra/osx/Neovide.app $out/Applications
      ln -s $out/bin $out/Applications/Neovide.app/Contents/MacOS
    ''
    + lib.optionalString stdenv.hostPlatform.isLinux ''
      for n in 16x16 32x32 48x48 256x256; do
        install -m444 -D "assets/neovide-$n.png" \
          "$out/share/icons/hicolor/$n/apps/neovide.png"
      done
      install -m444 -Dt $out/share/icons/hicolor/scalable/apps assets/neovide.svg
      install -m444 -Dt $out/share/applications assets/neovide.desktop
    '';

  disallowedReferences = [ SKIA_SOURCE_DIR ];

  meta = {
    description = "This is a simple graphical user interface for Neovim";
    mainProgram = "neovide";
    homepage = "https://github.com/neovide/neovide";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
