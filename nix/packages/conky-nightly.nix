{ inputs, inputs', inputVersion, gperf, ... }:

inputs'.nixpkgs.legacyPackages.conky.overrideAttrs (oldAttrs: {
  version = inputVersion inputs.conky;

  src = inputs.conky;

  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ gperf ];
})
