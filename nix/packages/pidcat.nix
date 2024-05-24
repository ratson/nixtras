{ stdenv, installShellFiles, lib, python312, android-tools, inputs, ... }:

stdenv.mkDerivation rec {
  pname = "pidcat";
  version = "2.1.0";

  src = inputs.pidcat;

  nativeBuildInputs = [ installShellFiles ];

  postPatch = ''
    substituteInPlace pidcat.py \
          --replace 'python ' '${lib.getExe python312} ' \
          --replace "'adb'" "'${android-tools}/bin/adb'" \
          --replace "linebuf.encode('utf-8')" 'linebuf'
  '';

  installPhase = ''
    runHook preInstall
    install -D -m 755 pidcat.py $out/bin/${pname}
    installShellCompletion --bash bash_completion.d/pidcat
    installShellCompletion --zsh zsh-completion/_pidcat
    runHook postInstall
  '';
}
