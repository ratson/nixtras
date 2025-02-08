{
  glib,
  procps,
  inputs',
  sources,
  ...
}:

inputs'.nixpkgs.legacyPackages.profile-sync-daemon.overrideAttrs (oldAttrs: {
  version = "6.51";

  src = sources.profile-sync-daemon;

  installPhase =
    oldAttrs.installPhase
    + ''
      substituteInPlace $out/bin/profile-sync-daemon \
       --replace "gdbus" "${glib}/bin/gdbus" \
       --replace " psd-overlay-helper" " $out/bin/psd-overlay-helper" \
       --replace "pkill" "${procps}/bin/pkill" \
       --replace "pgrep" "${procps}/bin/pgrep"

      substituteInPlace $out/bin/psd-suspend-sync \
        --replace "/usr" "$out" \
        --replace "gdbus " "${glib}/bin/gdbus "
    '';

  meta.mainProgram = "profile-sync-daemon";
})
