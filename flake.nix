{
  outputs = { flakelight, ... }@inputs:
    flakelight ./. {
      inherit inputs;

      withOverlays = final: prev: {
        inputVersion = input:
          "${builtins.substring 0 8 input.lastModifiedDate}.${input.shortRev}";
      };
    };

  inputs = {
    flakelight = {
      url = "github:nix-community/flakelight";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    keyd = {
      url = "github:rvaiya/keyd";
      flake = false;
    };
    neovide = {
      url = "github:neovide/neovide";
      flake = false;
    };
    neovide-skia = {
      url = "github:rust-skia/skia/m124-0.72.3";
      flake = false;
    };
    pidcat = {
      url = "github:JakeWharton/pidcat";
      flake = false;
    };
    simple-mpv-webui = {
      url = "github:open-dynaMIX/simple-mpv-webui";
      flake = false;
    };
  };
}
