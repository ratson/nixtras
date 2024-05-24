{ mpvScripts, inputs, inputVersion, ... }:

mpvScripts.simple-mpv-webui.overrideAttrs (attrs: {
  version = inputVersion inputs.simple-mpv-webui;

  src = inputs.simple-mpv-webui;

  installPhase = ''
    mkdir -p $out/share/mpv/scripts/webui
    cp -r main.lua webui-page $out/share/mpv/scripts/webui/
  '';

  passthru.scriptName = "webui/main.lua";
})
