{ lib
, rustPlatform
, clangStdenv
, linkFarm
, fetchgit
, runCommand
, gn
, neovim
, ninja
, makeWrapper
, pkg-config
, python3
, removeReferencesTo
, xcbuild
, SDL2
, fontconfig
, xorg
, stdenv
, darwin
, libglvnd
, libxkbcommon
, enableWayland ? stdenv.hostPlatform.isLinux
, wayland
, inputs
, inputVersion
}:

rustPlatform.buildRustPackage.override { stdenv = clangStdenv; } rec {
  pname = "neovide-nightly";
  version = inputVersion inputs.neovide;

  src = inputs.neovide;

  cargoLock.lockFile = "${src}/Cargo.lock";

  SKIA_SOURCE_DIR =
    let
      repo = inputs.neovide-skia;
      externals = linkFarm "skia-externals" (lib.mapAttrsToList
        (name: value: { inherit name; path = fetchgit value; })
        (lib.importJSON ./skia-externals.json));
    in
    runCommand "source" { } ''
      cp -R --no-preserve=mode,ownership ${repo} $out
      ln -s ${externals} $out/third_party/externals
    ''
  ;

  SKIA_GN_COMMAND = "${gn}/bin/gn";
  SKIA_NINJA_COMMAND = "${ninja}/bin/ninja";

  nativeBuildInputs = [
    makeWrapper
    pkg-config
    python3 # skia
    removeReferencesTo
  ] ++ lib.optionals stdenv.hostPlatform.isDarwin [ xcbuild ];

  nativeCheckInputs = [ neovim ];

  buildInputs = [
    SDL2
    fontconfig
    rustPlatform.bindgenHook
  ] ++ lib.optionals stdenv.hostPlatform.isDarwin [
    darwin.apple_sdk.frameworks.AppKit
  ];

  postFixup =
    let
      libPath = lib.makeLibraryPath ([
        libglvnd
        libxkbcommon
        xorg.libXcursor
        xorg.libXext
        xorg.libXrandr
        xorg.libXi
      ] ++ lib.optionals enableWayland [ wayland ]);
    in
    ''
      # library skia embeds the path to its sources
      remove-references-to -t "$SKIA_SOURCE_DIR" \
        $out/bin/neovide

      wrapProgram $out/bin/neovide \
        --prefix LD_LIBRARY_PATH : ${libPath}
    '';

  postInstall = lib.optionalString stdenv.hostPlatform.isDarwin ''
    mkdir -p $out/Applications
    cp -r extra/osx/Neovide.app $out/Applications
    ln -s $out/bin $out/Applications/Neovide.app/Contents/MacOS
  '' + lib.optionalString stdenv.hostPlatform.isLinux ''
    for n in 16x16 32x32 48x48 256x256; do
      install -m444 -D "assets/neovide-$n.png" \
        "$out/share/icons/hicolor/$n/apps/neovide.png"
    done
    install -m444 -Dt $out/share/icons/hicolor/scalable/apps assets/neovide.svg
    install -m444 -Dt $out/share/applications assets/neovide.desktop
  '';

  disallowedReferences = [ SKIA_SOURCE_DIR ];

  meta = with lib; {
    description = "This is a simple graphical user interface for Neovim";
    mainProgram = "neovide";
    homepage = "https://github.com/neovide/neovide";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ ck3d ];
    platforms = platforms.linux ++ [ "aarch64-darwin" ];
  };
}
