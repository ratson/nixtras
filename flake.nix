{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, self, ... }@inputs:
    let
      inherit (nixpkgs) lib;

      genSystems = lib.genAttrs lib.systems.flakeExposed;
      pkgsFor = nixpkgs.legacyPackages;
    in
    {
      lib.npmArgs = import ./lib/npmArgs.nix;

      overlays.default =
        _: prev:
        let
          callArgs = {
            inherit inputs;
            pkgs' = prev;
          };
          packages = lib.makeScope prev.newScope (
            self:
            callArgs
            // lib.packagesFromDirectoryRecursive {
              callPackage = self.callPackage;
              directory = ./pkgs;
            }
          );
          blacklist = [
            "callPackage"
            "newScope"
            "overrideScope"
            "packages"
          ] ++ builtins.attrNames callArgs;
        in
        builtins.removeAttrs packages blacklist;

      packages = genSystems (system: self.overlays.default null pkgsFor.${system});
    };
}
