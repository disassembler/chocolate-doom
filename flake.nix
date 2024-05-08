{
  description = "Chocolate Doom";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
    nix-inclusive.url = "github:input-output-hk/nix-inclusive";
  };

  outputs = { self, nixpkgs, flake-utils, nix-inclusive, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowBroken = true; };
      in
      {
        packages.doom = pkgs.callPackage ./default.nix {
          incl = nix-inclusive.lb.inclusive;
        };
        devShells = {
          default = pkgs.mkShell { buildInputs = [ pkgs.pre-commit ]; };
        };
      });
}
