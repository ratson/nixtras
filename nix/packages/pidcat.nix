{ fetchFromGitHub, stdenv, installShellFiles, lib, python312, android-tools, ... }:

stdenv.mkDerivation rec {
  pname = "pidcat";
  version = "2.1.0";

  src = fetchFromGitHub {
    owner = "JakeWharton";
    repo = "pidcat";
    rev = "61cd1ee1beabfa14eb5fbe21eb90c192d96aebc5";
    hash = "sha256-exswTRhx89W22tynerd5Bg0Q4BxhV0KC05a+VCEqmL4=";
  };

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
