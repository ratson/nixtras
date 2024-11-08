{ lib, fetchFromGitHub, stdenv, imagemagick, makeWrapper, ... }:

stdenv.mkDerivation rec {
  pname = "svg-to-icons";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "William-Owen";
    repo = "svg-to-icons";
    rev = "9b0d89e0cf6de432294b195656b4ac750e3821e9";
    hash = "sha256-H1H344ldyDeUui2j+sRWmEOIrTVltfljZ7wiYZe7reI=";
  };

  nativeBuildInputs = [ makeWrapper ];

  postPatch = ''
    substituteInPlace svg-to-icons.sh \
      --replace "#!/bin/bash" "#!/bin/bash -e" \
      --replace "16 48 128" "16 48 96 128"
  '';

  installPhase = ''
    runHook preInstall
    install -D -m 755 svg-to-icons.sh $out/bin/${pname}
    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/${pname} \
      --prefix PATH : ${lib.makeBinPath [ imagemagick ]}
  '';

  meta = {
    homepage = "https://launchpad.net/cpu-checker";
    description = "Convert an SVG file into multiple PNG files";
    license = lib.licenses.mit;
    mainProgram = "svg-to-icons";
  };
}
