{
  outputs = { flakelight, ... }@inputs:
    flakelight ./. {
      inherit inputs;
    };

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flakelight = {
      url = "github:nix-community/flakelight";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
