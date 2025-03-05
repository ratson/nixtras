{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }@inputs:
    let
      inherit (nixpkgs) lib;

      forAllSystems = lib.genAttrs lib.systems.flakeExposed;

      pkgsFor = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in
    {
      lib.npmArgs = import ./lib/npmArgs.nix;

      packages = forAllSystems (
        system:
        let
          pkgs = pkgsFor.${system};
          callArgs = {
            inherit inputs;
            pkgs' = pkgs;
          };
          packages = lib.makeScope pkgs.newScope (
            self:
            callArgs
            // lib.packagesFromDirectoryRecursive {
              callPackage = self.callPackage;
              directory = ./pkgs;
            }
          );
        in
        builtins.removeAttrs packages (
          [
            "callPackage"
            "newScope"
            "overrideScope"
            "packages"
          ]
          ++ builtins.attrNames callArgs
        )
      );
    };
}
