{
  outputs =
    { conflake, ... }@inputs:
    conflake ./. {
      inherit inputs;

      _module.args = {
        sources = conflake.lib.flake.lock2inputs ./sources/flake.lock;
      };
    };

  inputs = {
    conflake = {
      url = "github:ratson/conflake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
}
