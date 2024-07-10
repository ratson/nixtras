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
    cmake-lint = {
      url = "github:cmake-lint/cmake-lint";
      flake = false;
    };
    conky = {
      url = "github:brndnmtthws/conky";
      flake = false;
    };
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
    oama = {
      url = "github:pdobsan/oama";
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
    svg-to-icons = {
      url = "github:William-Owen/svg-to-icons";
      flake = false;
    };
  };
}
