{
  fetchFromGitHub,
  glib,
  procps,
  inputs',
  ...
}:

inputs'.nixpkgs.legacyPackages.profile-sync-daemon.overrideAttrs (oldAttrs: {
  version = "6.51";

  src = fetchFromGitHub {
    owner = "graysky2";
    repo = "profile-sync-daemon";
    rev = "cd8c2a37f152bd2bde167a0e066085ac23bc17d9";
    hash = "sha256-+4VHOJryoNodJvx5Ug2TX7/T3OsFW5VwxaL9WUcp8xA=";
  };

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
