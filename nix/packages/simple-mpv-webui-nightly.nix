{ fetchFromGitHub, mpvScripts, ... }:

mpvScripts.simple-mpv-webui.overrideAttrs (attrs: {
  src = fetchFromGitHub {
    owner = "open-dynaMIX";
    repo = "simple-mpv-webui";
    rev = "3c753450dd827d11eb6b6b8ff926e55af850478d";
    hash = "sha256-oUtpqR9r1hq4U41P/n6QZQ5m4b4QWFmgGKCPC0c3dmc=";
  };

  installPhase = ''
    mkdir -p $out/share/mpv/scripts/webui
    cp -r main.lua webui-page $out/share/mpv/scripts/webui/
  '';

  passthru.scriptName = "webui/main.lua";
})
