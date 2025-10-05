{
  description = "wgunderwood.github.io";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    with flake-utils.lib;
      eachSystem allSystems (system: let
        pkgs = nixpkgs.legacyPackages.${system};
        ruby = pkgs.ruby;
        gems = pkgs.bundlerEnv {
        name = "wgunderwood.github.io";
        inherit ruby;
        gemdir = ./.;
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.bundix
            gems
            ruby
          ];
        };
      });
}
