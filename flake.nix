{
  outputs = { flakelight, ... }@inputs:
    flakelight ./. {
      inherit inputs;
    };

  inputs = {
    flakelight = {
      url = "github:nix-community/flakelight";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
}
