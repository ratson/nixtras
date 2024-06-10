{ lib, stdenv, inputs, imagemagick, makeWrapper, ... }:

stdenv.mkDerivation rec {
  pname = "svg-to-icons";
  version = "0.0.1";

  src = inputs.svg-to-icons;

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

  meta = with lib; {
    homepage = "https://launchpad.net/cpu-checker";
    description = "Convert an SVG file into multiple PNG files";
    license = licenses.mit;
    mainProgram = "svg-to-icons";
  };
}
