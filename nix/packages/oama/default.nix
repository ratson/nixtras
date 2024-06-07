{ inputs, inputVersion, haskellPackages, ... }:

(haskellPackages.callPackage ./oama.nix {
  inherit inputVersion;

  input = inputs.oama;
}).overrideScope (final: prev: {
  http2 = final.http2_3_0_3;
  warp = final.warp_3_3_30;
})
