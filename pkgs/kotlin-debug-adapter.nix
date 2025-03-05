{ stdenv, fetchzip, ... }:

stdenv.mkDerivation rec {
  pname = "kotlin-debug-adapter";
  version = "0.4.4";

  src = fetchzip {
    url = "https://github.com/fwcd/kotlin-debug-adapter/releases/download/${version}/adapter.zip";
    hash = "sha256-gNbGomFcWqOLTa83/RWS4xpRGr+jmkovns9Sy7HX9bg=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{bin,libexec}
    cp -a . "$out/libexec/${pname}"
    ln -s "$out/libexec/${pname}/bin/${pname}" "$out/bin/${pname}"

    runHook postInstall
  '';
}
